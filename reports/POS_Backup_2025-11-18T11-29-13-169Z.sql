--
-- PostgreSQL database dump
--

\restrict lryKgfdLGTq4LG80OvmXhBPV6GDEdkKvFeoHXerSh61bZCHridGhvJRKhZ3XsMV

-- Dumped from database version 18.1 (Debian 18.1-1.pgdg13+2)
-- Dumped by pg_dump version 18.1 (Debian 18.1-1.pgdg13+2)

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
b0d6d713-7c78-4602-ada9-b473e483480f	08dd35980c2bf875c4604ab518a0585f0f4016b08ef591d3c4bfe78db83db238	2025-11-16 06:43:05.347698+00	20251022210925_init	\N	\N	2025-11-16 06:43:05.327812+00	1
0bbca7e8-3b7b-45ab-88d5-46cb219ddb11	65775224d6eba84784f4d46f83b1be5fee72d7abb8e75dd312c395def151bbbe	2025-11-16 06:43:05.356062+00	20251024105251_product_variant	\N	\N	2025-11-16 06:43:05.34957+00	1
1036a72a-e9df-4c50-87d9-f5b5dab582bf	1c9b6083ae10f113d644711f4cfc5ff64220435bec80121831ad33d66d6733a9	2025-11-16 06:43:05.36317+00	20251024110721_variant_label	\N	\N	2025-11-16 06:43:05.357862+00	1
a4c9f650-1c0c-4844-992d-4500f70fe4a2	4a6b7518a7eaaacf11a4ee1dbea0e01074bb6f9b1e1f8e28546995692edc01d0	2025-11-16 06:43:05.370318+00	20251024202620_stock_type	\N	\N	2025-11-16 06:43:05.365093+00	1
cb1c97ee-9e0e-4173-8e88-29dcb344cb90	5b51e5568fd3ebe8c397ceda6bf2907711e697b5be6094d01b23717f3d084e8a	2025-11-16 06:43:05.377364+00	20251024211208_credit	\N	\N	2025-11-16 06:43:05.372161+00	1
d2470d6c-e0f4-4a05-93c6-0fc36de7b559	e409600e4eff572d45970b39a24c2550644a41b9c9a485e81000e31797cbfce8	2025-11-16 06:43:05.384753+00	20251101144524_payment_method	\N	\N	2025-11-16 06:43:05.379119+00	1
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
45ba25bb-eab9-461f-a93b-559e4e8c74e4	Colombo	123 Main St, Colombo 01	112233445	colombobranch@example.com	2025-11-18 10:25:01.940881+00
aeda1973-4148-474a-8153-c199958a59c6	Kandy	456 Elm St, Kandy 20000	814325678	kandybranch@example.com	2025-11-18 10:25:01.940881+00
f6fed7de-dba7-4988-b73b-b775c7577bc2	Galle	789 Oak St, Galle 80000	912345678	gallebranch@example.com	2025-11-18 10:25:01.940881+00
d0fdf18f-40af-46d3-9475-81465cf61994	Anuradhapura	789 Pine St, Anuradhapura 50000	762345678	anuradhapurabranch@example.com	2025-11-18 10:25:01.940881+00
\.


