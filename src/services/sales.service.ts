import { Prisma } from "../prisma";
import prisma from "../config/prisma";

type DecimalLike = Prisma.Decimal | number | string;
type NumberLike = number | string | null | undefined;

export interface SalesOrderDetails {
  customer_id?: NumberLike;
  cashier_id: number | string;
  total_amount: DecimalLike;
  payment_method: string | null;
  reference: string | null;
  branch_id: string;
  rewards_points?: DecimalLike | null;
  product_count?: NumberLike;
  credit_payment?: DecimalLike | null;
}

export interface SalesProductLine {
  product_id: string;
  variant_id: string;
  quantity: number | string;
}

export interface InsertSalesPayload {
  order: SalesOrderDetails;
  products: SalesProductLine[];
}

const toDecimal = (value: DecimalLike | null | undefined): Prisma.Decimal => {
  if (value === null || value === undefined) {
    return new Prisma.Decimal(0);
  }
  if (Prisma.Decimal.isDecimal(value)) {
    return value;
  }
  return new Prisma.Decimal(value);
};

const toRequiredNumber = (value: NumberLike, fieldName: string): number => {
  if (value === null || value === undefined) {
    throw new Error(`Missing required field ${fieldName}`);
  }

  const numericValue = Number(value);
  if (Number.isNaN(numericValue)) {
    throw new Error(`Invalid number provided for ${fieldName}`);
  }

  return numericValue;
};

const toOptionalNumber = (value: NumberLike): number | null => {
  if (value === null || value === undefined) {
    return null;
  }

  const numericValue = Number(value);
  if (Number.isNaN(numericValue)) {
    throw new Error(`Invalid number provided: ${value}`);
  }

  return numericValue;
};

export const insertSalesData = async (salesData: InsertSalesPayload): Promise<number> => {
  const { order, products } = salesData;

  if (!order) {
    throw new Error("Sales data must include order details");
  }
  if (!Array.isArray(products)) {
    throw new Error("Sales data must include a products list");
  }

  const branchId = order.branch_id;
  if (!branchId) {
    throw new Error("Order branch_id is required");
  }

  const cashierId = toRequiredNumber(order.cashier_id, "order.cashier_id");
  const customerId = toOptionalNumber(order.customer_id);
  const paymentMethod = order.payment_method;
  const totalAmount = toDecimal(order.total_amount);
  const rewardsPoints = toDecimal(order.rewards_points ?? 0);
  const productCount = toOptionalNumber(order.product_count);
  const reference = order.reference ?? null;
  const credit = paymentMethod == "cash" ? toDecimal(reference).minus(totalAmount) : new Prisma.Decimal(0);
  const creditPayment = toDecimal(order.credit_payment ?? 0);

  if (credit.lessThan(0) && paymentMethod == "cash" && !customerId) {
    throw new Error("Customer is required for credit sales");
  }

  return await prisma.$transaction(async (tx) => {
    if (credit.lessThan(0) && customerId) {
      console.log("Credit Transaction", customerId, credit);
      await tx.customer.update({
        where: { customer_id: customerId },
        data: {
          credits: { increment: credit.abs() },
        },
      });
    }

    if (paymentMethod == "credit" && customerId && creditPayment.greaterThan(0)) {
      console.log("Credit Payment Transaction", customerId, creditPayment);
      await tx.customer.update({
        where: { customer_id: customerId },
        data: {
          credits: { decrement: creditPayment },
        },
      });
    }

    let profit = new Prisma.Decimal(0);
    for (const product of products) {
      const variantId = product.variant_id;
      const quantity = toRequiredNumber(product.quantity, "product.quantity");

      const variant = await tx.product_variants.findUnique({
        where: { variant_id: variantId },
        select: { retail_price: true, buying_price: true, discount: true },
      });

      if (!variant) {
        throw new Error(`Product variant not found for id: ${variantId}`);
      }

      const retailPrice = toDecimal(variant.retail_price);
      const costPrice = toDecimal(variant.buying_price);
      const discount = toDecimal(variant.discount ?? 0);
      const lineProfit = retailPrice.minus(discount).minus(costPrice).times(new Prisma.Decimal(quantity));
      profit = profit.plus(lineProfit);
    }

    const orderRecord = await tx.sales_history.create({
      data: {
        customer_id: customerId,
        cashier_id: cashierId,
        branch_id: branchId,
        total_amount: totalAmount,
        profit,
        payment_method: paymentMethod,
        reference,
        rewards_points: rewardsPoints,
        product_count: productCount,
      },
      select: { order_id: true },
    });

    const orderId = orderRecord.order_id;

    if (customerId !== null) {
      await tx.customer.update({
        where: { customer_id: customerId },
        data: {
          visit_count: { increment: 1 },
          rewards_points: { increment: rewardsPoints },
        },
      });
    }

    for (const product of products) {
      const productId = product.product_id;
      const variantId = product.variant_id;

      if (!productId) {
        throw new Error("Product product_id is required");
      }
      if (!variantId) {
        throw new Error("Product variant_id is required");
      }

      const quantity = toRequiredNumber(product.quantity, "product.quantity");

      const variant = await tx.product_variants.findUnique({
        where: { variant_id: variantId },
        select: { retail_price: true, discount: true },
      });

      if (!variant) {
        throw new Error(`Product variant not found for id: ${variantId}`);
      }

      const retailPrice = toDecimal(variant.retail_price);
      const discount = toDecimal(variant.discount ?? 0);
      const lineSubtotal = retailPrice.minus(discount).times(new Prisma.Decimal(quantity));

      await tx.cart.create({
        data: {
          order_id: orderId,
          product_id: productId,
          quantity,
          sub_total_amount: lineSubtotal,
        },
      });

      await tx.inventory.update({
        where: {
          product_id_branch_id: {
            product_id: productId,
            branch_id: branchId,
          },
        },
        data: {
          quantity: {
            decrement: quantity,
          },
        },
      });
    }

    return orderId;
  });
};
