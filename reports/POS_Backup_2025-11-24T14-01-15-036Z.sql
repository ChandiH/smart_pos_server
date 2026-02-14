--
-- PostgreSQL database dump
--

\restrict Ks4Hlc4vF3hOLbfv2p97FS8IRnxKhaVIH0TiFOW3IZT26laDpk3hWROdEBddVnL

-- Dumped from database version 18.1
-- Dumped by pg_dump version 18.1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA public;


--
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';


--
-- Name: branch_monthly_sales(text, uuid); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.branch_monthly_sales(target_month text, target_branch_id uuid) RETURNS TABLE(day text, total_sales numeric)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY (
        SELECT
            To_char( created_at::date,'YYYY-MM-DD') AS day,
            SUM(total_amount) AS total_sales
        FROM
            sales_history 
        WHERE
            branch_id = target_branch_id
            AND TO_CHAR(created_at, 'YYYY-MM') = target_month  
        GROUP BY
           To_char( created_at::date,'YYYY-MM-DD')
    );
END;
$$;


ALTER FUNCTION public.branch_monthly_sales(target_month text, target_branch_id uuid) OWNER TO postgres;

--
-- Name: get_sales_data_by_branch(uuid); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_sales_data_by_branch(id uuid) RETURNS TABLE(order_id integer, customer character varying, cashier_name character varying, branch_name character varying, created_time time without time zone, total numeric, payment_method character varying, total_quantity integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT

   s.order_id as order_id , 
   COALESCE(c.customer_name, 'Guest Customer') as customer,
   e.employee_name as cashier_name,
   b.branch_city as branch_name, 
   s.created_at::time(0) as time,
   s.total_amount::numeric(1000,2) as total,
   p.payment_method_name as payment_method,
   s.product_count::integer as total_quantity
   from sales_history s 
   left join
   customer c
   on 
   c.customer_id = s.customer_id	
   left join 
   branch b
   on
	   b.branch_id = s.branch_id
	   left join 
	   payment_method p
	   on  p.payment_method_id = s.payment_method_id
	   left join
	   employee e
	   on s.cashier_id = e.employee_id
	   
     where to_char(s.created_at, 'YYYY-MM-DD') = to_char(now()::date, 'YYYY-MM-DD')  
     and b.branch_id = id
   order by 
   s.order_id desc;
END;
$$;


ALTER FUNCTION public.get_sales_data_by_branch(id uuid) OWNER TO postgres;

--
-- Name: get_top_5_products_in_branch(uuid); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_top_5_products_in_branch(branch_id_input uuid) RETURNS TABLE(product_id uuid, total_quantity integer, product_name text, branch_id uuid, branch_city text)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT
        c.product_id,
        SUM(c.quantity) AS total_quantity,
        p.product_name::TEXT,
        sh.branch_id,
        b.branch_city::TEXT  
    FROM
        cart c
    JOIN
        sales_history sh ON c.order_id = sh.order_id
    LEFT JOIN
        product p ON p.product_id = c.product_id
    LEFT JOIN
        branch b ON b.branch_id = sh.branch_id
    WHERE
        DATE_TRUNC('month', sh.created_at) = DATE_TRUNC('month', CURRENT_DATE)
        AND sh.branch_id = branch_id_input
    GROUP BY
        c.product_id,
        p.product_name::TEXT,
        sh.branch_id,
        b.branch_city::TEXT
    ORDER BY
        total_quantity DESC
    LIMIT 5;
END;
$$;


ALTER FUNCTION public.get_top_5_products_in_branch(branch_id_input uuid) OWNER TO postgres;

--
-- Name: get_top_branch_sales(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_top_branch_sales(target_month text) RETURNS TABLE(branch_name character varying, current_month_sales numeric, previous_month_sales numeric)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    WITH CurrentMonthData AS (
        SELECT
            branch_id,
            TO_CHAR(created_at, 'yyyy-mm') AS year_month,
            SUM(total_amount) AS current_month_sales        FROM
            sales_history sh
        WHERE
            TO_CHAR(created_at, 'YYYY-MM') = target_month
        GROUP BY
            branch_id, TO_CHAR(created_at, 'yyyy-mm')
        ORDER BY
            current_month_sales desc
        LIMIT 3
    )
   SELECT
	b.branch_city as branch_name,
  cmd.current_month_sales,
    COALESCE(SUM(CASE WHEN TO_CHAR(sh.created_at, 'YYYY-MM') = TO_CHAR(TO_DATE(target_month, 'yyyy-mm') - INTERVAL '1 MONTH', 'YYYY-MM') THEN sh.total_amount ELSE 0 END), 0) AS previous_month_sales
	FROM
    CurrentMonthData cmd
LEFT JOIN
    sales_history sh ON cmd.branch_id = sh.branch_id
    AND TO_CHAR(sh.created_at, 'YYYY-MM') = TO_CHAR(TO_DATE(target_month,'yyyy-mm') - INTERVAL '1 MONTH', 'YYYY-MM')
left join
branch b
on b.branch_id = cmd.branch_id
GROUP BY
    cmd.branch_id, cmd.current_month_sales,TO_CHAR(sh.created_at, 'yyyy-mm'),b.branch_city
ORDER BY
    cmd.current_month_sales DESC
LIMIT 5;

END;
$$;


ALTER FUNCTION public.get_top_branch_sales(target_month text) OWNER TO postgres;

--
-- Name: insert_sales_data_and_update(jsonb); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.insert_sales_data_and_update(IN sales_data jsonb)
    LANGUAGE plpgsql
    AS $$
DECLARE
    order_data jsonb;
    items jsonb;
    item jsonb;
	
    order_number integer;
    branches_id uuid;
BEGIN
    order_data := sales_data->'order';
    INSERT INTO sales_history (order_id, customer_id, cashier_id, total_amount, profit, payment_method_id, reference_id,
    branch_id,rewards_points,product_count)
    SELECT
        (MAX(order_id) + 1),
        (order_data->>'customer_id')::integer,
        (order_data->>'cashier_id')::integer,
        (order_data->>'total_amount')::numeric,
        (order_data->>'profit')::numeric,
        (order_data->>'payment_method_id')::integer,
        (order_data->>'reference_id'),
        (order_data->>'branch_id')::uuid,
        (order_data->>'rewards_points')::numeric,
        (order_data->>'product_count')::integer
    FROM sales_history
    RETURNING order_id INTO order_number;

    IF (order_data->>'customer_id')::integer IS NOT NULL THEN
        UPDATE customer
        SET visit_count = visit_count + 1
        WHERE customer_id = (order_data->>'customer_id')::integer;
        UPDATE customer
        SET rewards_points = rewards_points +(order_data->>'rewards_points')::numeric
        WHERE customer_id =(order_data->>'customer_id')::integer;
    END IF;

    items := sales_data->'products';
    FOR item IN SELECT * FROM jsonb_array_elements(items)
    LOOP
        INSERT INTO cart (order_id, product_id, quantity)
        VALUES (
            order_number,
            (item->>'product_id')::uuid,
            (item->>'quantity')::integer
        );		
		UPDATE inventory
        SET quantity = quantity - (item->>'quantity')::integer
        WHERE product_id = (item->>'product_id')::uuid AND branch_id =  (order_data->>'branch_id')::uuid;
		UPDATE cart
        SET sub_total_amount = 
            (item->>'quantity')::numeric * (SELECT retail_price FROM product WHERE product_id = (item->>'product_id')::uuid) -
            (SELECT discount FROM product WHERE product_id = (item->>'product_id')::uuid)
        WHERE order_id = order_number AND product_id = (item->>'product_id')::uuid;
    END LOOP;
END;
$$;


ALTER PROCEDURE public.insert_sales_data_and_update(IN sales_data jsonb) OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: _prisma_migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public._prisma_migrations (
    id character varying(36) NOT NULL,
    checksum character varying(64) NOT NULL,
    finished_at timestamp with time zone,
    migration_name character varying(255) NOT NULL,
    logs text,
    rolled_back_at timestamp with time zone,
    started_at timestamp with time zone DEFAULT now() NOT NULL,
    applied_steps_count integer DEFAULT 0 NOT NULL
);


ALTER TABLE public._prisma_migrations OWNER TO postgres;

--
-- Name: access_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.access_type (
    access_type_id integer NOT NULL,
    access_name character varying(100) NOT NULL
);


ALTER TABLE public.access_type OWNER TO postgres;

--
-- Name: access_type_access_type_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.access_type_access_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.access_type_access_type_id_seq OWNER TO postgres;

--
-- Name: access_type_access_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.access_type_access_type_id_seq OWNED BY public.access_type.access_type_id;


--
-- Name: branch; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.branch (
    branch_id uuid NOT NULL,
    branch_city character varying(255) NOT NULL,
    branch_address character varying(200) NOT NULL,
    branch_phone character varying(13) NOT NULL,
    branch_email character varying(255) NOT NULL,
    created_at timestamp(6) with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.branch OWNER TO postgres;

--
-- Name: cart; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cart (
    cart_id integer NOT NULL,
    order_id integer,
    product_id uuid NOT NULL,
    quantity integer NOT NULL,
    sub_total_amount numeric(1000,2),
    created_at date DEFAULT CURRENT_DATE
);


ALTER TABLE public.cart OWNER TO postgres;

--
-- Name: cart_cart_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cart_cart_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.cart_cart_id_seq OWNER TO postgres;

--
-- Name: cart_cart_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cart_cart_id_seq OWNED BY public.cart.cart_id;


--
-- Name: category; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.category (
    category_id integer NOT NULL,
    category_name character varying(50) NOT NULL
);


ALTER TABLE public.category OWNER TO postgres;

--
-- Name: category_category_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.category_category_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.category_category_id_seq OWNER TO postgres;

--
-- Name: category_category_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.category_category_id_seq OWNED BY public.category.category_id;


--
-- Name: customer; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.customer (
    customer_id integer NOT NULL,
    customer_name character varying(255) NOT NULL,
    customer_email character varying(255),
    customer_phone character varying(13) NOT NULL,
    customer_address character varying(200),
    visit_count integer DEFAULT 0,
    rewards_points numeric(1000,2) DEFAULT 0.00,
    created_at timestamp(6) with time zone DEFAULT CURRENT_TIMESTAMP,
    credits numeric(1000,2) DEFAULT 0.00
);


ALTER TABLE public.customer OWNER TO postgres;

--
-- Name: customer_customer_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.customer_customer_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.customer_customer_id_seq OWNER TO postgres;

--
-- Name: customer_customer_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.customer_customer_id_seq OWNED BY public.customer.customer_id;


--
-- Name: discount; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.discount (
    discount_id integer NOT NULL,
    discount_name character varying(255) NOT NULL,
    discount_desc character varying(200),
    discount_percentage numeric(5,2) NOT NULL
);


ALTER TABLE public.discount OWNER TO postgres;

--
-- Name: discount_discount_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.discount_discount_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.discount_discount_id_seq OWNER TO postgres;

--
-- Name: discount_discount_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.discount_discount_id_seq OWNED BY public.discount.discount_id;


--
-- Name: employee; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.employee (
    employee_id integer NOT NULL,
    employee_name character varying(255) NOT NULL,
    role_id integer NOT NULL,
    hired_date timestamp(6) with time zone DEFAULT CURRENT_TIMESTAMP,
    employee_email character varying(255),
    employee_phone character varying(13) NOT NULL,
    branch_id uuid NOT NULL,
    employee_image character varying(255),
    branch_updated_on timestamp(6) with time zone DEFAULT CURRENT_TIMESTAMP,
    role_updated_on timestamp(6) with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.employee OWNER TO postgres;

--
-- Name: employee_employee_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.employee_employee_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.employee_employee_id_seq OWNER TO postgres;

--
-- Name: employee_employee_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.employee_employee_id_seq OWNED BY public.employee.employee_id;


--
-- Name: inventory; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.inventory (
    product_id uuid NOT NULL,
    branch_id uuid NOT NULL,
    quantity integer,
    reorder_level integer,
    updated_on timestamp(6) with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.inventory OWNER TO postgres;

--
-- Name: product; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.product (
    product_id uuid NOT NULL,
    product_name character varying(100) NOT NULL,
    product_desc character varying(200),
    category_id integer NOT NULL,
    product_image character varying[],
    supplier_id integer NOT NULL,
    product_barcode character varying(255) NOT NULL,
    removed boolean DEFAULT false,
    created_at timestamp(6) without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_on timestamp(6) without time zone DEFAULT CURRENT_TIMESTAMP,
    stock_type character varying(50) NOT NULL
);


ALTER TABLE public.product OWNER TO postgres;

--
-- Name: product_variants; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.product_variants (
    variant_id uuid NOT NULL,
    product_id uuid NOT NULL,
    buying_price numeric(1000,2) NOT NULL,
    retail_price numeric(1000,2) NOT NULL,
    discount numeric(1000,2),
    label character varying(200) NOT NULL
);


ALTER TABLE public.product_variants OWNER TO postgres;

--
-- Name: sales_history; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sales_history (
    order_id integer NOT NULL,
    customer_id integer,
    cashier_id integer NOT NULL,
    branch_id uuid NOT NULL,
    created_at timestamp(6) with time zone DEFAULT CURRENT_TIMESTAMP,
    total_amount numeric(1000,2),
    profit numeric(1000,2) DEFAULT 0.00,
    rewards_points numeric(1000,2) DEFAULT 0.00,
    product_count integer,
    payment_method character varying(20),
    reference character varying(255)
);


ALTER TABLE public.sales_history OWNER TO postgres;

--
-- Name: sales_history_order_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sales_history_order_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.sales_history_order_id_seq OWNER TO postgres;

--
-- Name: sales_history_order_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sales_history_order_id_seq OWNED BY public.sales_history.order_id;


--
-- Name: supplier; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.supplier (
    supplier_id integer NOT NULL,
    supplier_name character varying(200) NOT NULL,
    supplier_email character varying(255),
    supplier_phone character varying(13) NOT NULL,
    supplier_address character varying(200) NOT NULL
);


ALTER TABLE public.supplier OWNER TO postgres;

--
-- Name: supplier_supplier_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.supplier_supplier_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.supplier_supplier_id_seq OWNER TO postgres;

--
-- Name: supplier_supplier_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.supplier_supplier_id_seq OWNED BY public.supplier.supplier_id;


--
-- Name: user_credentials; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_credentials (
    user_id integer NOT NULL,
    username character varying(30) NOT NULL,
    password character varying(200) NOT NULL,
    updated_on timestamp(6) with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.user_credentials OWNER TO postgres;

--
-- Name: user_role; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_role (
    role_id integer NOT NULL,
    role_name character varying(100) NOT NULL,
    role_desc character varying(200) NOT NULL,
    user_access integer[]
);


ALTER TABLE public.user_role OWNER TO postgres;

--
-- Name: user_role_role_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user_role_role_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.user_role_role_id_seq OWNER TO postgres;

--
-- Name: user_role_role_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user_role_role_id_seq OWNED BY public.user_role.role_id;


--
-- Name: variable_options; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.variable_options (
    variable_id integer NOT NULL,
    variable_name character varying(100) NOT NULL,
    created_at timestamp(0) with time zone DEFAULT CURRENT_TIMESTAMP,
    variable_value numeric(1000,2),
    updated_on timestamp(0) with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.variable_options OWNER TO postgres;

--
-- Name: variable_options_variable_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.variable_options_variable_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.variable_options_variable_id_seq OWNER TO postgres;

--
-- Name: variable_options_variable_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.variable_options_variable_id_seq OWNED BY public.variable_options.variable_id;


--
-- Name: working_hour; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.working_hour (
    employee_id integer NOT NULL,
    date character varying(12) NOT NULL,
    shift_on character varying(5) NOT NULL,
    shift_off character varying(5) NOT NULL,
    updated_by integer NOT NULL,
    present boolean NOT NULL,
    total_hours numeric(100,2),
    branch_id uuid NOT NULL
);


ALTER TABLE public.working_hour OWNER TO postgres;

--
-- Name: access_type access_type_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.access_type ALTER COLUMN access_type_id SET DEFAULT nextval('public.access_type_access_type_id_seq'::regclass);


--
-- Name: cart cart_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cart ALTER COLUMN cart_id SET DEFAULT nextval('public.cart_cart_id_seq'::regclass);


--
-- Name: category category_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.category ALTER COLUMN category_id SET DEFAULT nextval('public.category_category_id_seq'::regclass);


--
-- Name: customer customer_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer ALTER COLUMN customer_id SET DEFAULT nextval('public.customer_customer_id_seq'::regclass);


--
-- Name: discount discount_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.discount ALTER COLUMN discount_id SET DEFAULT nextval('public.discount_discount_id_seq'::regclass);


--
-- Name: employee employee_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employee ALTER COLUMN employee_id SET DEFAULT nextval('public.employee_employee_id_seq'::regclass);


--
-- Name: sales_history order_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sales_history ALTER COLUMN order_id SET DEFAULT nextval('public.sales_history_order_id_seq'::regclass);


--
-- Name: supplier supplier_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.supplier ALTER COLUMN supplier_id SET DEFAULT nextval('public.supplier_supplier_id_seq'::regclass);


--
-- Name: user_role role_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_role ALTER COLUMN role_id SET DEFAULT nextval('public.user_role_role_id_seq'::regclass);


--
-- Name: variable_options variable_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.variable_options ALTER COLUMN variable_id SET DEFAULT nextval('public.variable_options_variable_id_seq'::regclass);


--
-- Data for Name: _prisma_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public._prisma_migrations (id, checksum, finished_at, migration_name, logs, rolled_back_at, started_at, applied_steps_count) FROM stdin;
60f6d11b-444d-4f47-9c01-a9b25199935e	08dd35980c2bf875c4604ab518a0585f0f4016b08ef591d3c4bfe78db83db238	2025-10-26 04:35:59.515727-07	20251022210925_init	\N	\N	2025-10-26 04:35:59.207561-07	1
5d6485f3-8554-4198-bb7b-5d566a7b9d5f	65775224d6eba84784f4d46f83b1be5fee72d7abb8e75dd312c395def151bbbe	2025-10-26 04:35:59.556097-07	20251024105251_product_variant	\N	\N	2025-10-26 04:35:59.517715-07	1
5eb62bce-64b0-410c-9ec4-d3cacccb2972	1c9b6083ae10f113d644711f4cfc5ff64220435bec80121831ad33d66d6733a9	2025-10-26 04:35:59.575407-07	20251024110721_variant_label	\N	\N	2025-10-26 04:35:59.558149-07	1
939489a5-95d5-42e4-924a-cd0fcf2deb0c	4a6b7518a7eaaacf11a4ee1dbea0e01074bb6f9b1e1f8e28546995692edc01d0	2025-10-26 04:35:59.587776-07	20251024202620_stock_type	\N	\N	2025-10-26 04:35:59.577864-07	1
ccc5df16-0fe0-4076-a78f-301c2f56291f	5b51e5568fd3ebe8c397ceda6bf2907711e697b5be6094d01b23717f3d084e8a	2025-10-26 04:35:59.597462-07	20251024211208_credit	\N	\N	2025-10-26 04:35:59.589594-07	1
39e26492-2e22-4907-8af8-765dfc4b751a	e409600e4eff572d45970b39a24c2550644a41b9c9a485e81000e31797cbfce8	2025-11-01 10:20:15.906679-07	20251101144524_payment_method	\N	\N	2025-11-01 10:20:15.867065-07	1
\.


--
-- Data for Name: access_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.access_type (access_type_id, access_name) FROM stdin;
1	configuration
2	report
3	employee
4	employeeDetails
5	addEmployee
6	inventory
7	productForm
8	stockUpdateForm
9	productCatalog
10	customerForm
11	customers
12	supplierForm
13	supplier
14	supplierDetails
15	addBranch
\.


--
-- Data for Name: branch; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.branch (branch_id, branch_city, branch_address, branch_phone, branch_email, created_at) FROM stdin;
aeda1973-4148-474a-8153-c199958a59c6	Kandy	456 Elm St, Kandy 20000	814325678	kandybranch@example.com	2025-10-26 04:37:00.961194-07
f6fed7de-dba7-4988-b73b-b775c7577bc2	Galle	789 Oak St, Galle 80000	912345678	gallebranch@example.com	2025-10-26 04:37:00.961194-07
d0fdf18f-40af-46d3-9475-81465cf61994	Anuradhapura	789 Pine St, Anuradhapura 50000	762345678	anuradhapurabranch@example.com	2025-10-26 04:37:00.961194-07
45ba25bb-eab9-461f-a93b-559e4e8c74e4	LAABA KADE	Laaba Kade, Hettiyawala, Puhulwella.	071 678 8744	poslaabakade@gmail.com	2025-10-26 04:37:00.961194-07
\.


--
-- Data for Name: cart; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cart (cart_id, order_id, product_id, quantity, sub_total_amount, created_at) FROM stdin;
\.


--
-- Data for Name: category; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.category (category_id, category_name) FROM stdin;
1	Biscuits
2	Snacks
3	Beverages
4	Dairy
5	Cooking Ingredients
6	Dental Care
7	Stationary/Books
\.


--
-- Data for Name: customer; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.customer (customer_id, customer_name, customer_email, customer_phone, customer_address, visit_count, rewards_points, created_at, credits) FROM stdin;
47	Gedara	sinethmalaka16@gmail.com	0713329439	saman	3	16.49	2025-11-23 21:27:02.13-08	1397.60
\.


--
-- Data for Name: discount; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.discount (discount_id, discount_name, discount_desc, discount_percentage) FROM stdin;
1	Summer Sale	Get discounts on various summer products	15.00
2	Back to School	Special discounts on school supplies	10.50
3	Holiday Season	Festive discounts for holiday shoppers	20.00
4	Weekend Special	Limited-time weekend discounts	12.75
5	New Year Clearance	Clearance sale for old inventory	30.25
6	Valentine's Day	Discounts on gifts for your loved ones	14.00
7	Spring Cleaning	Save on cleaning supplies	18.50
8	Easter Sale	Special offers for Easter weekend	10.00
9	Black Friday	Biggest discounts of the year on Black Friday	35.00
10	Cyber Monday	Online-only deals for Cyber Monday	25.50
\.


--
-- Data for Name: employee; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.employee (employee_id, employee_name, role_id, hired_date, employee_email, employee_phone, branch_id, employee_image, branch_updated_on, role_updated_on) FROM stdin;
1	Somesh Chandimal	1	2022-01-14 10:30:00-08	somesh@example.com	112233445	45ba25bb-eab9-461f-a93b-559e4e8c74e4	employee-image-placeholder.jpg	2025-10-26 04:37:00.961194-07	2025-10-26 04:37:00.961194-07
2	John Doe	2	2022-05-14 11:30:00-07	johndoe@example.com	112243445	45ba25bb-eab9-461f-a93b-559e4e8c74e4	employee-image-placeholder.jpg	2025-10-26 04:37:00.961194-07	2025-10-26 04:37:00.961194-07
3	Jane Smith	2	2021-12-09 10:30:00-08	janesmith@example.com	998877665	aeda1973-4148-474a-8153-c199958a59c6	employee-image-placeholder.jpg	2025-10-26 04:37:00.961194-07	2025-10-26 04:37:00.961194-07
4	Robert Johnson	2	2023-02-27 10:30:00-08	robertjohnson@example.com	777766655	f6fed7de-dba7-4988-b73b-b775c7577bc2	employee-image-placeholder.jpg	2025-10-26 04:37:00.961194-07	2025-10-26 04:37:00.961194-07
5	Mary Wilson	2	2022-09-29 11:30:00-07	marywilson@example.com	333444555	d0fdf18f-40af-46d3-9475-81465cf61994	employee-image-placeholder.jpg	2025-10-26 04:37:00.961194-07	2025-10-26 04:37:00.961194-07
6	Michael Lee	3	2020-07-04 11:30:00-07	michaellee@example.com	222555444	45ba25bb-eab9-461f-a93b-559e4e8c74e4	employee-image-placeholder.jpg	2025-10-26 04:37:00.961194-07	2025-10-26 04:37:00.961194-07
7	Lisa Garcia	3	2021-10-19 11:30:00-07	lisagarcia@example.com	666555444	aeda1973-4148-474a-8153-c199958a59c6	employee-image-placeholder.jpg	2025-10-26 04:37:00.961194-07	2025-10-26 04:37:00.961194-07
8	David Martinez	3	2022-04-14 11:30:00-07	davidmartinez@example.com	777444555	f6fed7de-dba7-4988-b73b-b775c7577bc2	employee-image-placeholder.jpg	2025-10-26 04:37:00.961194-07	2025-10-26 04:37:00.961194-07
9	Sarah Brown	3	2021-03-24 11:30:00-07	sarahbrown@example.com	555444333	d0fdf18f-40af-46d3-9475-81465cf61994	employee-image-placeholder.jpg	2025-10-26 04:37:00.961194-07	2025-10-26 04:37:00.961194-07
10	William Smith	4	2022-01-04 10:30:00-08	williamsmith@example.com	777888999	45ba25bb-eab9-461f-a93b-559e4e8c74e4	employee-image-placeholder.jpg	2025-10-26 04:37:00.961194-07	2025-10-26 04:37:00.961194-07
11	Karen Davis	4	2023-06-29 11:30:00-07	karendavis@example.com	444555666	45ba25bb-eab9-461f-a93b-559e4e8c74e4	employee-image-placeholder.jpg	2025-10-26 04:37:00.961194-07	2025-10-26 04:37:00.961194-07
12	James Taylor	4	2022-08-14 11:30:00-07	jamestaylor@example.com	555747888	45ba25bb-eab9-461f-a93b-559e4e8c74e4	employee-image-placeholder.jpg	2025-10-26 04:37:00.961194-07	2025-10-26 04:37:00.961194-07
13	Jennifer Clark	4	2021-11-09 10:30:00-08	jenniferclark@example.com	999888777	aeda1973-4148-474a-8153-c199958a59c6	employee-image-placeholder.jpg	2025-10-26 04:37:00.961194-07	2025-10-26 04:37:00.961194-07
14	Joseph Johnson	4	2023-01-14 10:30:00-08	josephjohnson@example.com	555666777	aeda1973-4148-474a-8153-c199958a59c6	employee-image-placeholder.jpg	2025-10-26 04:37:00.961194-07	2025-10-26 04:37:00.961194-07
15	Nancy Moore	4	2021-04-19 11:30:00-07	nancymoore@example.com	444666555	aeda1973-4148-474a-8153-c199958a59c6	employee-image-placeholder.jpg	2025-10-26 04:37:00.961194-07	2025-10-26 04:37:00.961194-07
16	Robert White	4	2020-11-04 10:30:00-08	robertwhite@example.com	333777666	f6fed7de-dba7-4988-b73b-b775c7577bc2	employee-image-placeholder.jpg	2025-10-26 04:37:00.961194-07	2025-10-26 04:37:00.961194-07
17	Linda Harris	4	2022-02-27 10:30:00-08	lindaharris@example.com	222777888	f6fed7de-dba7-4988-b73b-b775c7577bc2	employee-image-placeholder.jpg	2025-10-26 04:37:00.961194-07	2025-10-26 04:37:00.961194-07
18	John Miller	4	2023-03-09 10:30:00-08	johnmiller@example.com	444555444	f6fed7de-dba7-4988-b73b-b775c7577bc2	employee-image-placeholder.jpg	2025-10-26 04:37:00.961194-07	2025-10-26 04:37:00.961194-07
19	Patricia Garcia	4	2022-06-30 11:30:00-07	patriciagarcia@example.com	777555444	d0fdf18f-40af-46d3-9475-81465cf61994	employee-image-placeholder.jpg	2025-10-26 04:37:00.961194-07	2025-10-26 04:37:00.961194-07
20	Robert Brown	4	2020-12-24 10:30:00-08	robertbrown@example.com	666444555	d0fdf18f-40af-46d3-9475-81465cf61994	employee-image-placeholder.jpg	2025-10-26 04:37:00.961194-07	2025-10-26 04:37:00.961194-07
\.


--
-- Data for Name: inventory; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.inventory (product_id, branch_id, quantity, reorder_level, updated_on) FROM stdin;
80c056aa-1316-42c2-8ac8-09e13b691719	45ba25bb-eab9-461f-a93b-559e4e8c74e4	4	5	2025-11-23 22:31:27.541-08
\.


--
-- Data for Name: product; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.product (product_id, product_name, product_desc, category_id, product_image, supplier_id, product_barcode, removed, created_at, updated_on, stock_type) FROM stdin;
80c056aa-1316-42c2-8ac8-09e13b691719	උස්වත්ත ක්‍රැකර් 490g	උස්වත්ත ක්‍රැකර් 490g	1	\N	8	4792135080274	f	2025-11-24 06:15:53.664	2025-11-24 06:15:53.664	items
55a86246-7479-49db-9adf-897a5b8f8ea1	උස්වත්ත ක්‍රැකර් 220g	උස්වත්ත ක්‍රැකර් 220g	1	\N	8	4792135080489	f	2025-11-24 07:17:36.723	2025-11-24 07:17:36.723	items
24ed9e87-992a-44b4-aebc-454fb0b12a41	උස්වත්ත ක්‍රිස්පිස් ස්ට්‍රොබෙරි වේෆර්ස් 200g	උස්වත්ත ක්‍රිස්පිස් ස්ට්‍රොබෙරි වේෆර්ස් 200g	1	\N	8	4792135010554	f	2025-11-24 07:18:24.262	2025-11-24 07:18:24.262	items
36750adc-1f01-4f92-8334-cdcc6a64748a	උස්වත්ත ක්‍රිස්පිස් වැනිලා වේෆර්ස් 200g	උස්වත්ත ක්‍රිස්පිස් වැනිලා වේෆර්ස් 200g	1	\N	8	4792135010530	f	2025-11-24 07:19:17.684	2025-11-24 07:19:17.684	items
5b7e9adb-a3ff-429a-a6bc-8cdfdfa729ba	උස්වත්ත ක්‍රිස්පිස් චොක්ලට් වේෆර්ස් 200g	උස්වත්ත ක්‍රිස්පිස් චොක්ලට් වේෆර්ස් 200g	1	\N	8	4792232033289	f	2025-11-24 07:20:26.234	2025-11-24 07:20:26.234	items
8e8d623a-cc06-4c23-a4b4-a27cd616d192	උස්වත්ත මාෂ්මෙලෝස් 50g	උස්වත්ත මාෂ්මෙලෝස් 50g	1	\N	8	4792135030453	f	2025-11-24 07:21:25.844	2025-11-24 07:21:25.844	items
3d43457a-d835-4818-8425-afae87c6a44b	උස්වත්ත කස්ටඩ් ක්‍රීම් 190g	උස්වත්ත කස්ටඩ් ක්‍රීම් 190g	1	\N	8	4792135080472	f	2025-11-24 07:22:09.005	2025-11-24 07:22:09.005	items
b3354099-a9df-4d7b-8047-0afbe723e72e	උස්වත්ත කස්ටඩ් ක්‍රීම් 380g	උස්වත්ත කස්ටඩ් ක්‍රීම් 380g	1	\N	8	4792135080533	f	2025-11-24 07:22:38.637	2025-11-24 07:22:38.637	items
4527a1ab-d4da-432e-80ff-81a40b1f20ba	උස්වත්ත ඔරේන්ජ් ක්‍රීම් 190g	උස්වත්ත ඔරේන්ජ් ක්‍රීම් 190g	1	\N	8	4792135080502	f	2025-11-24 07:23:15.352	2025-11-24 07:23:15.352	items
f05ec128-49ff-44fa-962e-c63e8a9e817f	උස්වත්ත ඔරේන්ජ් ක්‍රීම් 380g	උස්වත්ත ඔරේන්ජ් ක්‍රීම් 380g	1	\N	8	4792135080526	f	2025-11-24 07:23:55.623	2025-11-24 07:23:55.623	items
bde5e2ae-4bc7-4050-a819-e69399bd3e73	උස්වත්ත ගෝල්ඩන් වේෆර්ස් 90g	උස්වත්ත ගෝල්ඩන් වේෆර්ස් 90g	1	\N	8	4792135010400	f	2025-11-24 07:24:26.731	2025-11-24 07:24:26.731	items
6caf37e5-4328-4d75-876c-5e67f8cbacb2	උස්වත්ත මාරි 250g	උස්වත්ත මාරි 250g	1	\N	8	4792135080588	f	2025-11-24 07:24:56.634	2025-11-24 07:24:56.634	items
a7a3e22c-9033-40de-80a5-f1068591e995	උස්වත්ත මාරි 50g	උස්වත්ත මාරි 50g	1	\N	8	4792135080571	f	2025-11-24 07:25:42.811	2025-11-24 07:25:42.811	items
57e8afab-2ebe-4dba-a69b-2a2391720bee	උස්වත්ත චොක්ලට් ක්‍රීම් 380g	උස්වත්ත චොක්ලට් ක්‍රීම් 380g	1	\N	8	4792135080854	f	2025-11-24 07:26:12.681	2025-11-24 07:26:12.681	items
70f960ab-191b-472b-9a81-3723109e50e2	උස්වත්ත චොක්ලට් ක්‍ර්‍රීම් 200g	උස්වත්ත චොක්ලට් ක්‍ර්‍රීම් 200g	1	\N	8	4792135080373	f	2025-11-24 07:26:39.927	2025-11-24 07:26:39.927	items
76c24e00-27fe-4fbe-be31-fe39f5edd567	උස්වත්ත චොක්ලට් ක්‍රීම් 90g	උස්වත්ත චොක්ලට් ක්‍රීම් 90g	1	\N	8	4792135080755	f	2025-11-24 07:27:11.966	2025-11-24 07:27:11.966	items
b5352c4d-4a99-4f75-93b5-fef57de66800	උස්වත්ත චොක්ලට් පෆ් 180g	උස්වත්ත චොක්ලට් පෆ් 180g	1	\N	8	4792135080557	f	2025-11-24 07:29:32.048	2025-11-24 07:29:32.048	items
83d5b7ce-ba60-4401-bc10-d4d96b787b14	උස්වත්ත ලෙමන් පෆ් 200g	උස්වත්ත ලෙමන් පෆ් 200g	1	\N	8	4792135080298	f	2025-11-24 07:30:05.464	2025-11-24 07:30:05.464	items
ce121668-26b9-4c76-ab71-71b76c06e2f1	උස්වත්ත ගෝල්ඩන් ස්ට්‍රෝබෙරි වේෆර්ස් 400g	උස්වත්ත ගෝල්ඩන් ස්ට්‍රෝබෙරි වේෆර්ස් 400g	1	\N	8	4792135010370	f	2025-11-24 07:30:54.802	2025-11-24 07:30:54.802	items
782e6467-95b6-46f2-8228-e3134590ced7	උස්වත්ත ගෝල්ඩන් වැනිලා වේෆර්ස් 400g	උස්වත්ත ගෝල්ඩන් වැනිලා වේෆර්ස් 400g	1	\N	8	4792135010356	f	2025-11-24 07:31:30.247	2025-11-24 07:31:30.247	items
6ae3db31-dc27-4da2-b91c-1e2f8ddc72bd	උස්වත්ත ගෝල්ඩන් චොක්ලට් වේෆර්ස් 400g	උස්වත්ත ගෝල්ඩන් චොක්ලට් වේෆර්ස් 400g	1	\N	8	4792135010363	f	2025-11-24 07:32:03.131	2025-11-24 07:32:03.131	items
ba436f5f-82af-44b6-9331-3103aa9792bb	මන්චි සුපර් ක්‍ර්‍රීම් ක්‍රැකර් 490g	මන්චි සුපර් ක්‍ර්‍රීම් ක්‍රැකර් 490g	1	\N	10	8888101430115	f	2025-11-24 11:59:58.27	2025-11-24 11:59:58.27	items
07a2a753-5949-43c0-9f38-e711f7d3414f	මන්චි සුපර් ක්‍ර්‍රීම් ක්‍රැකර් 230g	මන්චි සුපර් ක්‍ර්‍රීම් ක්‍රැකර් 230g	1	\N	10	8888101430399	f	2025-11-24 12:00:30.608	2025-11-24 12:00:30.608	items
6c978fab-9668-4cbc-b2a2-664832fb359f	මන්චි සුපර් ක්‍ර්‍රීම් ක්‍රැකර් 190g	මන්චි සුපර් ක්‍ර්‍රීම් ක්‍රැකර් 190g	1	\N	10	8888101430337	f	2025-11-24 12:01:01.626	2025-11-24 12:01:01.626	items
bebf84d9-452f-4d9a-b7f6-2128fdb9a10a	මන්චි සුපර් ක්‍ර්‍රීම් ක්‍රැකර් 125g	මන්චි සුපර් ක්‍ර්‍රීම් ක්‍රැකර් 125g	1	\N	10	8888101430153	f	2025-11-24 12:01:28.563	2025-11-24 12:01:28.563	items
516bc225-bee7-4a71-9b11-63031f4134d1	මන්චි සුපර් ක්‍ර්‍රීම් ක්‍රැකර් 120g	මන්චි සුපර් ක්‍ර්‍රීම් ක්‍රැකර් 120g	1	\N	10	8888101430191	f	2025-11-24 12:02:16.395	2025-11-24 12:02:16.395	items
5f2fcb71-2dd6-4a7e-87e8-8eab72d094e9	මන්චි සුපර් ක්‍ර්‍රීම් ක්‍රැකර් 85g	මන්චි සුපර් ක්‍ර්‍රීම් ක්‍රැකර් 85g	1	\N	10	8888101430276	f	2025-11-24 12:02:45.114	2025-11-24 12:02:45.114	items
8e2b80cb-cc73-4892-bf27-d44ac12da777	මන්චි ලෙමන් වේෆර්ස් 400g	මන්චි ලෙමන් වේෆර්ස් 400g	1	\N	10	4792192508612	f	2025-11-24 12:03:20.323	2025-11-24 12:03:20.323	items
46a09e4c-be81-49f1-a826-b52c3142c597	මන්චි වනිලා වේෆර්ස් 400g	මන්චි වනිලා වේෆර්ස් 400g	1	\N	10	4792192507615	f	2025-11-24 12:03:52.452	2025-11-24 12:03:52.452	items
57faea84-2425-4d97-9ec5-31a94de7ad25	මන්චි මිල්ක් ක්‍රීම් 390g	මන්චි මිල්ක් ක්‍රීම් 390g	1	\N	10	4792192846882	f	2025-11-24 12:04:23.258	2025-11-24 12:04:23.258	items
a689c104-e9c3-4c5d-95e4-df3d57114169	මන්චි මිල්ක් ක්‍රීම් 220g	මන්චි මිල්ක් ක්‍රීම් 220g	1	\N	10	4792192848350	f	2025-11-24 12:04:51.067	2025-11-24 12:04:51.067	items
692bc02e-cf55-4ccd-bde2-6c7ce2dd1cba	මන්චි වනිලා වේෆර්ස් 220g	මන්චි වනිලා වේෆර්ස් 220g	1	\N	10	4792192848169	f	2025-11-24 12:05:59.728	2025-11-24 12:05:59.728	items
19606980-e9ac-43ef-9905-165c15ba8ce6	මන්චි චොක්ලට් වේෆර්ස් 220g	මන්චි චොක්ලට් වේෆර්ස් 220g	1	\N	10	4792192848183	f	2025-11-24 12:06:30.424	2025-11-24 12:06:30.424	items
e5fd84bf-d11c-468e-ad70-3cc0905c2e3f	මන්චි නයිස් බිස්කට් 100g	මන්චි නයිස් බිස්කට් 100g	1	\N	10	8888101020200	f	2025-11-24 12:07:03.922	2025-11-24 12:07:03.922	items
4b89aafe-2b3b-4a57-b914-7c6996c6cede	මන්චි නයිස් බිස්කට් 200g	මන්චි නයිස් බිස්කට් 200g	1	\N	10	8888101020408	f	2025-11-24 12:07:40.24	2025-11-24 12:07:40.24	items
5086ff4c-454f-413e-b4be-d7f3166a493b	මන්චි නයිස් බිස්කට් 400g	මන්චි නයිස් බිස්කට් 400g	1	\N	10	8888101020101	f	2025-11-24 12:08:53.199	2025-11-24 12:08:53.199	items
681d8fee-7100-41af-88ab-736ed1d72945	මන්චි මිල්ක් ෂෝර්ට් කේක් 200g	මන්චි මිල්ක් ෂෝර්ට් කේක් 200g	1	\N	10	8888101030407	f	2025-11-24 12:10:25.09	2025-11-24 12:10:25.09	items
c4ffa3fc-5ee3-4278-8257-dac9dd315681	මන්චි ටිෆින් ඔරිජිනල් බිස්කට් 125g	මන්චි ටිෆින් ඔරිජිනල් බිස්කට් 125g	1	\N	10	8888101932190	f	2025-11-24 12:10:57.727	2025-11-24 12:10:57.727	items
6ae72424-0791-4729-8cf0-16ab465933e6	මන්චි ටිෆින් අනියන් බිස්කට් 125g	මන්චි ටිෆින් අනියන් බිස්කට් 125g	1	\N	10	8888101931193	f	2025-11-24 12:11:32.954	2025-11-24 12:11:32.954	items
e28dd856-6a60-44cd-a407-91c50ecaa43f	මන්චි චිස් ක්‍රැකර් 100g	මන්චි චිස් ක්‍රැකර් 100g	1	\N	10	8888101131203	f	2025-11-24 12:12:05.727	2025-11-24 12:12:05.727	items
71a7de17-d3fa-4629-b50a-604d9ccb9e22	මන්චි චිස් ක්‍රැකර් 200g	මන්චි චිස් ක්‍රැකර් 200g	1	\N	10	8888101131401	f	2025-11-24 12:12:41.48	2025-11-24 12:12:41.48	items
be0f5a4b-8e41-4fff-9fd7-588a22af5c10	මන්චි ටී ක්‍රන්ච් චොක්ලට් 95g	මන්චි ටී ක්‍රන්ච් චොක්ලට් 95g	1	\N	10	8888101639006	f	2025-11-24 12:13:08.454	2025-11-24 12:13:08.454	items
60a21c8e-9eb9-4980-a6df-7f4bb4b68d61	මන්චි ටී ක්‍රන්ච් අන්නාසි  95g	මන්චි ටී ක්‍රන්ච් අන්නාසි  95g	1	\N	10	8888101641450	f	2025-11-24 12:13:38.998	2025-11-24 12:13:38.998	items
a2a64dc0-7704-438b-8f04-3617aec7c9d5	මන්චි ටී ක්‍රන්ච් අන්නාසි 190g	මන්චි ටී ක්‍රන්ච් අන්නාසි 190g	1	\N	10	8888101641337	f	2025-11-24 12:14:07.719	2025-11-24 12:14:07.719	items
1eb9e389-c81d-4660-9e7a-0ebcf9680a0d	මන්චි ටී ක්‍රන්ච් 190g	මන්චි ටී ක්‍රන්ච් 190g	1	\N	10	8888101619336	f	2025-11-24 12:14:46.606	2025-11-24 12:14:46.606	items
667d1c72-336c-47dd-89f8-d5c72d0da442	මන්චි ටී ක්‍රන්ච් චොක්ලට් 190g	මන්චි ටී ක්‍රන්ච් චොක්ලට් 190g	1	\N	10	8888101639020	f	2025-11-24 12:15:14.969	2025-11-24 12:15:14.969	items
1996b395-05e7-49a0-be7f-d591c72dac1b	මන්චි හවායන් කුකීස් 100g	මන්චි හවායන් කුකීස් 100g	1	\N	10	8888101080204	f	2025-11-24 12:15:46.754	2025-11-24 12:15:46.754	items
023f7402-b456-4086-a983-05fb754c3b17	මන්චි හවායන් කුකීස් 200g	මන්චි හවායන් කුකීස් 200g	1	\N	10	8888101080402	f	2025-11-24 12:18:17.296	2025-11-24 12:18:17.296	items
66d5b17a-1c69-4ed0-9e3a-a4b7b26771d1	මන්චි ඉගුරු බිස්කට් 85g	මන්චි ඉගුරු බිස්කට් 85g	1	\N	10	8888101570286	f	2025-11-24 12:19:02.342	2025-11-24 12:19:02.342	items
36609b7e-f939-4f62-a990-e3adbe5899e2	මන්චි ඉගුරු බිස්කට් 200g	මන්චි ඉගුරු බිස්කට් 200g	1	\N	10	8888101570408	f	2025-11-24 12:19:39.935	2025-11-24 12:19:39.935	items
48ac8bfc-0db9-4385-88bc-75a692a16b16	මන්චි ඉගුරු බිස්කට් 400g	මන්චි ඉගුරු බිස්කට් 400g	1	\N	10	8888101570101	f	2025-11-24 12:20:13.718	2025-11-24 12:20:13.718	items
17cdd96d-2558-4466-a36d-487d7ed649fc	මන්චි චොකලට් මාරි 90g	මන්චි චොකලට් මාරි 90g	1	\N	10	8888101281205	f	2025-11-24 12:21:25.62	2025-11-24 12:21:25.62	items
ec4f988f-c839-4c78-a28c-ca44b8ee02ef	මන්චි චොකලට් මාරි 200g	මන්චි චොකලට් මාරි 200g	1	\N	10	4792192845823	f	2025-11-24 12:21:54.661	2025-11-24 12:21:54.661	items
998728ab-4628-4c89-8954-9724df62e88d	මන්චි චොකලට් මාරි 400g	මන්චි චොකලට් මාරි 400g	1	\N	10	8888101281106	f	2025-11-24 12:22:25.447	2025-11-24 12:22:25.447	items
9726fd94-8a97-4e2b-804d-7b4b649fb46d	මන්චි ලයිට් මාරි 50g	මන්චි ලයිට් මාරි 50g	1	\N	10	8888101287238	f	2025-11-24 12:24:00.99	2025-11-24 12:24:00.99	items
b559cc2c-f93f-494f-b7b0-c4656683dc36	මන්චි ලයිට් මාරි 120g	මන්චි ලයිට් මාරි 120g	1	\N	10	8888101282196	f	2025-11-24 12:24:36.066	2025-11-24 12:24:36.066	items
061814bd-9d46-40c0-9196-b708a625a914	මන්චි ලයිට් මාරි 250g	මන්චි ලයිට් මාරි 250g	1	\N	10	8888101282097	f	2025-11-24 12:25:14.553	2025-11-24 12:25:14.553	items
62ceed68-ac07-462e-b653-741c83275289	මන්චි ටිකිරි මාරි 80g	මන්චි ටිකිරි මාරි 80g	1	\N	10	8888101280208	f	2025-11-24 12:25:50.917	2025-11-24 12:25:50.917	items
fe4714fc-2034-45ff-b793-6a6c80903159	මන්චි ටිකිරි මාරි 230g	මන්චි ටිකිරි මාරි 230g	1	\N	10	4792192845809	f	2025-11-24 12:26:51.724	2025-11-24 12:26:51.724	items
2cfc82f1-305f-4a65-a6f7-09b1908262e8	මන්චි ටිකිරි මාරි 360g	මන්චි ටිකිරි මාරි 360g	1	\N	10	8888101280109	f	2025-11-24 12:27:26.331	2025-11-24 12:27:26.331	items
beaa85b4-b2f6-4167-98bf-4d1cefd4989d	මන්චි චොක්ලට් ක්‍රීම් 365g	මන්චි චොක්ලට් ක්‍රීම් 365g	1	\N	10	4792192851701	f	2025-11-24 12:28:53.324	2025-11-24 12:28:53.324	items
fc2f51cd-525d-46e3-ba2d-632ccc3f3bbf	මන්චි චොක්ලට් ක්‍රීම් 210g	මන්චි චොක්ලට් ක්‍රීම් 210g	1	\N	10	4792192845366	f	2025-11-24 12:29:28.677	2025-11-24 12:29:28.677	items
813518ad-f28b-4e74-9b84-d65d1f87d2f4	මන්චි චොක්ලට් ක්‍රීම් 100g	මන්චි චොක්ලට් ක්‍රීම් 100g	1	\N	10	8888101270018	f	2025-11-24 12:30:10.699	2025-11-24 12:30:10.699	items
f5414e0a-f2ad-41be-8f5a-7255a22ce2c4	මන්චි ලෙමන් පෆ් 100g	මන්චි ලෙමන් පෆ් 100g	1	\N	10	8888101090203	f	2025-11-24 12:30:56.507	2025-11-24 12:30:56.507	items
0c2f7080-ee33-476c-8d1e-9bdff49b5ec4	මන්චි ලෙමන් පෆ් 200g	මන්චි ලෙමන් පෆ් 200g	1	\N	10	8888101090401	f	2025-11-24 12:31:26.076	2025-11-24 12:31:26.076	items
142ce687-a827-41d2-a96e-84edb58f58c2	මන්චි චොකලට් පෆ් 100g	මන්චි චොකලට් පෆ් 100g	1	\N	10	8888101271206	f	2025-11-24 12:32:35.182	2025-11-24 12:32:35.182	items
9dbd32f8-d1a9-42f3-9734-4112ffd29413	මන්චි චොකලට් පෆ් 200g	මන්චි චොකලට් පෆ් 200g	1	\N	10	8888101271404	f	2025-11-24 12:33:10.195	2025-11-24 12:33:10.195	items
6d58c185-8d18-4d9d-b75e-00b74cb6b7c5	මන්චි රයිස් ක්‍රැකර් onion 15g	මන්චි රයිස් ක්‍රැකර් onion 15g	1	\N	10	4792192853927	f	2025-11-24 12:34:44.352	2025-11-24 12:34:44.352	items
54837fd2-c6b4-489c-bdb6-326faa41f9cf	මන්චි රයිස් ක්‍රැකර් BBQ 15g	මන්චි රයිස් ක්‍රැකර් BBQ 15g	1	\N	10	4792192853910	f	2025-11-24 12:35:40.508	2025-11-24 12:35:40.508	items
e2209295-e3fc-4d6e-845b-a29ae18ddd1b	මන්චි රයිස් ක්‍රැකර් masala 15g	මන්චි රයිස් ක්‍රැකර් masala 15g	1	\N	10	4792192853941	f	2025-11-24 12:36:43.032	2025-11-24 12:36:43.032	items
8de23bd8-faae-4a5b-b8cd-1a53d39b8211	මන්චි cheese buttons 20g	මන්චි cheese buttons 20g	1	\N	10	8888101611262	f	2025-11-24 12:37:16.937	2025-11-24 12:37:16.937	items
ef4e50fc-0ed3-4bfe-8cd4-084c2c5acde4	මන්චි onion biscuits 30g	මන්චි onion biscuits 30g	1	\N	10	8888101613266	f	2025-11-24 12:38:32.699	2025-11-24 12:38:32.699	items
eb350f06-622b-473a-a0a6-a3450603f6e7	මන්චි savoury nuts 30g	මන්චි savoury nuts 30g	1	\N	10	8888101634575	f	2025-11-24 12:39:02.347	2025-11-24 12:39:02.347	items
2ea0dc27-fb0f-4a6d-a491-9ce6b7b99442	මන්චි රයිස් ක්‍රැකර් chilli 15g	මන්චි රයිස් ක්‍රැකර් chilli 15g	1	\N	10	4792192853934	f	2025-11-24 12:35:12.084	2025-11-24 12:35:12.084	items
8b36f3ad-74e5-4ff5-b79c-0d8e1ec1ea64	මන්චි රයිස් ක්‍රැකර් cheese & chilli 15g	මන්චි රයිස් ක්‍රැකර් cheese & chilli 15g	1	\N	10	4792192853903	f	2025-11-24 12:36:10.602	2025-11-24 12:36:10.602	items
128e2fb8-bab9-47c1-9a32-5a2d0808b13a	මන්චි snak cracker 30g	මන්චි snak cracker 30g	1	\N	10	8888101610265	f	2025-11-24 12:37:50.061	2025-11-24 12:37:50.061	items
1569c550-ddcd-4fa5-b020-a216bf0245c6	මන්චි chilito 30g	මන්චි chilito 30g	1	\N	10	8888101612269	f	2025-11-24 12:39:33.81	2025-11-24 12:39:33.81	items
86d6d0da-e28d-44d7-b77a-631b557c94dc	මන්චි salsa 30g	මන්චි salsa 30g	1	\N	10	8888101625269	f	2025-11-24 12:40:08.543	2025-11-24 12:40:08.543	items
5e2b4e2f-3790-41bc-b098-314436fb7505	ඩයනා ස්ටෝබෙරි ක්‍රීම් වේෆස් 35g	ඩයනා ස්ටෝබෙරි ක්‍රීම් වේෆස් 35g	1	\N	11	4792093301732	f	2025-11-24 12:49:05.047	2025-11-24 12:49:05.047	items
b3afed53-2e50-4546-9733-aca608302199	ඩයනා වනිලා ක්‍රීම් වේෆස් 35g	ඩයනා වනිලා ක්‍රීම් වේෆස් 35g	1	\N	11	4792093301749	f	2025-11-24 12:49:34.267	2025-11-24 12:49:34.267	items
f48f22f7-b28b-4b1a-9564-70d1e65edff7	ඩයනා ස්ටෝබෙරි ක්‍රීම් බිස්කට් 50g	ඩයනා ස්ටෝබෙරි ක්‍රීම් බිස්කට් 50g	1	\N	11	4792093303224	f	2025-11-24 12:50:03.35	2025-11-24 12:50:03.35	items
fe23c1c2-15eb-40eb-a8cd-1298bcbbd27f	ඩයනා ඔරේන්ජ් ක්‍රිස්පි 50g	ඩයනා ඔරේන්ජ් ක්‍රිස්පි 50g	1	\N	11	4792093001267	f	2025-11-24 12:50:29.406	2025-11-24 12:50:29.406	items
5b88c906-894a-408e-9a79-b718078f20c6	ලිට්ල් ලයන් කර්ත කොලොම්බන් වේෆර්ස් 400g	ලිට්ල් ලයන් කර්ත කොලොම්බන් වේෆර්ස් 400g	1	\N	12	4792232021118	f	2025-11-24 13:10:18.846	2025-11-24 13:10:18.846	items
082cbda2-3c8a-429f-bb3b-d1c4d70bb0ee	ලිට්ල් ලයන් වැනිල වේෆර්ස් 400g	ලිට්ල් ලයන් වැනිල වේෆර්ස් 400g	1	\N	12	4792232004111	f	2025-11-24 13:18:20.776	2025-11-24 13:18:20.776	items
a68e471f-1b1b-4ba4-811a-129df476c2c0	ලිට්ල් ලයන් චොක්ලට් වේෆර්ස් 400g	ලිට්ල් ලයන් චොක්ලට් වේෆර්ස් 400g	1	\N	12	4792232003114	f	2025-11-24 13:18:54.615	2025-11-24 13:18:54.615	items
a401826c-6f5f-4b63-8fde-24ac5b15345d	ලිට්ල් ලයන් වැනිල වේෆර්ස් 225g	ලිට්ල් ලයන් වැනිල වේෆර්ස් 225g	1	\N	12	4792232004074	f	2025-11-24 13:19:23.128	2025-11-24 13:19:23.128	items
6e4569d6-346f-4543-8dde-d64668a0f00b	ලිට්ල් ලයන් චොකලට්  වේෆර්ස් 225g	ලිට්ල් ලයන් චොකලට්  වේෆර්ස් 225g	1	\N	12	4792232003077	f	2025-11-24 13:19:54.663	2025-11-24 13:19:54.663	items
b47ce6e2-d67f-494e-be7f-5f3233e8a94d	ලිට්ල් ලයන් චොකො වැනිල වේෆර්ස් 225g	ලිට්ල් ලයන් චොකො වැනිල වේෆර්ස් 225g	1	\N	12	4792232020074	f	2025-11-24 13:20:24.879	2025-11-24 13:20:24.879	items
381c1b99-3aae-40d2-9335-18b034b8be03	ලිට්ල් ලයන් වැනිල වේෆර්ස් 90g	ලිට්ල් ලයන් වැනිල වේෆර්ස් 90g	1	\N	12	4792232004012	f	2025-11-24 13:21:00.834	2025-11-24 13:21:00.834	items
7e49972f-e3d0-4d9a-a7d0-a37c2e059cbd	ලිට්ල් ලයන් වැනිල කුකීස් 65g	ලිට්ල් ලයන් වැනිල කුකීස් 65g	1	\N	12	4792232089255	f	2025-11-24 13:21:33.934	2025-11-24 13:21:33.934	items
003305a3-31b7-414f-bfdf-f962991d7af4	ලිට්ල් ලයන් වැනිල කුකීස් 150g	ලිට්ල් ලයන් වැනිල කුකීස් 150g	1	\N	12	4792232089033	f	2025-11-24 13:21:59.828	2025-11-24 13:21:59.828	items
7c3a579d-323e-4062-bb42-ca546836469c	ලිට්ල් ලයන් මාරි කුකීස් 230g	ලිට්ල් ලයන් මාරි කුකීස් 230g	1	\N	12	4792232068069	f	2025-11-24 13:22:27.424	2025-11-24 13:22:27.424	items
2f5b02a5-29ad-4eff-b327-daab88561e2b	ලිට්ල් ලයන් බැට කැරොල් කුකීස් 250g	ලිට්ල් ලයන් බැට කැරොල් කුකීස් 250g	1	\N	12	4792232001158	f	2025-11-24 13:22:57.446	2025-11-24 13:22:57.446	items
02682812-7736-4474-9379-58c31fa578c6	ලිට්ල් ලයන් බැට කැරොල් කුකීස් 90g	ලිට්ල් ලයන් බැට කැරොල් කුකීස් 90g	1	\N	12	4792232001011	f	2025-11-24 13:23:31.583	2025-11-24 13:23:31.583	items
d7626322-f385-41f7-9ace-a342b14ec2f1	ලිට්ල් ලයන් බැට කැරොල් කුකීස් 355g	ලිට්ල් ලයන් බැට කැරොල් කුකීස් 355g	1	\N	12	4792232001103	f	2025-11-24 13:23:57.515	2025-11-24 13:23:57.515	items
\.


--
-- Data for Name: product_variants; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.product_variants (variant_id, product_id, buying_price, retail_price, discount, label) FROM stdin;
a89dc291-a1a3-4418-a59e-7d04c90bad37	80c056aa-1316-42c2-8ac8-09e13b691719	285.00	450.00	340.00	New Variant
\.


--
-- Data for Name: sales_history; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sales_history (order_id, customer_id, cashier_id, branch_id, created_at, total_amount, profit, rewards_points, product_count, payment_method, reference) FROM stdin;
111	47	1	45ba25bb-eab9-461f-a93b-559e4e8c74e4	2025-11-23 21:50:57.609-08	2398.60	547.91	11.99	8	cash	1000
93	\N	1	45ba25bb-eab9-461f-a93b-559e4e8c74e4	2025-11-03 19:50:47.69-08	500.00	125.00	0.00	2	cash	1000
102	\N	1	45ba25bb-eab9-461f-a93b-559e4e8c74e4	2025-11-05 01:44:01.804-08	449.00	99.00	0.00	1	cash	500
104	\N	1	45ba25bb-eab9-461f-a93b-559e4e8c74e4	2025-11-08 10:11:48.948-08	449.00	99.00	0.00	1	cash	500
99	\N	1	45ba25bb-eab9-461f-a93b-559e4e8c74e4	2025-11-04 02:12:23.312-08	200.00	50.00	0.00	1	cash	300
101	\N	1	45ba25bb-eab9-461f-a93b-559e4e8c74e4	2025-11-05 01:37:11.942-08	449.00	99.00	0.00	1	cash	500
103	\N	1	45ba25bb-eab9-461f-a93b-559e4e8c74e4	2025-11-05 01:47:32.604-08	449.00	99.00	0.00	1	cash	500
105	\N	1	45ba25bb-eab9-461f-a93b-559e4e8c74e4	2025-11-08 19:01:58.931-08	449.00	99.00	0.00	1	cash	500
107	\N	1	45ba25bb-eab9-461f-a93b-559e4e8c74e4	2025-11-23 11:35:26.887-08	898.00	198.00	0.00	2	cash	1000
109	47	1	45ba25bb-eab9-461f-a93b-559e4e8c74e4	2025-11-23 21:29:01.338-08	449.00	96.75	2.25	1	cash	400
110	47	1	45ba25bb-eab9-461f-a93b-559e4e8c74e4	2025-11-23 21:32:17.486-08	449.00	96.75	2.25	1	credit	500
\.


--
-- Data for Name: supplier; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.supplier (supplier_id, supplier_name, supplier_email, supplier_phone, supplier_address) FROM stdin;
8	Uswatte	uswatte@gmail.com	0711893098	Ranminika, Millaniya, Bandaragama.
9	Alipancha Suweet House	alipanchasuweethouse@gmail.com	0766650658	Kotaweheragala, Wellawaya, Monaragala.
10	Munchee	Munchee@gmail.com	0777967498	P.O.Box 03, Pannipitiya.
11	Diana Biscuits Pvt Ltd	info@diana.lk	0702339699	Weragama, Kaikawala, Matale.
12	Little Lion	littlelion@gmail.com	0117885000	No. 11, A.G. Hinniappuhamy Mawatha, Colombo-13.
\.


--
-- Data for Name: user_credentials; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_credentials (user_id, username, password, updated_on) FROM stdin;
1	somesh	$2b$12$JotH3Y0O2ChThIspRWQvqeEBrUQkgvJLL5Ch402.mXhLPzL6fsuxG	2025-10-26 04:37:00.961194-07
2	johndoe	$2a$06$fMSkRWP1OP6ktkSbH/1v9.5CIa99G6vaGKV2Q0efM3TLsPak4d.SG	2025-10-26 04:37:00.961194-07
3	janesmith	$2a$06$24f3cd9Cqg5gbm9D7UQUaOikO5Rdo6Gmv9Zx2XZOFLxiRJDDdU8f2	2025-10-26 04:37:00.961194-07
4	robertjohnson	$2a$06$uhtaKV52sYvSqZsergwsy.sJwoK2XN6Pn8QIrNbSCJAn5CL6pW0o6	2025-10-26 04:37:00.961194-07
5	marywilson	$2a$06$ihDg/lon3oO9D5LeY.HpMOM/s/d3NgfA710GlS1BUeYnK2.gO/WJm	2025-10-26 04:37:00.961194-07
6	michaellee	$2a$06$l5p/JvdR9HCZw8zSk30YBO1EDEg/vJLJthVpo/aON5b1LlWDkXml6	2025-10-26 04:37:00.961194-07
7	lisagarcia	$2a$06$QQqUA8hiSUUXBxTR4MUOUera4P66.KuVqaZauR/UlWfwBWEw0WQtG	2025-10-26 04:37:00.961194-07
8	davidmartinez	$2a$06$vqcaOfn0Y.mvs6Q5/W7lYe4d4mADltYXoIdpFh4v.T7IlO..LY7xm	2025-10-26 04:37:00.961194-07
9	sarahbrown	$2a$06$ahWTjAQQ5/oJI4esIjYFse4k/O7gkDCqVY1CUw.UiSwmp.kfnrMnu	2025-10-26 04:37:00.961194-07
10	williamsmith	$2a$06$RZ/X5HFC9dgXIQJHdP91.OncG203.WlwL7spQRLjVIYYrVPFZNaG2	2025-10-26 04:37:00.961194-07
11	karendavis	$2a$06$U2O/jOEg2n/txLisV.4JxOt/XwjxaCgwY4/QetpqQk7YkZg0qOU4O	2025-10-26 04:37:00.961194-07
12	jamestaylor	$2a$06$2HJJ9gDHJ95tQtBdC8qJbuTE8KetOPzK1V3AwnMvL6BcmUXNj/o46	2025-10-26 04:37:00.961194-07
13	jenniferclark	$2a$06$KCZNU8wFQjKTw.av64Yet.UVrxlXJGEHbUcS6DcqHojHzrgDeL6bi	2025-10-26 04:37:00.961194-07
14	josephjohnson	$2a$06$3ZkSiXZzCbnIR9Mok5SB1enVIe/DU7jwshA7/xWefsXG.UJ0FtLM6	2025-10-26 04:37:00.961194-07
15	nancymoore	$2a$06$0gkHSURQlzNfRl1kftTyhOn42G2PU.XvfgLBDZI05IQAvZiAYfQ8q	2025-10-26 04:37:00.961194-07
16	robertwhite	$2a$06$JcpsEe2ULo/Mxb2ER2HL0O/aPkPGznFCi4BzOm1Lkv4tYIeeVTEDa	2025-10-26 04:37:00.961194-07
17	lindaharris	$2a$06$BC0JqTh.9m8xwA2.j/AZ5.9xotYj2WewB9eM33o35aKoT3h27baiy	2025-10-26 04:37:00.961194-07
18	johnmiller	$2a$06$3Lom14a9i/kzq/hpjx6rnO7MjXtTpsa/IUxUwNiZD0ZFOR00v7vBm	2025-10-26 04:37:00.961194-07
19	patriciagarcia	$2a$06$zMT2vX.gQsbavvHrwX/o5eNvXdzxPYwFvJj9XH6mlSre3LKO0ePOW	2025-10-26 04:37:00.961194-07
20	robertbrown	$2a$06$vaTrOhvHrXhf0VpqyXvg1e/K8bM9XQvHhCtZhsCOfCMgoKq2x08TG	2025-10-26 04:37:00.961194-07
\.


--
-- Data for Name: user_role; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_role (role_id, role_name, role_desc, user_access) FROM stdin;
1	Owner	Responsible for overall management and ownership of the supermarket.	{1,2,3,4}
4	Cashier	Handles customer transactions at the checkout counter.	{1,2,3,4}
3	Branch Manager	Manages the day-to-day operations of a specific branch.	{2,3,4,5,8,7,10,9,11,12,13,14,15,6}
2	Finance Manager	Responsible for financial reporting and analysis.	{2,3,4,5,6,7,8,10,9,12,11,13,14,15}
\.


--
-- Data for Name: variable_options; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.variable_options (variable_id, variable_name, created_at, variable_value, updated_on) FROM stdin;
1	rewards_points_percentage	2025-10-26 04:37:01-07	0.50	2025-10-26 04:37:01-07
\.


--
-- Data for Name: working_hour; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.working_hour (employee_id, date, shift_on, shift_off, updated_by, present, total_hours, branch_id) FROM stdin;
\.


--
-- Name: access_type_access_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.access_type_access_type_id_seq', 1, false);


--
-- Name: cart_cart_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cart_cart_id_seq', 144, true);


--
-- Name: category_category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.category_category_id_seq', 1, false);


--
-- Name: customer_customer_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.customer_customer_id_seq', 47, true);


--
-- Name: discount_discount_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.discount_discount_id_seq', 1, false);


--
-- Name: employee_employee_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.employee_employee_id_seq', 1, false);


--
-- Name: sales_history_order_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sales_history_order_id_seq', 111, true);


--
-- Name: supplier_supplier_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.supplier_supplier_id_seq', 12, true);


--
-- Name: user_role_role_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_role_role_id_seq', 1, false);


--
-- Name: variable_options_variable_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.variable_options_variable_id_seq', 1, true);


--
-- Name: _prisma_migrations _prisma_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public._prisma_migrations
    ADD CONSTRAINT _prisma_migrations_pkey PRIMARY KEY (id);


--
-- Name: access_type access_type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.access_type
    ADD CONSTRAINT access_type_pkey PRIMARY KEY (access_type_id);


--
-- Name: branch branch_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.branch
    ADD CONSTRAINT branch_pkey PRIMARY KEY (branch_id);


--
-- Name: cart cart_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cart
    ADD CONSTRAINT cart_pkey PRIMARY KEY (cart_id);


--
-- Name: category category_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.category
    ADD CONSTRAINT category_pkey PRIMARY KEY (category_id);


--
-- Name: customer customer_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer
    ADD CONSTRAINT customer_pkey PRIMARY KEY (customer_id);


--
-- Name: discount discount_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.discount
    ADD CONSTRAINT discount_pkey PRIMARY KEY (discount_id);


--
-- Name: employee employee_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employee
    ADD CONSTRAINT employee_pkey PRIMARY KEY (employee_id);


--
-- Name: inventory inventory_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inventory
    ADD CONSTRAINT inventory_pkey PRIMARY KEY (product_id, branch_id);


--
-- Name: product product_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product
    ADD CONSTRAINT product_pkey PRIMARY KEY (product_id);


--
-- Name: product_variants product_variants_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_variants
    ADD CONSTRAINT product_variants_pkey PRIMARY KEY (variant_id);


--
-- Name: sales_history sales_history_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sales_history
    ADD CONSTRAINT sales_history_pkey PRIMARY KEY (order_id);


--
-- Name: supplier supplier_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.supplier
    ADD CONSTRAINT supplier_pkey PRIMARY KEY (supplier_id);


--
-- Name: user_credentials user_credentials_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_credentials
    ADD CONSTRAINT user_credentials_pkey PRIMARY KEY (user_id);


--
-- Name: user_role user_role_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_role
    ADD CONSTRAINT user_role_pkey PRIMARY KEY (role_id);


--
-- Name: variable_options variable_options_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.variable_options
    ADD CONSTRAINT variable_options_pkey PRIMARY KEY (variable_id);


--
-- Name: working_hour working_hour_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.working_hour
    ADD CONSTRAINT working_hour_pkey PRIMARY KEY (employee_id, branch_id, date);


--
-- Name: access_type_access_name_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX access_type_access_name_key ON public.access_type USING btree (access_name);


--
-- Name: branch_branch_city_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX branch_branch_city_key ON public.branch USING btree (branch_city);


--
-- Name: branch_branch_email_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX branch_branch_email_key ON public.branch USING btree (branch_email);


--
-- Name: branch_branch_phone_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX branch_branch_phone_key ON public.branch USING btree (branch_phone);


--
-- Name: category_category_name_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX category_category_name_key ON public.category USING btree (category_name);


--
-- Name: customer_customer_email_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX customer_customer_email_key ON public.customer USING btree (customer_email);


--
-- Name: customer_customer_phone_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX customer_customer_phone_key ON public.customer USING btree (customer_phone);


--
-- Name: discount_discount_name_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX discount_discount_name_key ON public.discount USING btree (discount_name);


--
-- Name: employee_employee_email_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX employee_employee_email_key ON public.employee USING btree (employee_email);


--
-- Name: employee_employee_phone_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX employee_employee_phone_key ON public.employee USING btree (employee_phone);


--
-- Name: product_product_barcode_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX product_product_barcode_key ON public.product USING btree (product_barcode);


--
-- Name: product_product_name_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX product_product_name_key ON public.product USING btree (product_name);


--
-- Name: supplier_supplier_email_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX supplier_supplier_email_key ON public.supplier USING btree (supplier_email);


--
-- Name: supplier_supplier_phone_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX supplier_supplier_phone_key ON public.supplier USING btree (supplier_phone);


--
-- Name: user_credentials_password_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX user_credentials_password_key ON public.user_credentials USING btree (password);


--
-- Name: user_credentials_username_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX user_credentials_username_key ON public.user_credentials USING btree (username);


--
-- Name: user_role_role_name_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX user_role_role_name_key ON public.user_role USING btree (role_name);


--
-- Name: variable_options_variable_name_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX variable_options_variable_name_key ON public.variable_options USING btree (variable_name);


--
-- Name: cart fk_cart_product; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cart
    ADD CONSTRAINT fk_cart_product FOREIGN KEY (product_id) REFERENCES public.product(product_id) ON DELETE CASCADE;


--
-- Name: cart fk_cart_sales_history; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cart
    ADD CONSTRAINT fk_cart_sales_history FOREIGN KEY (order_id) REFERENCES public.sales_history(order_id) ON DELETE CASCADE;


--
-- Name: employee fk_employee_branch; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employee
    ADD CONSTRAINT fk_employee_branch FOREIGN KEY (branch_id) REFERENCES public.branch(branch_id);


--
-- Name: working_hour fk_employee_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.working_hour
    ADD CONSTRAINT fk_employee_id FOREIGN KEY (employee_id) REFERENCES public.employee(employee_id);


--
-- Name: employee fk_employee_role; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employee
    ADD CONSTRAINT fk_employee_role FOREIGN KEY (role_id) REFERENCES public.user_role(role_id);


--
-- Name: inventory fk_inventory_branch; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inventory
    ADD CONSTRAINT fk_inventory_branch FOREIGN KEY (branch_id) REFERENCES public.branch(branch_id) ON DELETE CASCADE;


--
-- Name: inventory fk_inventory_product; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inventory
    ADD CONSTRAINT fk_inventory_product FOREIGN KEY (product_id) REFERENCES public.product(product_id) ON DELETE CASCADE;


--
-- Name: product fk_product_category; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product
    ADD CONSTRAINT fk_product_category FOREIGN KEY (category_id) REFERENCES public.category(category_id) ON DELETE CASCADE;


--
-- Name: product_variants fk_product_variants; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_variants
    ADD CONSTRAINT fk_product_variants FOREIGN KEY (product_id) REFERENCES public.product(product_id) ON DELETE CASCADE;


--
-- Name: sales_history fk_sales_history_branch; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sales_history
    ADD CONSTRAINT fk_sales_history_branch FOREIGN KEY (branch_id) REFERENCES public.branch(branch_id) ON DELETE CASCADE;


--
-- Name: sales_history fk_sales_history_customer; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sales_history
    ADD CONSTRAINT fk_sales_history_customer FOREIGN KEY (customer_id) REFERENCES public.customer(customer_id) ON DELETE CASCADE;


--
-- Name: sales_history fk_sales_history_employee; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sales_history
    ADD CONSTRAINT fk_sales_history_employee FOREIGN KEY (cashier_id) REFERENCES public.employee(employee_id) ON DELETE CASCADE;


--
-- Name: product fk_supplier_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product
    ADD CONSTRAINT fk_supplier_id FOREIGN KEY (supplier_id) REFERENCES public.supplier(supplier_id);


--
-- Name: working_hour fk_updated_by; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.working_hour
    ADD CONSTRAINT fk_updated_by FOREIGN KEY (updated_by) REFERENCES public.employee(employee_id);


--
-- Name: user_credentials fk_user_credentials_employee; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_credentials
    ADD CONSTRAINT fk_user_credentials_employee FOREIGN KEY (user_id) REFERENCES public.employee(employee_id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

\unrestrict Ks4Hlc4vF3hOLbfv2p97FS8IRnxKhaVIH0TiFOW3IZT26laDpk3hWROdEBddVnL