--
-- Data for Name: cart; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cart (cart_id, order_id, product_id, quantity, sub_total_amount, created_at) FROM stdin;
1	1	b34ea334-9f36-4c3e-92a1-449fdae018e7	3	90.00	2023-08-15
2	1	6782cdfd-6476-4b95-974d-456a9383bbd0	2	95.00	2023-08-15
3	1	c52c8756-9213-45ac-87cc-b3e49fac9095	1	50.00	2023-08-15
4	2	13f9f76c-0407-4092-a71a-375de6452c74	2	64.18	2023-08-15
5	2	4525dfa6-601c-4b79-a74b-c406acf73370	5	33.25	2023-08-15
6	3	38ec3114-66a3-4f71-b018-e63e8e286a8f	1	180.72	2023-08-20
7	3	421179a8-d49f-49fa-b542-fd1a997b2cfb	3	300.00	2023-08-20
8	4	5e51e5e5-1d84-4f41-956a-70db73e8e7b6	4	47.74	2023-08-25
9	4	8a6752b9-e9ca-44c6-a9c0-cc562a5ac21b	2	90.00	2023-08-25
10	5	f2ea548c-0b0a-4124-9f97-4f5c211534c8	1	25.00	2023-08-25
11	6	ef8a2608-3168-4cec-9e5c-9f03f5555699	2	71.96	2023-08-31
12	6	e53ec0ef-eec0-4e3f-8e75-79e2e29c9b5d	3	75.75	2023-08-31
13	7	0acf7d7e-b925-4422-b8c3-9e9e2069dcf4	4	270.00	2023-09-01
14	8	63de162b-3ffa-4b1e-9963-53c24e90b18c	5	170.42	2023-09-01
15	9	fe476643-4e56-40b4-a9ef-a8063256654f	1	100.25	2023-09-02
16	10	d87c4075-3991-4168-9a8a-cf41183474a2	2	357.96	2023-09-05
17	10	3b0913d5-e5fe-44bc-833a-bdd633267f63	3	270.00	2023-09-05
18	11	c813f8a5-19ea-4687-94ab-fd9e189ccdd6	4	450.00	2023-09-05
19	12	98f6c185-4401-4252-8ab8-60dc63836f0a	5	237.50	2023-09-10
20	13	5dba6b8a-349c-43e3-8449-ffa0e6849e2d	1	100.00	2023-09-12
21	14	ef8a2608-3168-4cec-9e5c-9f03f5555699	2	200.50	2023-09-15
22	15	13f9f76c-0407-4092-a71a-375de6452c74	2	399.00	2023-09-27
23	15	b34ea334-9f36-4c3e-92a1-449fdae018e7	2	139.00	2023-09-27
24	16	b34ea334-9f36-4c3e-92a1-449fdae018e7	2	139.00	2023-09-28
25	17	98f6c185-4401-4252-8ab8-60dc63836f0a	1	1249.00	2023-09-28
26	17	5e51e5e5-1d84-4f41-956a-70db73e8e7b6	2	499.00	2023-09-28
27	18	6782cdfd-6476-4b95-974d-456a9383bbd0	2	139.00	2023-09-29
28	18	5dba6b8a-349c-43e3-8449-ffa0e6849e2d	1	449.00	2023-09-29
29	19	5dba6b8a-349c-43e3-8449-ffa0e6849e2d	1	449.00	2023-09-01
30	19	6782cdfd-6476-4b95-974d-456a9383bbd0	1	69.00	2023-09-01
31	20	98f6c185-4401-4252-8ab8-60dc63836f0a	1	1249.00	2023-09-02
32	21	421179a8-d49f-49fa-b542-fd1a997b2cfb	3	688.00	2023-09-03
33	22	5e51e5e5-1d84-4f41-956a-70db73e8e7b6	1	249.00	2023-09-03
34	22	f2ea548c-0b0a-4124-9f97-4f5c211534c8	2	599.00	2023-09-03
35	23	b34ea334-9f36-4c3e-92a1-449fdae018e7	2	139.00	2023-09-03
36	23	6782cdfd-6476-4b95-974d-456a9383bbd0	3	209.00	2023-09-03
37	23	c52c8756-9213-45ac-87cc-b3e49fac9095	1	119.00	2023-09-03
38	24	38ec3114-66a3-4f71-b018-e63e8e286a8f	2	439.00	2023-09-04
39	25	8a6752b9-e9ca-44c6-a9c0-cc562a5ac21b	3	539.00	2023-09-05
40	25	fe476643-4e56-40b4-a9ef-a8063256654f	1	189.00	2023-09-05
41	25	ef8a2608-3168-4cec-9e5c-9f03f5555699	1	599.00	2023-09-05
42	26	e53ec0ef-eec0-4e3f-8e75-79e2e29c9b5d	1	474.00	2023-09-07
43	26	0acf7d7e-b925-4422-b8c3-9e9e2069dcf4	1	359.00	2023-09-07
44	27	b34ea334-9f36-4c3e-92a1-449fdae018e7	3	209.00	2023-09-18
45	28	c52c8756-9213-45ac-87cc-b3e49fac9095	1	119.00	2023-09-23
46	28	d87c4075-3991-4168-9a8a-cf41183474a2	1	199.00	2023-09-23
47	29	5e51e5e5-1d84-4f41-956a-70db73e8e7b6	1	249.00	2023-09-08
48	30	d87c4075-3991-4168-9a8a-cf41183474a2	1	199.00	2023-09-14
49	30	3b0913d5-e5fe-44bc-833a-bdd633267f63	1	319.00	2023-09-14
50	31	d87c4075-3991-4168-9a8a-cf41183474a2	1	199.00	2023-09-14
51	31	3b0913d5-e5fe-44bc-833a-bdd633267f63	1	319.00	2023-09-14
52	32	5e51e5e5-1d84-4f41-956a-70db73e8e7b6	1	249.00	2023-10-01
53	32	6782cdfd-6476-4b95-974d-456a9383bbd0	1	69.00	2023-10-01
54	33	5dba6b8a-349c-43e3-8449-ffa0e6849e2d	2	899.00	2023-10-02
55	34	c52c8756-9213-45ac-87cc-b3e49fac9095	1	119.00	2023-10-03
56	34	ef8a2608-3168-4cec-9e5c-9f03f5555699	1	599.00	2023-10-03
57	35	38ec3114-66a3-4f71-b018-e63e8e286a8f	1	219.00	2023-10-04
58	35	0acf7d7e-b925-4422-b8c3-9e9e2069dcf4	1	359.00	2023-10-04
59	36	38ec3114-66a3-4f71-b018-e63e8e286a8f	2	439.00	2023-10-06
60	37	4525dfa6-601c-4b79-a74b-c406acf73370	2	419.00	2023-10-06
61	38	421179a8-d49f-49fa-b542-fd1a997b2cfb	3	688.00	2023-10-06
62	39	b34ea334-9f36-4c3e-92a1-449fdae018e7	1	69.00	2023-10-07
63	39	6782cdfd-6476-4b95-974d-456a9383bbd0	1	69.00	2023-10-07
64	39	c52c8756-9213-45ac-87cc-b3e49fac9095	1	119.00	2023-10-07
65	40	c813f8a5-19ea-4687-94ab-fd9e189ccdd6	2	1699.00	2023-10-08
66	41	38ec3114-66a3-4f71-b018-e63e8e286a8f	1	219.00	2023-10-10
67	41	0acf7d7e-b925-4422-b8c3-9e9e2069dcf4	2	719.00	2023-10-10
68	42	f2ea548c-0b0a-4124-9f97-4f5c211534c8	6	1799.00	2023-10-11
69	43	421179a8-d49f-49fa-b542-fd1a997b2cfb	1	228.00	2023-10-11
70	44	5dba6b8a-349c-43e3-8449-ffa0e6849e2d	1	449.00	2023-10-12
71	45	98f6c185-4401-4252-8ab8-60dc63836f0a	3	3749.00	2023-10-13
72	46	38ec3114-66a3-4f71-b018-e63e8e286a8f	1	219.00	2023-10-15
73	46	b34ea334-9f36-4c3e-92a1-449fdae018e7	1	69.00	2023-10-15
74	46	4525dfa6-601c-4b79-a74b-c406acf73370	3	629.00	2023-10-15
75	47	13f9f76c-0407-4092-a71a-375de6452c74	4	799.00	2023-10-16
76	47	421179a8-d49f-49fa-b542-fd1a997b2cfb	2	458.00	2023-10-16
77	47	38ec3114-66a3-4f71-b018-e63e8e286a8f	1	219.00	2023-10-16
78	48	f2ea548c-0b0a-4124-9f97-4f5c211534c8	2	599.00	2023-10-17
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
1	Ruth Lawles	rlawles0@seattletimes.com	5921508750	1693 Atwood Trail	1	44.90	2025-11-18 10:25:01.940881+00	0.00
2	Mersey Roller	mroller1@wikispaces.com	4985745753	21472 Fisk Crossing	2	108.06	2025-11-18 10:25:01.940881+00	0.00
3	Hildegaard Fawdry	hfawdry2@yolasite.com	5268053265	9 Riverside Parkway	3	62.65	2025-11-18 10:25:01.940881+00	0.00
4	Tades Solly	tsolly3@gravatar.com	2719821318	68418 American Lane	4	12.86	2025-11-18 10:25:01.940881+00	0.00
5	Rycca Banaszewski	rbanaszewski4@reddit.com	9029815205	8502 Clyde Gallagher Park	5	39.14	2025-11-18 10:25:01.940881+00	0.00
6	Karee Cummine	kcummine5@mapy.cz	9995455220	155 Birchwood Hill	6	68.18	2025-11-18 10:25:01.940881+00	0.00
7	Bondy Eggleson	beggleson6@sciencedaily.com	3941144811	6095 Forster Drive	7	143.18	2025-11-18 10:25:01.940881+00	0.00
8	Natalie Allardyce	nallardyce7@fastcompany.com	6187581464	8894 Moulton Alley	8	16.68	2025-11-18 10:25:01.940881+00	0.00
9	Levi Aleksidze	laleksidze8@slashdot.org	4756678751	12 Tony Park	9	139.59	2025-11-18 10:25:01.940881+00	0.00
10	Louisa Saffin	lsaffin9@time.com	5941946586	7 Warbler Way	10	91.55	2025-11-18 10:25:01.940881+00	0.00
11	Brigitta Corder	bcordera@google.es	4468475060	71 Delaware Place	11	59.10	2025-11-18 10:25:01.940881+00	0.00
12	Ryan Sawley	rsawleyb@canalblog.com	6492502987	2 Moose Lane	12	134.98	2025-11-18 10:25:01.940881+00	0.00
13	Letisha Pedden	lpeddenc@devhub.com	7912229080	1 Holy Cross Road	13	57.52	2025-11-18 10:25:01.940881+00	0.00
14	Sky Jannaway	sjannawayd@moonfruit.com	8963624803	2570 Golf View Trail	14	34.71	2025-11-18 10:25:01.940881+00	0.00
15	Pepi Ealam	pealame@google.co.jp	9202071354	6097 Erie Alley	15	26.32	2025-11-18 10:25:01.940881+00	0.00
16	Almeda Sowle	asowlef@ocn.ne.jp	8352786190	35 Forest Run Junction	16	72.48	2025-11-18 10:25:01.940881+00	0.00
17	Bride McParland	bmcparlandg@hatena.ne.jp	9772622371	2775 Stephen Hill	17	95.77	2025-11-18 10:25:01.940881+00	0.00
18	Mick Legate	mlegateh@tripadvisor.com	3131136306	5 Mesta Avenue	18	113.22	2025-11-18 10:25:01.940881+00	0.00
19	Brade Ferrino	bferrinoi@opensource.org	3195673062	8126 Lighthouse Bay Way	19	3.32	2025-11-18 10:25:01.940881+00	0.00
20	Richmound Guillford	rguillfordj@trellian.com	2199275143	34956 Graedel Terrace	20	38.58	2025-11-18 10:25:01.940881+00	0.00
21	Griz Karsh	gkarshk@oracle.com	2264651162	5453 Manufacturers Street	21	28.49	2025-11-18 10:25:01.940881+00	0.00
22	Allyce Halsall	ahalsalll@jalbum.net	9934037108	6 Lighthouse Bay Road	22	126.54	2025-11-18 10:25:01.940881+00	0.00
23	Danyelle Mico	dmicom@cdc.gov	3937996317	94509 Oneill Hill	23	148.89	2025-11-18 10:25:01.940881+00	0.00
24	Ariana Hengoed	ahengoedn@dion.ne.jp	5079190954	0 Hoard Court	24	31.03	2025-11-18 10:25:01.940881+00	0.00
25	Nichols Candey	ncandeyo@reuters.com	3083019477	00 Duke Street	25	98.57	2025-11-18 10:25:01.940881+00	0.00
26	Sutherland Juste	sjustep@tumblr.com	1962699631	9 Huxley Junction	26	138.61	2025-11-18 10:25:01.940881+00	0.00
27	Craig Flecknoe	cflecknoeq@disqus.com	1113654214	36332 Linden Place	27	138.82	2025-11-18 10:25:01.940881+00	0.00
28	Bell McGillecole	bmcgillecoler@infoseek.co.jp	9194662963	9907 North Plaza	28	4.80	2025-11-18 10:25:01.940881+00	0.00
29	Bartram D'Alessandro	bdalessandros@dailymotion.com	5594993159	3 Eagan Center	29	2.98	2025-11-18 10:25:01.940881+00	0.00
30	Tye Brookbank	tbrookbankt@oaic.gov.au	3973885329	3 5th Park	30	24.49	2025-11-18 10:25:01.940881+00	0.00
31	Durante Cable	dcableu@deliciousdays.com	7715263186	2 Holmberg Court	31	40.97	2025-11-18 10:25:01.940881+00	0.00
32	Delly Bobasch	dbobaschv@irs.gov	4681849719	426 Muir Court	32	20.08	2025-11-18 10:25:01.940881+00	0.00
33	Katey Maddison	kmaddisonw@goo.ne.jp	9533359639	43 Annamark Alley	33	22.31	2025-11-18 10:25:01.940881+00	0.00
34	Lotta Bigrigg	lbigriggx@wunderground.com	3189193913	0796 Sachs Circle	34	61.17	2025-11-18 10:25:01.940881+00	0.00
35	Rhys Banaszczyk	rbanaszczyky@youtube.com	7798215611	540 David Trail	35	72.54	2025-11-18 10:25:01.940881+00	0.00
36	Teresina Hill	thillz@examiner.com	1143376907	3098 Stoughton Trail	36	35.45	2025-11-18 10:25:01.940881+00	0.00
37	Laurent Blann	lblann10@google.com.hk	8651209978	8769 Messerschmidt Terrace	37	134.10	2025-11-18 10:25:01.940881+00	0.00
38	Garwood Rothman	grothman11@wired.com	5069606418	6507 Westerfield Pass	38	14.81	2025-11-18 10:25:01.940881+00	0.00
39	Kelley Bend	kbend12@digg.com	6299322810	28 Memorial Lane	39	52.81	2025-11-18 10:25:01.940881+00	0.00
40	Porty Blitzer	pblitzer13@ucoz.ru	4228422022	60718 Swallow Center	40	47.23	2025-11-18 10:25:01.940881+00	0.00
41	Ivor Keesman	ikeesman14@hugedomains.com	2325980038	9499 Sauthoff Lane	41	146.84	2025-11-18 10:25:01.940881+00	0.00
42	Jeremie Yakutin	jyakutin15@upenn.edu	1194535207	72 Moland Alley	42	115.11	2025-11-18 10:25:01.940881+00	0.00
43	Jessica Robeson	jrobeson16@blogger.com	1497335402	90 Drewry Court	43	7.25	2025-11-18 10:25:01.940881+00	0.00
44	Corissa Varty	cvarty17@stanford.edu	3918785556	24060 Continental Drive	44	52.83	2025-11-18 10:25:01.940881+00	0.00
45	Maynord Nafziger	mnafziger18@noaa.gov	3941403854	84187 Crownhardt Road	45	68.69	2025-11-18 10:25:01.940881+00	0.00
46	Fowler Chantler	fchantler19@angelfire.com	9981381006	184 Texas Court	46	55.48	2025-11-18 10:25:01.940881+00	0.00
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
1	Somesh Chandimal	1	2022-01-15 00:00:00+00	somesh@example.com	112233445	45ba25bb-eab9-461f-a93b-559e4e8c74e4	employee-image-placeholder.jpg	2025-11-18 10:25:01.940881+00	2025-11-18 10:25:01.940881+00
2	John Doe	2	2022-05-15 00:00:00+00	johndoe@example.com	112243445	45ba25bb-eab9-461f-a93b-559e4e8c74e4	employee-image-placeholder.jpg	2025-11-18 10:25:01.940881+00	2025-11-18 10:25:01.940881+00
3	Jane Smith	2	2021-12-10 00:00:00+00	janesmith@example.com	998877665	aeda1973-4148-474a-8153-c199958a59c6	employee-image-placeholder.jpg	2025-11-18 10:25:01.940881+00	2025-11-18 10:25:01.940881+00
4	Robert Johnson	2	2023-02-28 00:00:00+00	robertjohnson@example.com	777766655	f6fed7de-dba7-4988-b73b-b775c7577bc2	employee-image-placeholder.jpg	2025-11-18 10:25:01.940881+00	2025-11-18 10:25:01.940881+00
5	Mary Wilson	2	2022-09-30 00:00:00+00	marywilson@example.com	333444555	d0fdf18f-40af-46d3-9475-81465cf61994	employee-image-placeholder.jpg	2025-11-18 10:25:01.940881+00	2025-11-18 10:25:01.940881+00
6	Michael Lee	3	2020-07-05 00:00:00+00	michaellee@example.com	222555444	45ba25bb-eab9-461f-a93b-559e4e8c74e4	employee-image-placeholder.jpg	2025-11-18 10:25:01.940881+00	2025-11-18 10:25:01.940881+00
7	Lisa Garcia	3	2021-10-20 00:00:00+00	lisagarcia@example.com	666555444	aeda1973-4148-474a-8153-c199958a59c6	employee-image-placeholder.jpg	2025-11-18 10:25:01.940881+00	2025-11-18 10:25:01.940881+00
8	David Martinez	3	2022-04-15 00:00:00+00	davidmartinez@example.com	777444555	f6fed7de-dba7-4988-b73b-b775c7577bc2	employee-image-placeholder.jpg	2025-11-18 10:25:01.940881+00	2025-11-18 10:25:01.940881+00
9	Sarah Brown	3	2021-03-25 00:00:00+00	sarahbrown@example.com	555444333	d0fdf18f-40af-46d3-9475-81465cf61994	employee-image-placeholder.jpg	2025-11-18 10:25:01.940881+00	2025-11-18 10:25:01.940881+00
10	William Smith	4	2022-01-05 00:00:00+00	williamsmith@example.com	777888999	45ba25bb-eab9-461f-a93b-559e4e8c74e4	employee-image-placeholder.jpg	2025-11-18 10:25:01.940881+00	2025-11-18 10:25:01.940881+00
11	Karen Davis	4	2023-06-30 00:00:00+00	karendavis@example.com	444555666	45ba25bb-eab9-461f-a93b-559e4e8c74e4	employee-image-placeholder.jpg	2025-11-18 10:25:01.940881+00	2025-11-18 10:25:01.940881+00
12	James Taylor	4	2022-08-15 00:00:00+00	jamestaylor@example.com	555747888	45ba25bb-eab9-461f-a93b-559e4e8c74e4	employee-image-placeholder.jpg	2025-11-18 10:25:01.940881+00	2025-11-18 10:25:01.940881+00
13	Jennifer Clark	4	2021-11-10 00:00:00+00	jenniferclark@example.com	999888777	aeda1973-4148-474a-8153-c199958a59c6	employee-image-placeholder.jpg	2025-11-18 10:25:01.940881+00	2025-11-18 10:25:01.940881+00
14	Joseph Johnson	4	2023-01-15 00:00:00+00	josephjohnson@example.com	555666777	aeda1973-4148-474a-8153-c199958a59c6	employee-image-placeholder.jpg	2025-11-18 10:25:01.940881+00	2025-11-18 10:25:01.940881+00
15	Nancy Moore	4	2021-04-20 00:00:00+00	nancymoore@example.com	444666555	aeda1973-4148-474a-8153-c199958a59c6	employee-image-placeholder.jpg	2025-11-18 10:25:01.940881+00	2025-11-18 10:25:01.940881+00
16	Robert White	4	2020-11-05 00:00:00+00	robertwhite@example.com	333777666	f6fed7de-dba7-4988-b73b-b775c7577bc2	employee-image-placeholder.jpg	2025-11-18 10:25:01.940881+00	2025-11-18 10:25:01.940881+00
17	Linda Harris	4	2022-02-28 00:00:00+00	lindaharris@example.com	222777888	f6fed7de-dba7-4988-b73b-b775c7577bc2	employee-image-placeholder.jpg	2025-11-18 10:25:01.940881+00	2025-11-18 10:25:01.940881+00
18	John Miller	4	2023-03-10 00:00:00+00	johnmiller@example.com	444555444	f6fed7de-dba7-4988-b73b-b775c7577bc2	employee-image-placeholder.jpg	2025-11-18 10:25:01.940881+00	2025-11-18 10:25:01.940881+00
19	Patricia Garcia	4	2022-07-01 00:00:00+00	patriciagarcia@example.com	777555444	d0fdf18f-40af-46d3-9475-81465cf61994	employee-image-placeholder.jpg	2025-11-18 10:25:01.940881+00	2025-11-18 10:25:01.940881+00
20	Robert Brown	4	2020-12-25 00:00:00+00	robertbrown@example.com	666444555	d0fdf18f-40af-46d3-9475-81465cf61994	employee-image-placeholder.jpg	2025-11-18 10:25:01.940881+00	2025-11-18 10:25:01.940881+00
\.


