// services/receipt.builder.ts
import prisma from "../config/prisma";
import type { IPrintPayload } from "./printer.service";
import { createCanvas } from "canvas";

export async function buildReceiptFromSale(salesData: any): Promise<IPrintPayload> {
  const order = salesData?.order ?? {};
  const productsPayload = salesData?.products ?? [];
  const branchId = salesData?.branch_id ?? order?.branch_id;
  const cashierId = order?.cashier_id ?? salesData?.cashier_id;
  const customerId = order?.customer_id ?? salesData?.customer_id;
  const paymentMethod = (order?.payment_method ?? salesData?.payment_method ?? "").toString().toLowerCase();

  const variantIds: string[] = productsPayload
      .map((p: any) => p.variant_id)
      .filter((v: any): v is string => typeof v === "string");

  const productIds: string[] = productsPayload
      .map((p: any) => p.product_id)
      .filter((v: any): v is string => typeof v === "string");

  const [variants, products, branch, cashier, customer] = await Promise.all([
    variantIds.length
      ? prisma.product_variants.findMany({
          where: { variant_id: { in: variantIds } },
          select: { variant_id: true, product_id: true, retail_price: true, discount: true },
        })
      : [],
    productIds.length
      ? prisma.product.findMany({
          where: { product_id: { in: productIds } },
          select: { product_id: true, product_name: true },
        })
      : [],
    branchId
      ? prisma.branch.findUnique({
          where: { branch_id: branchId },
          select: { branch_city: true, branch_address: true, branch_phone: true },
        })
      : null,
    cashierId
      ? prisma.employee.findUnique({
          where: { employee_id: cashierId },
          select: { employee_name: true },
        })
      : null,
    customerId
      ? prisma.customer.findUnique({
          where: { customer_id: customerId },
          select: { customer_name: true, rewards_points: true, credits: true },
        })
      : null,
  ]);

  const variantById = new Map(variants.map(v => [v.variant_id, v]));
  const productById = new Map(products.map(p => [p.product_id, p]));

  const LINE_WIDTH = 47;
  const fmt = (n: number) => (Number.isFinite(n) ? n.toFixed(2) : "0.00");

  const padLeft = (s: string, l: number) =>
    s.length >= l ? s.slice(-l) : " ".repeat(l - s.length) + s;

  const UNIT_W = 10, DISC_W = 10, QTY_W = 9, TOTAL_W = 10, SEP = "  ";

  const items = productsPayload
    .map((p: any) => {
      const qty = Number(p.quantity ?? 0);
      if (!qty) return null;

      const v = p.variant_id ? variantById.get(p.variant_id) : null;
      const prod = p.product_id ? productById.get(p.product_id) : null;

      const up = Number(v?.retail_price ?? p.unit_price ?? p.price ?? 0);
      const dp = Math.max(up - Number(v?.discount ?? p.discount ?? 0), 0);

      return {
        product_name: prod?.product_name ?? p.product_name ?? "Unnamed Product",
        qty,
        up,
        dp,
        total: dp * qty,
      };
    })
    .filter(Boolean) as any[];

  const subtotal = items.reduce((s, it) => s + it.total, 0);

  const discountTotal = items.reduce((s, it) => {
    const d = it.up - it.dp;
    return s + (d > 0 ? d * it.qty : 0);
  }, 0);

  const totalAmount = Number(
    order?.total_amount ?? subtotal - discountTotal
  ) || subtotal - discountTotal;

  let cashReceived = Number(order?.reference ?? 0);
  if (Number.isNaN(cashReceived)) cashReceived = 0;

  let creditPayment = Number(order?.credit_payment ?? 0);
  if (isNaN(creditPayment)) creditPayment = 0;

  const oldCredits = Number(customer?.credits ?? 0);

  let change = cashReceived - totalAmount - creditPayment;
  const isUnderpaidCash = paymentMethod === "cash" && totalAmount > cashReceived;

  let newCredits;
  if (isUnderpaidCash) {
    newCredits = oldCredits + (totalAmount - cashReceived);
    creditPayment = 0;
    change = 0;
  } else {
    newCredits = oldCredits - creditPayment;
    if (change < 0) change = 0;
  }

  const earnedPoints = Number(order?.rewards_points ?? 0);
  const oldPoints = Number(customer?.rewards_points ?? 0);
  const newPoints = oldPoints + earnedPoints;

  // Detect Sinhala characters (Unicode range U+0D80–U+0DFF)
  function hasSinhala(text: string): boolean {
    return /[\u0D80-\u0DFF]/.test(String(text ?? ""));
  }

  // Render a single line of text to a canvas and return ESC/POS raster bytes (GS v 0)
  function createTextRasterLine(text: string, opts?: { fontFamily?: string; fontSize?: number; widthPx?: number }) {
    const fontFamily = opts?.fontFamily ?? "Noto Sans Sinhala, Iskoola Pota, Arial";
    const fontSize = opts?.fontSize ?? 28;
    const widthPx = opts?.widthPx ?? 384; // typical width for 72mm @ ~203dpi, adjust if needed
    // TEMP canvas for measuring
    let tempCanvas = createCanvas(widthPx, fontSize * 2);
    let tempCtx = tempCanvas.getContext("2d");

    tempCtx.font = `${fontSize}px ${fontFamily}`;
    tempCtx.textBaseline = "top";

    const metrics = tempCtx.measureText(text);

    const ascent = metrics.actualBoundingBoxAscent || fontSize * 0.8;
    const descent = metrics.actualBoundingBoxDescent || fontSize * 0.2;

    // NEW height: exact bounding box + very small padding
    const height = Math.ceil(ascent + descent + 8); // ← reduce this if needed
    const canvas = createCanvas(widthPx, height);
    const ctx = canvas.getContext("2d");

    // white background
    ctx.fillStyle = "#FFFFFF";
    ctx.fillRect(0, 0, widthPx, height);

    // black text
    ctx.fillStyle = "#000000";
    ctx.font = `${fontSize}px ${fontFamily}`;
    ctx.textBaseline = "top";

    // draw
    ctx.fillText(text, 0, 0);

    // get image data
    const img = ctx.getImageData(0, 0, widthPx, height);
    const pixels = img.data; // RGBA

    // Convert to 1-bit per pixel bitmap (monochrome)
    const widthBytes = Math.ceil(widthPx / 8);
    const data: Buffer[] = [];

    for (let y = 0; y < height; y++) {
      const row = Buffer.alloc(widthBytes);
      for (let x = 0; x < widthPx; x++) {
        const i = (y * widthPx + x) * 4;
        const r = pixels[i], g = pixels[i + 1], b = pixels[i + 2];
        // luminance
        const lum = 0.299 * r + 0.587 * g + 0.114 * b;
        const byteIndex = Math.floor(x / 8);
        const bitIndex = 7 - (x % 8);
        if (lum < 127) {
          row[byteIndex] |= 1 << bitIndex; // black pixel
        }
      }
      data.push(row);
    }

    // ESC/POS raster header: GS v 0 m xL xH yL yH
    // m = 0 (normal)
    const xL = widthBytes & 0xff;
    const xH = (widthBytes >> 8) & 0xff;
    const yL = height & 0xff;
    const yH = (height >> 8) & 0xff;
    const header = Buffer.from([0x1d, 0x76, 0x30, 0x00, xL, xH, yL, yH]); // m=0

    const body = Buffer.concat(data);
    return Buffer.concat([header, body]);
  }

  // pushLine: if line contains Sinhala -> push raster raw bytes; else push normal text line
  function pushLine(linesArr: IPrintPayload["lines"], text: string, opts?: { align?: "L" | "C" | "R"; bold?: boolean }) {
    const str = String(text ?? "");
    if (hasSinhala(str)) {
      // choose widthPx according to LINE_WIDTH; common canvas widths: 384 for 72mm/203dpi
      const raster = createTextRasterLine(str, { fontSize: 30, widthPx: 384 });
      // push as raw buffer (printer.service.buildEscposBuffer must support 'raw' entries)
      linesArr.push({ raw: raster } as unknown as any);
    } else {
      linesArr.push({ text: str, align: opts?.align, bold: opts?.bold } as any);
    }
  }
  
  const lines: IPrintPayload["lines"] = [];

  const shopName = branch?.branch_city ?? "LAABA KADE STORES";
  lines.push({
    raw: Buffer.from([
      0x1b, 0x61, 0x01, // center
      0x1b, 0x45, 0x01, // bold on
      0x1d, 0x21, 0x11, // double width + double height
    ])
  } as any);
  lines.push({ text: shopName, align: "C", bold: true });
  lines.push({
    raw: Buffer.from([
      0x1d, 0x21, 0x00, // reset size
      0x1b, 0x45, 0x00, // bold off
      0x1b, 0x61, 0x00, // left
    ])
  } as any);

  if (branch?.branch_address) pushLine(lines, branch.branch_address, { align: "C" });
  if (branch?.branch_phone) pushLine(lines, `Tel: ${branch.branch_phone}`, { align: "C" });
  lines.push({ hr: true });
  
  const cashierName = cashier?.employee_name ?? "Unknown";
  const dateStr = new Date().toLocaleDateString();
  const timeStr = new Date().toLocaleTimeString();
  const lastSale = await prisma.sales_history.findFirst({
    orderBy: { created_at: "desc" },
    select: { order_id: true },
  });
  const invoiceNo = order?.order_id ?? lastSale?.order_id ?? "N/A";

  const lr = (l: string, r: string) =>
    l + " ".repeat(Math.max(1, LINE_WIDTH - l.length - r.length)) + r;
  pushLine(lines, lr(`Cashier: ${cashierName}`, dateStr));
  pushLine(lines, lr(`Invoice No: ${invoiceNo}`, timeStr));

  lines.push({ hr: true } as any);

  if (customer) pushLine(lines, `Customer: ${customer.customer_name}`);

  // Points & Credits (quad format)
  if (customer) {
    function quadFormat(leftLabel: string, leftValue: string, rightLabel: string, rightValue: string, width = LINE_WIDTH) {
      const half = Math.floor(width / 2);
      const maxLabel = Math.floor(half * 0.55);
      const maxValue = half - maxLabel - 1;

      const lblL = leftLabel.trim();
      const valL = leftValue.trim();
      const leftLbl = lblL.length > maxLabel ? lblL.slice(0, maxLabel) : leftLabel.padEnd(maxLabel, " ");
      const leftVal = valL.length > maxValue ? valL.slice(-maxValue) : valL.padStart(maxValue, " ");

      const lblR = rightLabel.trim();
      const valR = rightValue.trim();
      const rightLbl = lblR.length > maxLabel ? lblR.slice(0, maxLabel) : rightLabel.padEnd(maxLabel, " ");
      const rightVal = valR.length > maxValue ? valR.slice(-maxValue) : valR.padStart(maxValue, " ");

      return leftLbl + leftVal + " | " + rightLbl + rightVal;
    }

    // Points
    pushLine(lines, quadFormat("Points Earned:", fmt(earnedPoints), "Balance:", fmt(newPoints)));

    // Credits (bold)
    lines.push({ raw: Buffer.from([0x1B, 0x45, 0x01]) } as any); // bold on
    pushLine(lines, quadFormat("Credit Old:", fmt(oldCredits), "Credit New:", fmt(newCredits)));
    lines.push({ raw: Buffer.from([0x1B, 0x45, 0x00]) } as any); // bold off

    lines.push({ hr: true } as any);
  }


  // Header for items (dynamically aligned)
  const header =
    padLeft("U.Price", UNIT_W) +
    SEP +
    padLeft("D.Price", DISC_W) +
    SEP +
    padLeft("Qty", QTY_W) +
    SEP +
    padLeft("Total", TOTAL_W);
  pushLine(lines, header, { align: "L", bold: true });
  lines.push({ hr: true } as any);

  // Items
  for (const it of items) {
    // product name (wrap)
    let name = it.product_name;
    while (name.length) {
      const chunk = name.slice(0, LINE_WIDTH);
      pushLine(lines, chunk, { align: "L" });
      name = name.slice(LINE_WIDTH);
    }

    const row =
      padLeft(fmt(it.up), UNIT_W) +
      SEP +
      padLeft(fmt(it.dp), DISC_W) +
      SEP +
      padLeft(String(it.qty), QTY_W) +
      SEP +
      padLeft(fmt(it.total), TOTAL_W);

    pushLine(lines, row, { align: "L" });
  }
  lines.push({ hr: true } as any);

  // Summary (labels left, amounts right)
  const alignLR = (label: string, value: string) => {
    const left = "        " + label;
    const right = value + "       ";
    const totalLen = LINE_WIDTH;
    const gap = Math.max(1, totalLen - left.length - right.length);
    return left + " ".repeat(gap) + right;
  };

  pushLine(lines, alignLR("TOTAL:", fmt(totalAmount)), { bold: true });

  // CASH payment
  if (paymentMethod === "cash") {
    pushLine(lines, alignLR("Cash Received:", fmt(cashReceived)));
    pushLine(lines, alignLR("Change:", fmt(change)));
  }

  // CREDIT payment (Option A: always show all three)
  if (paymentMethod === "credit") {
    pushLine(lines, alignLR("Cash Received:", fmt(cashReceived)));
    pushLine(lines, alignLR("Credit Repayment:", fmt(creditPayment)));
    pushLine(lines, alignLR("Change:", fmt(change)));
  }

  pushLine(lines, alignLR("Payment:", paymentMethod.toUpperCase()));

  // Discount big (if any)
  if (discountTotal > 0) {
    lines.push({ hr: true } as any);
    pushLine(lines, `ඔබ ලැබූ ලාභය : ${fmt(discountTotal)}`, {  align: "C", bold: true });
    lines.push({ hr: true } as any);
  }

  pushLine(lines, "Thank you for shopping with us!", { align: "C" });
  lines.push({ text: " " } as any);
  lines.push({ text: " " } as any);

  return {
    lines,
    cut: true,
    openDrawer: false,
    codepage: "cp437",
  };
}