--
-- Data for Name: inventory; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.inventory (product_id, branch_id, quantity, reorder_level, updated_on) FROM stdin;
b34ea334-9f36-4c3e-92a1-449fdae018e7	45ba25bb-eab9-461f-a93b-559e4e8c74e4	500	100	2023-07-05 10:00:00+00
b34ea334-9f36-4c3e-92a1-449fdae018e7	aeda1973-4148-474a-8153-c199958a59c6	500	100	2023-07-05 11:00:00+00
b34ea334-9f36-4c3e-92a1-449fdae018e7	f6fed7de-dba7-4988-b73b-b775c7577bc2	300	50	2023-07-10 11:00:00+00
6782cdfd-6476-4b95-974d-456a9383bbd0	45ba25bb-eab9-461f-a93b-559e4e8c74e4	200	30	2023-08-01 10:00:00+00
6782cdfd-6476-4b95-974d-456a9383bbd0	f6fed7de-dba7-4988-b73b-b775c7577bc2	150	20	2023-08-01 10:01:00+00
6782cdfd-6476-4b95-974d-456a9383bbd0	d0fdf18f-40af-46d3-9475-81465cf61994	100	15	2023-08-01 10:02:00+00
13f9f76c-0407-4092-a71a-375de6452c74	d0fdf18f-40af-46d3-9475-81465cf61994	100	20	2023-09-05 10:00:00+00
4525dfa6-601c-4b79-a74b-c406acf73370	45ba25bb-eab9-461f-a93b-559e4e8c74e4	400	80	2023-07-15 10:00:00+00
38ec3114-66a3-4f71-b018-e63e8e286a8f	aeda1973-4148-474a-8153-c199958a59c6	250	40	2023-08-25 10:00:00+00
421179a8-d49f-49fa-b542-fd1a997b2cfb	f6fed7de-dba7-4988-b73b-b775c7577bc2	300	60	2023-09-10 10:00:00+00
5e51e5e5-1d84-4f41-956a-70db73e8e7b6	d0fdf18f-40af-46d3-9475-81465cf61994	500	100	2023-07-01 10:00:00+00
8a6752b9-e9ca-44c6-a9c0-cc562a5ac21b	45ba25bb-eab9-461f-a93b-559e4e8c74e4	1000	200	2023-08-20 10:00:00+00
f2ea548c-0b0a-4124-9f97-4f5c211534c8	45ba25bb-eab9-461f-a93b-559e4e8c74e4	400	80	2023-09-01 10:00:00+00
ef8a2608-3168-4cec-9e5c-9f03f5555699	45ba25bb-eab9-461f-a93b-559e4e8c74e4	300	60	2023-07-10 10:00:00+00
e53ec0ef-eec0-4e3f-8e75-79e2e29c9b5d	aeda1973-4148-474a-8153-c199958a59c6	250	50	2023-08-15 10:00:00+00
0acf7d7e-b925-4422-b8c3-9e9e2069dcf4	f6fed7de-dba7-4988-b73b-b775c7577bc2	300	60	2023-09-20 10:00:00+00
63de162b-3ffa-4b1e-9963-53c24e90b18c	d0fdf18f-40af-46d3-9475-81465cf61994	600	120	2023-07-05 10:00:00+00
fe476643-4e56-40b4-a9ef-a8063256654f	aeda1973-4148-474a-8153-c199958a59c6	500	100	2023-07-15 10:00:00+00
d87c4075-3991-4168-9a8a-cf41183474a2	45ba25bb-eab9-461f-a93b-559e4e8c74e4	200	40	2023-08-10 10:00:00+00
3b0913d5-e5fe-44bc-833a-bdd633267f63	45ba25bb-eab9-461f-a93b-559e4e8c74e4	800	160	2023-08-20 10:00:00+00
c813f8a5-19ea-4687-94ab-fd9e189ccdd6	aeda1973-4148-474a-8153-c199958a59c6	200	40	2023-09-10 10:00:00+00
98f6c185-4401-4252-8ab8-60dc63836f0a	f6fed7de-dba7-4988-b73b-b775c7577bc2	30	6	2023-07-15 10:00:00+00
5dba6b8a-349c-43e3-8449-ffa0e6849e2d	d0fdf18f-40af-46d3-9475-81465cf61994	10	2	2023-07-30 10:00:00+00
c52c8756-9213-45ac-87cc-b3e49fac9095	45ba25bb-eab9-461f-a93b-559e4e8c74e4	500	100	2023-07-05 10:00:00+00
c52c8756-9213-45ac-87cc-b3e49fac9095	aeda1973-4148-474a-8153-c199958a59c6	500	100	2023-07-05 10:00:00+00
6782cdfd-6476-4b95-974d-456a9383bbd0	aeda1973-4148-474a-8153-c199958a59c6	300	50	2023-07-10 10:00:00+00
c52c8756-9213-45ac-87cc-b3e49fac9095	f6fed7de-dba7-4988-b73b-b775c7577bc2	200	30	2023-08-01 10:00:00+00
13f9f76c-0407-4092-a71a-375de6452c74	45ba25bb-eab9-461f-a93b-559e4e8c74e4	100	20	2023-09-05 10:00:00+00
4525dfa6-601c-4b79-a74b-c406acf73370	aeda1973-4148-474a-8153-c199958a59c6	400	80	2023-07-15 10:00:00+00
38ec3114-66a3-4f71-b018-e63e8e286a8f	f6fed7de-dba7-4988-b73b-b775c7577bc2	250	40	2023-08-25 10:00:00+00
421179a8-d49f-49fa-b542-fd1a997b2cfb	d0fdf18f-40af-46d3-9475-81465cf61994	300	60	2023-09-10 10:00:00+00
5e51e5e5-1d84-4f41-956a-70db73e8e7b6	45ba25bb-eab9-461f-a93b-559e4e8c74e4	500	100	2023-07-01 10:00:00+00
8a6752b9-e9ca-44c6-a9c0-cc562a5ac21b	aeda1973-4148-474a-8153-c199958a59c6	1000	200	2023-08-20 10:00:00+00
f2ea548c-0b0a-4124-9f97-4f5c211534c8	f6fed7de-dba7-4988-b73b-b775c7577bc2	400	80	2023-09-01 10:00:00+00
ef8a2608-3168-4cec-9e5c-9f03f5555699	aeda1973-4148-474a-8153-c199958a59c6	300	60	2023-07-10 10:00:00+00
e53ec0ef-eec0-4e3f-8e75-79e2e29c9b5d	d0fdf18f-40af-46d3-9475-81465cf61994	250	50	2023-08-15 10:00:00+00
0acf7d7e-b925-4422-b8c3-9e9e2069dcf4	aeda1973-4148-474a-8153-c199958a59c6	300	60	2023-09-20 10:00:00+00
63de162b-3ffa-4b1e-9963-53c24e90b18c	45ba25bb-eab9-461f-a93b-559e4e8c74e4	600	120	2023-07-05 10:00:00+00
fe476643-4e56-40b4-a9ef-a8063256654f	45ba25bb-eab9-461f-a93b-559e4e8c74e4	500	100	2023-07-15 10:00:00+00
d87c4075-3991-4168-9a8a-cf41183474a2	f6fed7de-dba7-4988-b73b-b775c7577bc2	200	40	2023-08-10 10:00:00+00
3b0913d5-e5fe-44bc-833a-bdd633267f63	f6fed7de-dba7-4988-b73b-b775c7577bc2	800	160	2023-08-20 10:00:00+00
c813f8a5-19ea-4687-94ab-fd9e189ccdd6	f6fed7de-dba7-4988-b73b-b775c7577bc2	200	40	2023-09-10 10:00:00+00
98f6c185-4401-4252-8ab8-60dc63836f0a	d0fdf18f-40af-46d3-9475-81465cf61994	30	6	2023-07-15 10:00:00+00
5dba6b8a-349c-43e3-8449-ffa0e6849e2d	f6fed7de-dba7-4988-b73b-b775c7577bc2	10	2	2023-07-30 10:00:00+00
\.


--
-- Data for Name: product; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.product (product_id, product_name, product_desc, category_id, product_image, supplier_id, product_barcode, removed, created_at, updated_on, stock_type) FROM stdin;
b34ea334-9f36-4c3e-92a1-449fdae018e7	Munchee Cream Cracker 100g	Delicious cream cracker biscuits from Munchee. Ideal for snacking.	1	{product-image-placeholder.jpg,placeholder-300x400.png,placeholder-200x200.png}	1	1234-5678	f	2022-03-10 00:00:00	2025-11-18 10:25:01.940881	items
6782cdfd-6476-4b95-974d-456a9383bbd0	Maliban Potato Cracker 110g	Delcios cracker in potatoe falvour	1	{product-image-placeholder.jpg,placeholder-300x400.png,placeholder-200x200.png}	2	2341-5678	f	2022-03-10 00:00:00	2025-11-18 10:25:01.940881	items
c52c8756-9213-45ac-87cc-b3e49fac9095	Maliban Lemon Puff 200g	Delicious lemon puff biscuits from Maliban. Ideal for snacking.	1	{product-image-placeholder.jpg,placeholder-300x400.png,placeholder-200x200.png}	2	3456-1812	f	2022-03-10 00:00:00	2025-11-18 10:25:01.940881	items
13f9f76c-0407-4092-a71a-375de6452c74	Doritos Cool Ranch Tortilla Chips	Delicious tortilla chips from Doritos. Ideal for snacking.	2	{product-image-placeholder.jpg,placeholder-300x400.png,placeholder-200x200.png}	3	4567-8123	f	2022-03-10 00:00:00	2025-11-18 10:25:01.940881	items
4525dfa6-601c-4b79-a74b-c406acf73370	Pringles Original Potato Crisps 	Delicious potato crisps from Pringles. Ideal for snacking.	2	{product-image-placeholder.jpg,placeholder-300x400.png,placeholder-200x200.png}	4	5678-1235	f	2022-03-10 00:00:00	2025-11-18 10:25:01.940881	items
38ec3114-66a3-4f71-b018-e63e8e286a8f	Coca-Cola 1.5L	Refreshing cola drink from Coca-Cola. Ideal for quenching your thirst.	3	{product-image-placeholder.jpg,placeholder-300x400.png,placeholder-200x200.png}	5	6781-2346	f	2022-03-10 00:00:00	2025-11-18 10:25:01.940881	items
421179a8-d49f-49fa-b542-fd1a997b2cfb	Sprite 1.5L	Refreshing lemon-lime drink from Sprite. Ideal for quenching your thirst.	3	{product-image-placeholder.jpg,placeholder-300x400.png,placeholder-200x200.png}	6	7812-3446	f	2022-03-10 00:00:00	2025-11-18 10:25:01.940881	items
5e51e5e5-1d84-4f41-956a-70db73e8e7b6	Fanta 1.5L	Refreshing orange drink from Fanta. Ideal for quenching your thirst.	3	{product-image-placeholder.jpg,placeholder-300x400.png,placeholder-200x200.png}	1	8123-4561	f	2022-03-10 00:00:00	2025-11-18 10:25:01.940881	items
8a6752b9-e9ca-44c6-a9c0-cc562a5ac21b	Kotmale Set Yoghurt 80g	Delicious natural yogurt. Perfect for a healthy snack.	4	{product-image-placeholder.jpg,placeholder-300x400.png,placeholder-200x200.png}	2	1234-5644	f	2022-03-10 00:00:00	2025-11-18 10:25:01.940881	items
f2ea548c-0b0a-4124-9f97-4f5c211534c8	Kotmale Cheddar Cheese 250g	High-quality cheddar cheese. Great for sandwiches and recipes.	4	{product-image-placeholder.jpg,placeholder-300x400.png,placeholder-200x200.png}	3	1345-6781	f	2022-03-10 00:00:00	2025-11-18 10:25:01.940881	items
ef8a2608-3168-4cec-9e5c-9f03f5555699	Kotmale Fresh Milk 1L	High-quality fresh milk. Ideal for drinking and cooking.	4	{product-image-placeholder.jpg,placeholder-300x400.png,placeholder-200x200.png}	6	3456-2812	f	2022-03-10 00:00:00	2025-11-18 10:25:01.940881	items
e53ec0ef-eec0-4e3f-8e75-79e2e29c9b5d	Kotmale Salted Butter 200g	Premium salted butter. Perfect for cooking and baking.	4	{product-image-placeholder.jpg,placeholder-300x400.png,placeholder-200x200.png}	3	5678-9012	f	2022-03-11 00:00:00	2025-11-18 10:25:01.940881	items
0acf7d7e-b925-4422-b8c3-9e9e2069dcf4	Coconut Milk 400ml	High-quality coconut milk . Ideal for cooking.	5	{product-image-placeholder.jpg,placeholder-300x400.png,placeholder-200x200.png}	5	8812-3456	f	2022-03-10 00:00:00	2025-11-18 10:25:01.940881	items
63de162b-3ffa-4b1e-9963-53c24e90b18c	Coconut Oil 500ml	High-quality coconut oil from Carl. Ideal for cooking.	5	{product-image-placeholder.jpg,placeholder-300x400.png,placeholder-200x200.png}	6	8123-4567	f	2022-03-10 00:00:00	2025-11-18 10:25:01.940881	items
fe476643-4e56-40b4-a9ef-a8063256654f	Carl Coconut Vinegar 500ml	High-quality coconut vinegar from Carl. Ideal for cooking.	5	{product-image-placeholder.jpg,placeholder-300x400.png,placeholder-200x200.png}	4	1234-1678	f	2022-03-10 00:00:00	2025-11-18 10:25:01.940881	items
d87c4075-3991-4168-9a8a-cf41183474a2	Colgate Toothpaste 100g	Colgate toothpaste for healthy teeth and gums.	6	{product-image-placeholder.jpg,placeholder-300x400.png,placeholder-200x200.png}	1	2345-6781	f	2022-03-10 00:00:00	2025-11-18 10:25:01.940881	items
3b0913d5-e5fe-44bc-833a-bdd633267f63	Colgate one Toothbrush packet 	Colgate toothbrush for healthy teeth and gums.	6	{product-image-placeholder.jpg,placeholder-300x400.png,placeholder-200x200.png}	3	3456-7812	f	2022-03-10 00:00:00	2025-11-18 10:25:01.940881	items
c813f8a5-19ea-4687-94ab-fd9e189ccdd6	Colgate Mouthwash 500ml	Colgate mouthwash for healthy teeth and gums.	6	{product-image-placeholder.jpg,placeholder-300x400.png,placeholder-200x200.png}	4	4567-9123	f	2022-03-10 00:00:00	2025-11-18 10:25:01.940881	items
98f6c185-4401-4252-8ab8-60dc63836f0a	Parker Pen 12 set	Parker pen for writing.	7	{product-image-placeholder.jpg,placeholder-300x400.png,placeholder-200x200.png}	5	5678-1234	f	2022-03-10 00:00:00	2025-11-18 10:25:01.940881	items
5dba6b8a-349c-43e3-8449-ffa0e6849e2d	A4 Paper 400 Packet	A4 paper for writing.	7	{product-image-placeholder.jpg,placeholder-300x400.png,placeholder-200x200.png}	6	6781-2345	f	2022-03-10 00:00:00	2025-11-18 10:25:01.940881	items
dbf199c1-3968-4fc3-b4af-e7f99838521f	Pencil 24 set	Pencil for writing.	7	{product-image-placeholder.jpg,placeholder-300x400.png,placeholder-200x200.png}	5	7812-3456	f	2022-03-10 00:00:00	2025-11-18 10:25:01.940881	items
\.


--
-- Data for Name: product_variants; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.product_variants (variant_id, product_id, buying_price, retail_price, discount, label) FROM stdin;
2e33d164-6e1c-4721-9683-4b9b59ed1f2e	b34ea334-9f36-4c3e-92a1-449fdae018e7	50.00	70.00	1.25	100g old
060df6a9-db92-48e4-bbc4-9f4406245d05	b34ea334-9f36-4c3e-92a1-449fdae018e7	55.00	70.00	0.25	120g old
cf98dd29-f672-4c8b-a08e-8b982bbec325	b34ea334-9f36-4c3e-92a1-449fdae018e7	60.00	70.00	2.25	130g old
36bd9ff0-c868-41c5-b344-bd102df7a3da	6782cdfd-6476-4b95-974d-456a9383bbd0	150.00	170.00	10.25	100g old
3a19b43f-9e9c-4614-8f24-64cf1d0ea0c3	6782cdfd-6476-4b95-974d-456a9383bbd0	250.00	370.00	16.25	110g old
e1605d7e-a7f8-49b5-8e3b-ae0441c3dc5d	6782cdfd-6476-4b95-974d-456a9383bbd0	350.00	470.00	21.00	120g old
891dd2c3-5099-438d-a442-5182d56dd0a2	38ec3114-66a3-4f71-b018-e63e8e286a8f	510.00	710.00	10.25	100g old
fcd7338e-bb30-4451-854b-1289391cb793	38ec3114-66a3-4f71-b018-e63e8e286a8f	530.00	720.00	15.25	100g old
06f669dc-a4fe-4d36-a14c-85b17040b8c7	38ec3114-66a3-4f71-b018-e63e8e286a8f	540.00	730.00	18.25	100g old
\.


--
-- Data for Name: sales_history; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sales_history (order_id, customer_id, cashier_id, branch_id, created_at, total_amount, profit, rewards_points, product_count, payment_method, reference) FROM stdin;
1	1	10	45ba25bb-eab9-461f-a93b-559e4e8c74e4	2023-08-15 05:00:00+00	100.00	0.00	0.00	\N	1	110
2	2	10	45ba25bb-eab9-461f-a93b-559e4e8c74e4	2023-08-15 09:15:00+00	75.50	0.00	0.00	\N	2	12485
3	3	11	45ba25bb-eab9-461f-a93b-559e4e8c74e4	2023-08-20 10:50:00+00	200.75	0.00	0.00	\N	1	280
4	4	12	45ba25bb-eab9-461f-a93b-559e4e8c74e4	2023-08-25 05:45:00+00	50.25	0.00	0.00	\N	3	15485
5	5	13	aeda1973-4148-474a-8153-c199958a59c6	2023-08-25 04:10:00+00	25.00	0.00	0.00	\N	1	148
6	6	13	aeda1973-4148-474a-8153-c199958a59c6	2023-08-31 11:35:00+00	75.75	0.00	0.00	\N	1	180
7	7	11	45ba25bb-eab9-461f-a93b-559e4e8c74e4	2023-09-01 08:25:00+00	300.00	0.00	0.00	\N	1	450
8	8	15	aeda1973-4148-474a-8153-c199958a59c6	2023-09-01 13:40:00+00	200.50	0.00	0.00	\N	1	780
9	9	16	f6fed7de-dba7-4988-b73b-b775c7577bc2	2023-09-02 02:30:00+00	100.25	0.00	0.00	\N	2	55825
10	10	19	d0fdf18f-40af-46d3-9475-81465cf61994	2023-09-05 06:55:00+00	375.75	0.00	0.00	\N	1	740
11	11	10	45ba25bb-eab9-461f-a93b-559e4e8c74e4	2023-09-05 09:45:00+00	450.00	0.00	0.00	\N	1	860
12	12	19	d0fdf18f-40af-46d3-9475-81465cf61994	2023-09-10 05:20:00+00	250.00	0.00	0.00	\N	1	720
13	13	17	f6fed7de-dba7-4988-b73b-b775c7577bc2	2023-09-12 09:00:00+00	100.00	0.00	0.00	\N	1	840
14	14	18	f6fed7de-dba7-4988-b73b-b775c7577bc2	2023-09-15 11:25:00+00	200.50	0.00	0.00	\N	1	760
15	45	1	45ba25bb-eab9-461f-a93b-559e4e8c74e4	2023-09-27 05:58:10.942567+00	540.00	138.00	0.27	4	1	999
16	45	1	45ba25bb-eab9-461f-a93b-559e4e8c74e4	2023-09-28 06:51:36.459182+00	140.00	39.00	0.07	2	1	200
17	9	20	d0fdf18f-40af-46d3-9475-81465cf61994	2023-09-28 07:02:01.245223+00	1750.00	548.00	0.88	3	1	2000
18	8	20	d0fdf18f-40af-46d3-9475-81465cf61994	2023-09-29 07:03:03.478696+00	590.00	368.00	0.29	3	1	600
19	15	20	d0fdf18f-40af-46d3-9475-81465cf61994	2023-09-01 08:02:29.544634+00	520.00	358.00	0.26	2	1	600
20	42	20	d0fdf18f-40af-46d3-9475-81465cf61994	2023-09-02 08:06:37.730817+00	1250.00	449.00	0.63	1	1	1300
21	10	20	d0fdf18f-40af-46d3-9475-81465cf61994	2023-09-03 08:10:06.848182+00	690.00	238.00	0.34	3	1	700
22	46	10	45ba25bb-eab9-461f-a93b-559e4e8c74e4	2023-09-03 08:13:57.647557+00	850.00	248.00	0.42	3	1	1000
23	7	16	f6fed7de-dba7-4988-b73b-b775c7577bc2	2023-09-03 08:17:23.74366+00	470.00	87.00	0.23	6	1	500
24	3	14	aeda1973-4148-474a-8153-c199958a59c6	2023-09-04 08:20:40.957297+00	440.00	39.00	0.22	2	1	500
25	21	14	aeda1973-4148-474a-8153-c199958a59c6	2023-09-05 08:23:35.453728+00	1330.00	97.00	0.67	5	1	1500
26	13	13	aeda1973-4148-474a-8153-c199958a59c6	2023-09-18 08:28:22.982146+00	835.00	253.00	0.42	2	1	1000
27	11	13	aeda1973-4148-474a-8153-c199958a59c6	2023-09-18 08:30:23.457056+00	210.00	59.00	0.10	3	1	250
28	1	11	45ba25bb-eab9-461f-a93b-559e4e8c74e4	2023-09-23 08:33:11.433492+00	320.00	98.00	0.16	2	1	400
29	25	11	45ba25bb-eab9-461f-a93b-559e4e8c74e4	2023-09-08 08:36:11.94036+00	250.00	49.00	0.13	1	1	500
30	23	18	f6fed7de-dba7-4988-b73b-b775c7577bc2	2023-09-14 08:39:41.826812+00	520.00	238.00	0.26	2	1	1000
31	23	18	f6fed7de-dba7-4988-b73b-b775c7577bc2	2023-09-14 08:39:42.004142+00	520.00	238.00	0.26	2	1	1000
32	5	5	d0fdf18f-40af-46d3-9475-81465cf61994	2023-10-01 04:55:50.093878+00	320.00	58.00	0.16	2	1	500
33	2	5	d0fdf18f-40af-46d3-9475-81465cf61994	2023-10-02 04:57:44.236788+00	900.00	699.00	0.45	2	1	1000
34	18	3	aeda1973-4148-474a-8153-c199958a59c6	2023-10-03 05:00:19.265821+00	720.00	108.00	0.36	2	1	1000
35	27	3	aeda1973-4148-474a-8153-c199958a59c6	2023-10-04 05:02:18.783606+00	580.00	158.00	0.29	2	1	1000
36	41	3	aeda1973-4148-474a-8153-c199958a59c6	2023-10-06 05:06:10.12227+00	440.00	39.00	0.22	2	1	500
37	3	10	45ba25bb-eab9-461f-a93b-559e4e8c74e4	2023-10-06 05:08:02.545367+00	420.00	-61.00	0.21	2	1	500
38	12	10	45ba25bb-eab9-461f-a93b-559e4e8c74e4	2023-10-06 05:09:12.154601+00	690.00	238.00	0.34	3	1	1000
39	40	10	45ba25bb-eab9-461f-a93b-559e4e8c74e4	2023-10-07 05:10:40.997089+00	260.00	47.00	0.13	3	1	300
40	31	17	f6fed7de-dba7-4988-b73b-b775c7577bc2	2023-10-08 05:13:44.984362+00	1700.00	299.00	0.85	2	1	2000
41	27	17	f6fed7de-dba7-4988-b73b-b775c7577bc2	2023-10-10 05:21:23.431734+00	940.00	298.00	0.47	3	1	1000
42	7	17	f6fed7de-dba7-4988-b73b-b775c7577bc2	2023-10-11 05:23:22.424805+00	1800.00	599.00	0.90	6	1	2000
43	8	17	f6fed7de-dba7-4988-b73b-b775c7577bc2	2023-10-11 05:24:40.046482+00	230.00	78.00	0.12	1	1	300
44	21	19	d0fdf18f-40af-46d3-9475-81465cf61994	2023-10-12 05:27:39.877009+00	450.00	349.00	0.23	1	1	500
45	17	19	d0fdf18f-40af-46d3-9475-81465cf61994	2023-10-13 05:29:40.975847+00	3750.00	1349.00	1.88	3	1	4000
46	6	15	aeda1973-4148-474a-8153-c199958a59c6	2023-10-15 05:32:24.11861+00	920.00	-53.00	0.46	5	1	1000
47	3	7	aeda1973-4148-474a-8153-c199958a59c6	2023-10-16 05:38:24.749376+00	1480.00	376.00	0.74	7	1	1500
48	29	7	aeda1973-4148-474a-8153-c199958a59c6	2023-10-17 05:47:36.926934+00	600.00	199.00	0.30	2	1	1000
\.


--
-- Data for Name: supplier; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.supplier (supplier_id, supplier_name, supplier_email, supplier_phone, supplier_address) FROM stdin;
1	Mega Suppliers Inc.	mega@suppliers.lk	666765678	345 Cinnamon St, Colombo 02
2	Global Imports Co.	info@globalico.lk	911234567	789 Ruby St, Ratnapura 70000
3	Superior Distributors Ltd.	info@sdistributors.lk	444555666	567 Timber St, Baduraliya 80200
4	Prime Wholesale Supplies	sales@prime.lk	333444555	432 Cocoa St, Matale 80050
5	Best Buy Traders	info@bestbuyt.lk	888999000	876 Tea Gardens, Nuwara Eliya 22250
6	Quality Goods Exporters	info@qgexporters.lk	777999888	654 Timber St, Kalutara 12000
\.


--
-- Data for Name: user_credentials; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_credentials (user_id, username, password, updated_on) FROM stdin;
1	somesh	$2b$12$JotH3Y0O2ChThIspRWQvqeEBrUQkgvJLL5Ch402.mXhLPzL6fsuxG	2025-11-18 10:25:01.940881+00
2	johndoe	$2a$06$mKYklruMG7JLBg1epwvzueMlD9D8lBaoAJFI0vlsyYI4qjBGpLloS	2025-11-18 10:25:01.940881+00
3	janesmith	$2a$06$IhZHsVSv.dxU5FLVjocbGePCWGd.t.S4LsR7p8IuXX5URZ/lSuQ8G	2025-11-18 10:25:01.940881+00
4	robertjohnson	$2a$06$02cWBzQgmjpMBM790Nb34.AugaOSBoBrpJqFpQPLkhQ779jQ/UZ4W	2025-11-18 10:25:01.940881+00
5	marywilson	$2a$06$YG2o/O0JqEXdelNXSf40U.tsw3PcxZIGqJ5G471fqtqaOhaFhunqu	2025-11-18 10:25:01.940881+00
6	michaellee	$2a$06$m3jgM5mdHtQUmm8D2/LphecGOMnZb0gjHmwb/DLRsNSW99KRjqbeq	2025-11-18 10:25:01.940881+00
7	lisagarcia	$2a$06$0bZX2yY6gfPGPnmfzEGV.eAP2/2eVohjHq5mowYYKHWlyxlQiDM8S	2025-11-18 10:25:01.940881+00
8	davidmartinez	$2a$06$B9reqdT8HVwZQ/rrZne/1.Mct3Tlv897NPu4t4N6vYUUkI4SSSDvi	2025-11-18 10:25:01.940881+00
9	sarahbrown	$2a$06$E4ebYb23uUROX.DLjgWJlOAqRTDCkcUwcaIquWEk0B4KzvMycS7ha	2025-11-18 10:25:01.940881+00
10	williamsmith	$2a$06$oOh5IDUnaYJo7j4.2oFf4.sr/oPEarpZePSHvgJrhbG0o8VfonScy	2025-11-18 10:25:01.940881+00
11	karendavis	$2a$06$c0R3HlAgIPmniczGppvIceQh1W4iGQWAq/afnLZbthhZBtw5cAaYC	2025-11-18 10:25:01.940881+00
12	jamestaylor	$2a$06$Z.VrF6i4bQzm64b2n4R5IuqpE0xJwZnFvviMLcq3j.RcT2Z9gXtHe	2025-11-18 10:25:01.940881+00
13	jenniferclark	$2a$06$MKXYc4NKt60oiqPx/KwkM.fO0PQjG6pfNGlXVN4wrPt.20L5uAM2W	2025-11-18 10:25:01.940881+00
14	josephjohnson	$2a$06$770mQamJ.1cMf2bhgTjuN.sb3MZJWmhFiln0fWgyAsW8ZiXU.Xouy	2025-11-18 10:25:01.940881+00
15	nancymoore	$2a$06$Lt.yMo42AZqrOAy4KZhrGO3DU3HeVagl5d/J6JhY3cKWxnpAuqKtm	2025-11-18 10:25:01.940881+00
16	robertwhite	$2a$06$WEY0TrPzvM.kCKJZM2nsLuG8u0Ai23i3Ex/DuduSc8/RIGYMW7lHm	2025-11-18 10:25:01.940881+00
17	lindaharris	$2a$06$8cYLaK.8NzcO6xOOMPxbSOcQ06lFjfiQ328GX95nVhOlQdi3B5Tt.	2025-11-18 10:25:01.940881+00
18	johnmiller	$2a$06$s3ktYwdn4k34l1vjCZJsQ.pmw8gaORwIp8hFkgiMiq0JJTY/3/B6K	2025-11-18 10:25:01.940881+00
19	patriciagarcia	$2a$06$4kX9smzTOXGQeHSRw0gS0uqA1LbpJZSpeb2g4uISS8yFBUeQa7zCi	2025-11-18 10:25:01.940881+00
20	robertbrown	$2a$06$ktN0CmeXZ4ny3roTRQ4OeeMcOrBuV7Ld623eq5xGPw1GguG7AeKui	2025-11-18 10:25:01.940881+00
\.


--
-- Data for Name: user_role; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_role (role_id, role_name, role_desc, user_access) FROM stdin;
1	Owner	Responsible for overall management and ownership of the supermarket.	{1,2,3,4}
2	Finance Manager	Responsible for financial reporting and analysis.	{1,2,3,4}
3	Branch Manager	Manages the day-to-day operations of a specific branch.	{1,2,3,4}
4	Cashier	Handles customer transactions at the checkout counter.	{1,2,3,4}
\.


--
-- Data for Name: variable_options; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.variable_options (variable_id, variable_name, created_at, variable_value, updated_on) FROM stdin;
1	rewards_points_percentage	2025-11-18 10:25:02+00	0.05	2025-11-18 10:25:02+00
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

SELECT pg_catalog.setval('public.cart_cart_id_seq', 78, true);


--
-- Name: category_category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.category_category_id_seq', 1, false);


--
-- Name: customer_customer_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.customer_customer_id_seq', 1, false);


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

SELECT pg_catalog.setval('public.sales_history_order_id_seq', 1, false);


--
-- Name: supplier_supplier_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.supplier_supplier_id_seq', 1, false);


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

\unrestrict lryKgfdLGTq4LG80OvmXhBPV6GDEdkKvFeoHXerSh61bZCHridGhvJRKhZ3XsMV

