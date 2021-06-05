--
-- PostgreSQL database dump
--

-- Dumped from database version 12.7 (Ubuntu 12.7-0ubuntu0.20.04.1)
-- Dumped by pg_dump version 12.7 (Ubuntu 12.7-0ubuntu0.20.04.1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: addresses; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.addresses (
    id bigint NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    deleted_at timestamp with time zone,
    addr text,
    private_key text
);


ALTER TABLE public.addresses OWNER TO postgres;

--
-- Name: addresses_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.addresses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.addresses_id_seq OWNER TO postgres;

--
-- Name: addresses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.addresses_id_seq OWNED BY public.addresses.id;


--
-- Name: collects; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.collects (
    id bigint NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    deleted_at timestamp with time zone,
    tx_id text,
    "from" text,
    "to" text,
    value text,
    tx_type text,
    "timestamp" text
);


ALTER TABLE public.collects OWNER TO postgres;

--
-- Name: collects_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.collects_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.collects_id_seq OWNER TO postgres;

--
-- Name: collects_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.collects_id_seq OWNED BY public.collects.id;


--
-- Name: goadmin_menu_myid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.goadmin_menu_myid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 99999999
    CACHE 1;


ALTER TABLE public.goadmin_menu_myid_seq OWNER TO postgres;

--
-- Name: goadmin_menu; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.goadmin_menu (
    id integer DEFAULT nextval('public.goadmin_menu_myid_seq'::regclass) NOT NULL,
    parent_id integer DEFAULT 0 NOT NULL,
    type integer DEFAULT 0,
    "order" integer DEFAULT 0 NOT NULL,
    title character varying(50) NOT NULL,
    header character varying(100),
    plugin_name character varying(100) NOT NULL,
    icon character varying(50) NOT NULL,
    uri character varying(3000) NOT NULL,
    uuid character varying(100),
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.goadmin_menu OWNER TO postgres;

--
-- Name: goadmin_operation_log_myid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.goadmin_operation_log_myid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 99999999
    CACHE 1;


ALTER TABLE public.goadmin_operation_log_myid_seq OWNER TO postgres;

--
-- Name: goadmin_operation_log; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.goadmin_operation_log (
    id integer DEFAULT nextval('public.goadmin_operation_log_myid_seq'::regclass) NOT NULL,
    user_id integer NOT NULL,
    path character varying(255) NOT NULL,
    method character varying(10) NOT NULL,
    ip character varying(15) NOT NULL,
    input text NOT NULL,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.goadmin_operation_log OWNER TO postgres;

--
-- Name: goadmin_permissions_myid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.goadmin_permissions_myid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 99999999
    CACHE 1;


ALTER TABLE public.goadmin_permissions_myid_seq OWNER TO postgres;

--
-- Name: goadmin_permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.goadmin_permissions (
    id integer DEFAULT nextval('public.goadmin_permissions_myid_seq'::regclass) NOT NULL,
    name character varying(50) NOT NULL,
    slug character varying(50) NOT NULL,
    http_method character varying(255),
    http_path text NOT NULL,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.goadmin_permissions OWNER TO postgres;

--
-- Name: goadmin_role_menu; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.goadmin_role_menu (
    role_id integer NOT NULL,
    menu_id integer NOT NULL,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.goadmin_role_menu OWNER TO postgres;

--
-- Name: goadmin_role_permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.goadmin_role_permissions (
    role_id integer NOT NULL,
    permission_id integer NOT NULL,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.goadmin_role_permissions OWNER TO postgres;

--
-- Name: goadmin_role_users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.goadmin_role_users (
    role_id integer NOT NULL,
    user_id integer NOT NULL,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.goadmin_role_users OWNER TO postgres;

--
-- Name: goadmin_roles_myid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.goadmin_roles_myid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 99999999
    CACHE 1;


ALTER TABLE public.goadmin_roles_myid_seq OWNER TO postgres;

--
-- Name: goadmin_roles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.goadmin_roles (
    id integer DEFAULT nextval('public.goadmin_roles_myid_seq'::regclass) NOT NULL,
    name character varying NOT NULL,
    slug character varying NOT NULL,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.goadmin_roles OWNER TO postgres;

--
-- Name: goadmin_session_myid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.goadmin_session_myid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 99999999
    CACHE 1;


ALTER TABLE public.goadmin_session_myid_seq OWNER TO postgres;

--
-- Name: goadmin_session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.goadmin_session (
    id integer DEFAULT nextval('public.goadmin_session_myid_seq'::regclass) NOT NULL,
    sid character varying(50) NOT NULL,
    "values" character varying(3000) NOT NULL,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.goadmin_session OWNER TO postgres;

--
-- Name: goadmin_site_myid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.goadmin_site_myid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 99999999
    CACHE 1;


ALTER TABLE public.goadmin_site_myid_seq OWNER TO postgres;

--
-- Name: goadmin_site; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.goadmin_site (
    id integer DEFAULT nextval('public.goadmin_site_myid_seq'::regclass) NOT NULL,
    key character varying(100) NOT NULL,
    value text NOT NULL,
    type integer DEFAULT 0,
    description character varying(3000),
    state integer DEFAULT 0,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.goadmin_site OWNER TO postgres;

--
-- Name: goadmin_user_permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.goadmin_user_permissions (
    user_id integer NOT NULL,
    permission_id integer NOT NULL,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.goadmin_user_permissions OWNER TO postgres;

--
-- Name: goadmin_users_myid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.goadmin_users_myid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 99999999
    CACHE 1;


ALTER TABLE public.goadmin_users_myid_seq OWNER TO postgres;

--
-- Name: goadmin_users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.goadmin_users (
    id integer DEFAULT nextval('public.goadmin_users_myid_seq'::regclass) NOT NULL,
    username character varying(100) NOT NULL,
    password character varying(100) NOT NULL,
    name character varying(100) NOT NULL,
    avatar character varying(255),
    remember_token character varying(100),
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.goadmin_users OWNER TO postgres;

--
-- Name: sync_trons; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sync_trons (
    id text NOT NULL,
    height bigint
);


ALTER TABLE public.sync_trons OWNER TO postgres;

--
-- Name: transfers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.transfers (
    id bigint NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    deleted_at timestamp with time zone,
    tx_id text,
    block_height bigint,
    "timestamp" bigint,
    "from" text,
    "to" text,
    tx_type text,
    value text,
    status bigint,
    call_back boolean,
    call_back_num bigint,
    call_back_url text,
    call_back_time bigint
);


ALTER TABLE public.transfers OWNER TO postgres;

--
-- Name: transfers_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.transfers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.transfers_id_seq OWNER TO postgres;

--
-- Name: transfers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.transfers_id_seq OWNED BY public.transfers.id;


--
-- Name: addresses id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.addresses ALTER COLUMN id SET DEFAULT nextval('public.addresses_id_seq'::regclass);


--
-- Name: collects id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.collects ALTER COLUMN id SET DEFAULT nextval('public.collects_id_seq'::regclass);


--
-- Name: transfers id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transfers ALTER COLUMN id SET DEFAULT nextval('public.transfers_id_seq'::regclass);


--
-- Data for Name: addresses; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.addresses (id, created_at, updated_at, deleted_at, addr, private_key) FROM stdin;
63	2021-06-05 17:03:57.151242+08	2021-06-05 17:03:57.151242+08	\N	TWELinpypZnDW5VbwWQjDcAiFNwd4W23WC	ORd3LH1]Qn04/j0<}LhqoyU^8Whuso!Y 04kJ{fVCB
64	2021-06-05 17:05:51.128396+08	2021-06-05 17:05:51.128396+08	\N	TGXaA22dQXCADyzqzwXvUBug7mp3siYxUT	ZmHL_NGg~LAXbeAѰ6nhk6-H6+zZt
\.


--
-- Data for Name: collects; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.collects (id, created_at, updated_at, deleted_at, tx_id, "from", "to", value, tx_type, "timestamp") FROM stdin;
29	2021-06-05 15:16:36.515382+08	2021-06-05 15:16:36.515382+08	\N	a7bc2f0a86adb3cdd21324ed0b55437d4f4718e75b5b791110b8e2403ae5398e	TMbQqmKZUTqPrJyrHJi6k6DgQYR8gsfwcy	TW8hRi6Ur79cXKNeLX2ze5U1srAW75ZwXE	5	USDT	\N
30	2021-06-05 15:16:36.515382+08	2021-06-05 15:16:36.515382+08	\N	a7bc2f0a86adb3cdd21324ed0b55437d4f4718e75b5b791110b8e2403ae5398e	TMbQqmKZUTqPrJyrHJi6k6DgQYR8gsfwcy	TW8hRi6Ur79cXKNeLX2ze5U1srAW75ZwXE	5	TRX	\N
\.


--
-- Data for Name: goadmin_menu; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.goadmin_menu (id, parent_id, type, "order", title, header, plugin_name, icon, uri, uuid, created_at, updated_at) FROM stdin;
1	0	1	2	Admin	\N		fa-tasks		\N	2019-09-10 00:00:00	2019-09-10 00:00:00
2	1	1	2	Users	\N		fa-users	/info/manager	\N	2019-09-10 00:00:00	2019-09-10 00:00:00
3	1	1	3	Roles	\N		fa-user	/info/roles	\N	2019-09-10 00:00:00	2019-09-10 00:00:00
4	1	1	4	Permission	\N		fa-ban	/info/permission	\N	2019-09-10 00:00:00	2019-09-10 00:00:00
5	1	1	5	Menu	\N		fa-bars	/menu	\N	2019-09-10 00:00:00	2019-09-10 00:00:00
6	1	1	6	Operation log	\N		fa-history	/info/op	\N	2019-09-10 00:00:00	2019-09-10 00:00:00
9	8	0	2	充值记录			fa-500px	/info/transfer	\N	2021-06-05 17:11:32.180704	2021-06-05 17:11:32.180704
8	0	0	2	TRC-20			fa-bars		\N	2021-06-05 17:10:53.876011	2021-06-05 17:11:41
10	8	0	2	归集记录			fa-database	/info/collect	\N	2021-06-05 18:16:21.643598	2021-06-05 18:23:35
11	8	0	2	地址列表			fa-th	/info/address	\N	2021-06-05 18:36:55.263476	2021-06-05 18:36:55.263476
\.


--
-- Data for Name: goadmin_operation_log; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.goadmin_operation_log (id, user_id, path, method, ip, input, created_at, updated_at) FROM stdin;
2	1	/admin	GET	::1		2021-06-05 16:03:38.087211	2021-06-05 16:03:38.087211
3	1	/admin/info/generate/new	GET	::1		2021-06-05 16:03:44.880498	2021-06-05 16:03:44.880498
4	1	/admin	GET	::1		2021-06-05 16:04:11.084956	2021-06-05 16:04:11.084956
5	1	/admin/logout	GET	::1		2021-06-05 16:04:15.571533	2021-06-05 16:04:15.571533
6	1	/admin	GET	::1		2021-06-05 16:06:14.439847	2021-06-05 16:06:14.439847
7	1	/admin/logout	GET	::1		2021-06-05 16:06:59.407871	2021-06-05 16:06:59.407871
8	1	/admin	GET	::1		2021-06-05 16:08:41.374274	2021-06-05 16:08:41.374274
9	1	/admin/info/generate/new	GET	::1		2021-06-05 16:08:44.639968	2021-06-05 16:08:44.639968
10	1	/admin/operation/_tool_choose_conn	POST	::1		2021-06-05 16:43:47.100254	2021-06-05 16:43:47.100254
11	1	/admin/operation/_tool_choose_table	POST	::1		2021-06-05 16:43:51.253143	2021-06-05 16:43:51.253143
12	1	/admin/new/generate	POST	::1	{"__checkbox__hide_back_button":["on"],"__checkbox__hide_continue_edit_check_box":["on"],"__checkbox__hide_continue_new_check_box":["on"],"__checkbox__hide_detail_button":["on"],"__checkbox__hide_edit_button":["on"],"__checkbox__hide_export_button":["on"],"__checkbox__hide_filter_area":["on"],"__checkbox__hide_filter_button":["on"],"__checkbox__hide_pagination":["on"],"__checkbox__hide_query_info":["on"],"__checkbox__hide_reset_button":["on"],"__checkbox__hide_row_selector":["on"],"__checkbox__permission":["on"],"__go_admin_previous_":["http://localhost:9033/admin"],"__go_admin_t_":["027eb2cb-b336-4643-a294-26642d32eb1c"],"conn":["default"],"detail_description":[""],"detail_display":["0"],"detail_title":[""],"extra_code":[""],"field_canadd":["y","y","y","y","y","y","y","y","y","y"],"field_canedit":["y","y","y","y","y","y","y","y","y","y"],"field_db_type":["Text","Int8","Int8","Text","Text","Text","Text","Int8","Bool","Int8"],"field_db_type_form":["Text","Int8","Int8","Text","Text","Text","Text","Int8","Bool","Int8"],"field_default":["","","","","","","","","",""],"field_display":["","","","","","","","","",""],"field_filterable":["n","n","n","n","n","n","n","n","n","n"],"field_form_type_form":["RichText","Text","Text","RichText","RichText","RichText","RichText","Text","Text","Text"],"field_head":["hash","height","Timestamp","From","To","type","Value","状态","回调状态","回调次数"],"field_head_form":["Tx_id","Block_height","Timestamp","From","To","Tx_type","Value","Status","Call_back","Call_back_num"],"field_hide":["n","n","n","n","n","n","n","n","n","n"],"field_name":["tx_id","block_height","timestamp","from","to","tx_type","value","status","call_back","call_back_num"],"field_name_form":["tx_id","block_height","timestamp","from","to","tx_type","value","status","call_back","call_back_num"],"field_sortable":["n","n","n","n","n","n","n","n","n","n"],"filter_form_layout":["LayoutDefault"],"form_description":[""],"form_title":[""],"hide_back_button":["n"],"hide_continue_edit_check_box":["n"],"hide_continue_new_check_box":["n"],"hide_delete_button":["y"],"hide_detail_button":["n"],"hide_edit_button":["n"],"hide_export_button":["n"],"hide_filter_area":["n"],"hide_filter_button":["n"],"hide_new_button":["y"],"hide_pagination":["n"],"hide_query_info":["n"],"hide_reset_button":["n"],"hide_row_selector":["n"],"info_field_editable":["n","n","n","n","n","n","n","n","n","n"],"package":["pay"],"path":["/home/phantom/public/work/cuckoo-admin/tables/pay"],"permission":["y"],"pk":["id"],"table":["transfers"],"table_description":["充值记录列表"],"table_title":["充值记录"]}	2021-06-05 16:47:54.586743	2021-06-05 16:47:54.586743
13	1	/admin	GET	::1		2021-06-05 16:50:26.101937	2021-06-05 16:50:26.101937
14	1	/admin	GET	::1		2021-06-05 16:51:11.471192	2021-06-05 16:51:11.471192
15	1	/admin/info/manager	GET	::1		2021-06-05 16:51:13.558496	2021-06-05 16:51:13.558496
16	1	/admin/info/transfer	GET	::1		2021-06-05 16:51:15.782021	2021-06-05 16:51:15.782021
17	1	/admin/new/generate	POST	::1	{"__checkbox__hide_back_button":["on"],"__checkbox__hide_continue_edit_check_box":["on"],"__checkbox__hide_continue_new_check_box":["on"],"__checkbox__hide_edit_button":["on"],"__checkbox__hide_export_button":["on"],"__checkbox__hide_filter_area":["on"],"__checkbox__hide_filter_button":["on"],"__checkbox__hide_pagination":["on"],"__checkbox__hide_query_info":["on"],"__checkbox__hide_reset_button":["on"],"__checkbox__hide_row_selector":["on"],"__checkbox__permission":["on"],"__go_admin_previous_":["http://localhost:9033/admin"],"__go_admin_t_":["742e5f98-ea94-4b6f-97b8-cbef57c770dd"],"conn":["default"],"detail_description":[""],"detail_display":["0"],"detail_title":[""],"extra_code":[""],"field_canadd":["y","y","y","y","y","y","y","y","y","y"],"field_canedit":["y","y","y","y","y","y","y","y","y","y"],"field_db_type":["Text","Int8","Int8","Text","Text","Text","Text","Int8","Bool","Int8"],"field_db_type_form":["Text","Int8","Int8","Text","Text","Text","Text","Int8","Bool","Int8"],"field_default":["","","","","","","","","",""],"field_display":["","","","","","","","","",""],"field_filterable":["n","n","n","n","n","n","n","n","n","n"],"field_form_type_form":["RichText","Text","Text","RichText","RichText","RichText","RichText","Text","Text","Text"],"field_head":["hash","height","Timestamp","From","To","type","Value","状态","回调状态","回调次数"],"field_head_form":["Tx_id","Block_height","Timestamp","From","To","Tx_type","Value","Status","Call_back","Call_back_num"],"field_hide":["n","n","n","n","n","n","n","n","n","n"],"field_name":["tx_id","block_height","timestamp","from","to","tx_type","value","status","call_back","call_back_num"],"field_name_form":["tx_id","block_height","timestamp","from","to","tx_type","value","status","call_back","call_back_num"],"field_sortable":["n","n","n","n","n","n","n","n","n","n"],"filter_form_layout":["LayoutDefault"],"form_description":[""],"form_title":["充值记录"],"hide_back_button":["n"],"hide_continue_edit_check_box":["n"],"hide_continue_new_check_box":["n"],"hide_delete_button":["y"],"hide_detail_button":["y"],"hide_edit_button":["n"],"hide_export_button":["n"],"hide_filter_area":["n"],"hide_filter_button":["n"],"hide_new_button":["y"],"hide_pagination":["n"],"hide_query_info":["n"],"hide_reset_button":["n"],"hide_row_selector":["n"],"info_field_editable":["n","n","n","n","n","n","n","n","n","n"],"package":["pay"],"path":["/home/phantom/public/work/cuckoo-admin/tables/pay"],"permission":["y"],"pk":["tx_id"],"table":["transfers"],"table_description":["充值记录列表"],"table_title":["充值记录"]}	2021-06-05 16:53:13.88052	2021-06-05 16:53:13.88052
18	1	/admin/info/transfer	GET	::1		2021-06-05 16:53:36.227391	2021-06-05 16:53:36.227391
19	1	/admin/info/transfer	GET	::1		2021-06-05 16:53:41.720978	2021-06-05 16:53:41.720978
20	1	/admin/info/transfer	GET	::1		2021-06-05 16:53:47.00721	2021-06-05 16:53:47.00721
21	1	/admin/info/generate/new	GET	::1		2021-06-05 16:54:37.315545	2021-06-05 16:54:37.315545
22	1	/admin/operation/_tool_choose_conn	POST	::1		2021-06-05 16:54:39.525859	2021-06-05 16:54:39.525859
23	1	/admin/new/generate	POST	::1	{"__checkbox__hide_back_button":["on"],"__checkbox__hide_continue_edit_check_box":["on"],"__checkbox__hide_continue_new_check_box":["on"],"__checkbox__hide_edit_button":["on"],"__checkbox__hide_export_button":["on"],"__checkbox__hide_filter_area":["on"],"__checkbox__hide_filter_button":["on"],"__checkbox__hide_pagination":["on"],"__checkbox__hide_query_info":["on"],"__checkbox__hide_reset_button":["on"],"__checkbox__hide_row_selector":["on"],"__checkbox__permission":["on"],"__go_admin_previous_":["/admin/info/generate?__page=1\\u0026__pageSize=10\\u0026__sort=id\\u0026__sort_type=desc"],"__go_admin_t_":["afeac2d6-eea4-4d49-b54c-e3907fe2e7ef"],"conn":["default"],"detail_description":[""],"detail_display":["0"],"detail_title":[""],"extra_code":[""],"field_canadd":["y","y","y","y","y","y","y","y","y","y"],"field_canedit":["y","y","y","y","y","y","y","y","y","y"],"field_db_type":["Text","Int8","Int8","Text","Text","Text","Text","Int8","Bool","Int8"],"field_db_type_form":["Text","Int8","Int8","Text","Text","Text","Text","Int8","Bool","Int8"],"field_default":["","","","","","","","","",""],"field_display":["","","","","","","","","",""],"field_filterable":["n","n","n","n","n","n","n","n","n","n"],"field_form_type_form":["RichText","Text","Text","RichText","RichText","RichText","RichText","Text","Text","Text"],"field_head":["hash","height","Timestamp","From","To","type","Value","状态","回调状态","回调次数"],"field_head_form":["Tx_id","Block_height","Timestamp","From","To","Tx_type","Value","Status","Call_back","Call_back_num"],"field_hide":["n","n","n","n","n","n","n","n","n","n"],"field_name":["tx_id","block_height","timestamp","from","to","tx_type","value","status","call_back","call_back_num"],"field_name_form":["tx_id","block_height","timestamp","from","to","tx_type","value","status","call_back","call_back_num"],"field_sortable":["n","n","n","n","n","n","n","n","n","n"],"filter_form_layout":["LayoutDefault"],"form_description":[""],"form_title":["充值记录"],"hide_back_button":["n"],"hide_continue_edit_check_box":["n"],"hide_continue_new_check_box":["n"],"hide_delete_button":["y"],"hide_detail_button":["y"],"hide_edit_button":["n"],"hide_export_button":["n"],"hide_filter_area":["n"],"hide_filter_button":["n"],"hide_new_button":["y"],"hide_pagination":["n"],"hide_query_info":["n"],"hide_reset_button":["n"],"hide_row_selector":["n"],"info_field_editable":["n","n","n","n","n","n","n","n","n","n"],"package":["pay"],"path":["/home/phantom/public/work/cuckoo-admin/tables/pay"],"permission":["y"],"pk":["tx_id"],"table":["transfers"],"table_description":["充值记录列表"],"table_title":["充值记录"]}	2021-06-05 16:55:13.69981	2021-06-05 16:55:13.69981
24	1	/admin/info/transfer	GET	::1		2021-06-05 16:58:19.906175	2021-06-05 16:58:19.906175
25	1	/admin/info/transfer	GET	::1		2021-06-05 17:03:56.511667	2021-06-05 17:03:56.511667
26	1	/admin/info/transfer	GET	::1		2021-06-05 17:04:36.82681	2021-06-05 17:04:36.82681
27	1	/admin/menu	GET	::1		2021-06-05 17:05:32.467051	2021-06-05 17:05:32.467051
28	1	/admin/menu	GET	::1		2021-06-05 17:05:34.415423	2021-06-05 17:05:34.415423
29	1	/admin/menu/new	POST	::1	{"__go_admin_previous_":["/admin/menu"],"__go_admin_t_":["3e3119b0-6057-4e5c-b383-55a2fecd0f4c"],"header":[""],"icon":["fa-bars"],"parent_id":["0"],"plugin_name":[""],"roles[]":["1"],"title":["TRC-20"],"uri":["/info/transfer"]}	2021-06-05 17:10:53.893825	2021-06-05 17:10:53.893825
30	1	/admin/menu	GET	::1		2021-06-05 17:10:56.781947	2021-06-05 17:10:56.781947
31	1	/admin/info/transfer	GET	::1		2021-06-05 17:10:58.178293	2021-06-05 17:10:58.178293
32	1	/admin/info/transfer	GET	::1		2021-06-05 17:10:59.318081	2021-06-05 17:10:59.318081
33	1	/admin/menu	GET	::1		2021-06-05 17:11:07.641213	2021-06-05 17:11:07.641213
34	1	/admin/menu/new	POST	::1	{"__go_admin_previous_":["/admin/menu"],"__go_admin_t_":["17c00791-81b6-417f-8a43-fb8379b2e3dd"],"header":[""],"icon":["fa-500px"],"parent_id":["8"],"plugin_name":[""],"roles[]":["1"],"title":["充值记录"],"uri":["/info/transfer"]}	2021-06-05 17:11:32.200092	2021-06-05 17:11:32.200092
35	1	/admin/menu/edit/show	GET	::1		2021-06-05 17:11:34.818111	2021-06-05 17:11:34.818111
36	1	/admin/menu/edit	POST	::1	{"__go_admin_previous_":["/admin/menu"],"__go_admin_t_":["427cf551-2264-419e-b6ee-ac0a8049fe81"],"created_at":["2021-06-05T17:10:53.876011Z"],"header":[""],"icon":["fa-bars"],"id":["8"],"parent_id":["0"],"plugin_name":[""],"roles[]":["1"],"title":["TRC-20"],"updated_at":["2021-06-05T17:10:53.876011Z"],"uri":[""]}	2021-06-05 17:11:41.501405	2021-06-05 17:11:41.501405
37	1	/admin/menu	GET	::1		2021-06-05 17:11:43.439568	2021-06-05 17:11:43.439568
38	1	/admin/info/transfer	GET	::1		2021-06-05 17:11:45.779605	2021-06-05 17:11:45.779605
39	1	/admin/info/transfer	GET	::1		2021-06-05 17:11:47.646697	2021-06-05 17:11:47.646697
40	1	/admin/info/transfer	GET	::1		2021-06-05 17:13:55.841092	2021-06-05 17:13:55.841092
41	1	/admin/info/transfer	GET	::1		2021-06-05 17:13:57.263371	2021-06-05 17:13:57.263371
42	1	/admin/info/transfer/edit	GET	::1		2021-06-05 17:14:03.108359	2021-06-05 17:14:03.108359
43	1	/admin/info/transfer	GET	::1		2021-06-05 17:14:15.650615	2021-06-05 17:14:15.650615
44	1	/admin/info/transfer	GET	::1		2021-06-05 17:14:37.055987	2021-06-05 17:14:37.055987
45	1	/admin/info/transfer	GET	::1		2021-06-05 17:20:08.141378	2021-06-05 17:20:08.141378
46	1	/admin/info/transfer	GET	::1		2021-06-05 17:21:08.356835	2021-06-05 17:21:08.356835
47	1	/admin/info/transfer	GET	::1		2021-06-05 17:21:09.624314	2021-06-05 17:21:09.624314
48	1	/admin/info/transfer	GET	::1		2021-06-05 17:21:11.214716	2021-06-05 17:21:11.214716
49	1	/admin/info/transfer	GET	::1		2021-06-05 17:21:29.323809	2021-06-05 17:21:29.323809
50	1	/admin/info/transfer	GET	::1		2021-06-05 17:21:30.373382	2021-06-05 17:21:30.373382
51	1	/admin/info/transfer	GET	::1		2021-06-05 17:21:44.987082	2021-06-05 17:21:44.987082
52	1	/admin/info/transfer	GET	::1		2021-06-05 17:21:51.601448	2021-06-05 17:21:51.601448
53	1	/admin/info/transfer	GET	::1		2021-06-05 17:21:53.090205	2021-06-05 17:21:53.090205
54	1	/admin/info/transfer	GET	::1		2021-06-05 17:22:00.98658	2021-06-05 17:22:00.98658
55	1	/admin/info/transfer	GET	::1		2021-06-05 17:22:29.686698	2021-06-05 17:22:29.686698
56	1	/admin/info/transfer	GET	::1		2021-06-05 17:22:43.219785	2021-06-05 17:22:43.219785
385	1	/admin	GET	::1		2021-06-05 20:54:27.791976	2021-06-05 20:54:27.791976
57	1	/admin/info/transfer	GET	::1		2021-06-05 17:27:00.506847	2021-06-05 17:27:00.506847
58	1	/admin/info/transfer	GET	::1		2021-06-05 17:27:40.600473	2021-06-05 17:27:40.600473
59	1	/admin/info/transfer	GET	::1		2021-06-05 17:28:24.393795	2021-06-05 17:28:24.393795
60	1	/admin/info/transfer	GET	::1		2021-06-05 17:28:25.637756	2021-06-05 17:28:25.637756
61	1	/admin/info/transfer	GET	::1		2021-06-05 17:30:06.272413	2021-06-05 17:30:06.272413
62	1	/admin/info/transfer	GET	::1		2021-06-05 17:32:24.693586	2021-06-05 17:32:24.693586
63	1	/admin/info/transfer	GET	::1		2021-06-05 17:36:16.684983	2021-06-05 17:36:16.684983
64	1	/admin/info/transfer	GET	::1		2021-06-05 17:41:26.066701	2021-06-05 17:41:26.066701
65	1	/admin/info/transfer	GET	::1		2021-06-05 17:41:29.554739	2021-06-05 17:41:29.554739
66	1	/admin/info/transfer/edit	GET	::1		2021-06-05 17:41:31.695701	2021-06-05 17:41:31.695701
67	1	/admin/info/transfer	GET	::1		2021-06-05 17:42:06.429318	2021-06-05 17:42:06.429318
68	1	/admin/info/transfer	GET	::1		2021-06-05 17:42:07.321806	2021-06-05 17:42:07.321806
69	1	/admin/info/transfer/edit	GET	::1		2021-06-05 17:42:09.039064	2021-06-05 17:42:09.039064
70	1	/admin/info/transfer/edit	GET	::1		2021-06-05 17:42:09.06946	2021-06-05 17:42:09.06946
71	1	/admin/info/transfer	GET	::1		2021-06-05 17:43:16.47818	2021-06-05 17:43:16.47818
72	1	/admin/info/transfer/detail	GET	::1		2021-06-05 17:43:18.653956	2021-06-05 17:43:18.653956
73	1	/admin/info/transfer	GET	::1		2021-06-05 17:44:37.871806	2021-06-05 17:44:37.871806
74	1	/admin/info/transfer	GET	::1		2021-06-05 17:44:39.056246	2021-06-05 17:44:39.056246
75	1	/admin/info/transfer	GET	::1		2021-06-05 17:44:39.990852	2021-06-05 17:44:39.990852
76	1	/admin/info/transfer	GET	::1		2021-06-05 17:48:23.942753	2021-06-05 17:48:23.942753
77	1	/admin/info/transfer/detail	GET	::1		2021-06-05 17:48:25.826144	2021-06-05 17:48:25.826144
78	1	/admin/info/transfer/detail	GET	::1		2021-06-05 17:48:51.717206	2021-06-05 17:48:51.717206
79	1	/admin/info/transfer	GET	::1		2021-06-05 17:48:52.921723	2021-06-05 17:48:52.921723
80	1	/admin/info/transfer	GET	::1		2021-06-05 17:48:54.264188	2021-06-05 17:48:54.264188
81	1	/admin/info/transfer/detail	GET	::1		2021-06-05 17:48:55.993761	2021-06-05 17:48:55.993761
82	1	/admin/info/transfer	GET	::1		2021-06-05 17:51:34.334858	2021-06-05 17:51:34.334858
83	1	/admin/info/transfer	GET	::1		2021-06-05 17:51:39.653691	2021-06-05 17:51:39.653691
84	1	/admin/info/transfer	GET	::1		2021-06-05 17:51:50.122638	2021-06-05 17:51:50.122638
85	1	/admin/info/transfer	GET	::1		2021-06-05 17:51:53.557357	2021-06-05 17:51:53.557357
86	1	/admin/info/transfer	GET	::1		2021-06-05 17:52:43.524761	2021-06-05 17:52:43.524761
87	1	/admin/info/transfer	GET	::1		2021-06-05 17:52:45.365622	2021-06-05 17:52:45.365622
88	1	/admin/info/transfer	GET	::1		2021-06-05 17:52:55.504692	2021-06-05 17:52:55.504692
89	1	/admin/info/transfer	GET	::1		2021-06-05 17:53:29.159682	2021-06-05 17:53:29.159682
90	1	/admin/info/transfer	GET	::1		2021-06-05 17:53:38.677929	2021-06-05 17:53:38.677929
91	1	/admin/info/transfer	GET	::1		2021-06-05 17:53:42.84552	2021-06-05 17:53:42.84552
92	1	/admin/info/transfer	GET	::1		2021-06-05 17:53:45.214659	2021-06-05 17:53:45.214659
93	1	/admin/info/transfer	GET	::1		2021-06-05 17:53:48.623926	2021-06-05 17:53:48.623926
94	1	/admin/info/transfer	GET	::1		2021-06-05 17:53:53.607977	2021-06-05 17:53:53.607977
95	1	/admin/info/transfer	GET	::1		2021-06-05 17:55:21.194306	2021-06-05 17:55:21.194306
96	1	/admin/info/transfer	GET	::1		2021-06-05 17:55:24.577554	2021-06-05 17:55:24.577554
97	1	/admin/info/transfer	GET	::1		2021-06-05 17:56:07.800304	2021-06-05 17:56:07.800304
98	1	/admin/info/transfer	GET	::1		2021-06-05 17:56:34.744001	2021-06-05 17:56:34.744001
99	1	/admin/info/transfer	GET	::1		2021-06-05 17:56:39.232951	2021-06-05 17:56:39.232951
100	1	/admin/info/transfer	GET	::1		2021-06-05 17:57:22.559468	2021-06-05 17:57:22.559468
101	1	/admin/info/transfer	GET	::1		2021-06-05 17:57:24.322738	2021-06-05 17:57:24.322738
102	1	/admin/info/transfer	GET	::1		2021-06-05 17:57:36.386451	2021-06-05 17:57:36.386451
103	1	/admin/info/transfer	GET	::1		2021-06-05 17:57:53.049755	2021-06-05 17:57:53.049755
104	1	/admin	GET	::1		2021-06-05 17:57:56.362001	2021-06-05 17:57:56.362001
105	1	/admin/info/transfer	GET	::1		2021-06-05 17:57:59.564967	2021-06-05 17:57:59.564967
106	1	/admin/info/transfer	GET	::1		2021-06-05 17:59:20.825454	2021-06-05 17:59:20.825454
107	1	/admin/info/transfer/detail	GET	::1		2021-06-05 17:59:22.716495	2021-06-05 17:59:22.716495
108	1	/admin/info/transfer/detail	GET	::1		2021-06-05 17:59:37.483355	2021-06-05 17:59:37.483355
109	1	/admin/info/transfer/detail	GET	::1		2021-06-05 18:00:57.124378	2021-06-05 18:00:57.124378
110	1	/admin/info/transfer	GET	::1		2021-06-05 18:01:56.569413	2021-06-05 18:01:56.569413
111	1	/admin/info/transfer	GET	::1		2021-06-05 18:01:57.623499	2021-06-05 18:01:57.623499
112	1	/admin/info/transfer/detail	GET	::1		2021-06-05 18:01:58.938907	2021-06-05 18:01:58.938907
113	1	/admin/info/transfer/detail	GET	::1		2021-06-05 18:02:41.923063	2021-06-05 18:02:41.923063
114	1	/admin/info/transfer	GET	::1		2021-06-05 18:02:46.201283	2021-06-05 18:02:46.201283
115	1	/admin/info/generate/new	GET	::1		2021-06-05 18:02:52.923348	2021-06-05 18:02:52.923348
116	1	/admin/operation/_tool_choose_conn	POST	::1		2021-06-05 18:02:56.352195	2021-06-05 18:02:56.352195
117	1	/admin/operation/_tool_choose_table	POST	::1		2021-06-05 18:03:00.89428	2021-06-05 18:03:00.89428
118	1	/admin/new/generate	POST	::1	{"__checkbox__hide_back_button":["on"],"__checkbox__hide_continue_edit_check_box":["on"],"__checkbox__hide_continue_new_check_box":["on"],"__checkbox__hide_detail_button":["on"],"__checkbox__hide_export_button":["on"],"__checkbox__hide_filter_area":["on"],"__checkbox__hide_filter_button":["on"],"__checkbox__hide_pagination":["on"],"__checkbox__hide_query_info":["on"],"__checkbox__hide_reset_button":["on"],"__checkbox__hide_row_selector":["on"],"__go_admin_previous_":["/admin/info/generate?__page=1\\u0026__pageSize=10\\u0026__sort=id\\u0026__sort_type=desc"],"__go_admin_t_":["2170edd3-08bc-402b-9240-2aeb85f6d211"],"conn":["default"],"detail_description":[""],"detail_display":["0"],"detail_title":[""],"extra_code":[""],"field_canadd":["y","y","y","y","n","y","y","y","y","y"],"field_canedit":["y","y","y","y","y","y","y","y","y","y"],"field_db_type":["Int8","Text","Timestamptz","Text","Text","Text","Text"],"field_db_type_form":["Int8","Timestamptz","Timestamptz","Timestamptz","Text","Text","Text","Text","Text","Text"],"field_default":["","","","","","","","","",""],"field_display":["","1","1","","","","","","",""],"field_filterable":["n","n","n","n","n","n","n"],"field_form_type_form":["Default","Datetime","Datetime","Datetime","RichText","RichText","RichText","RichText","RichText","RichText"],"field_head":["Id","hash","time","转出地址","归集地址","Value","类型"],"field_head_form":["Id","Created_at","Updated_at","Deleted_at","Tx_id","From","To","Value","Tx_type","Timestamp"],"field_hide":["n","n","n","n","n","n","n"],"field_name":["id","tx_id","created_at","from","to","value","tx_type"],"field_name_form":["id","created_at","updated_at","deleted_at","tx_id","from","to","value","tx_type","timestamp"],"field_sortable":["n","n","n","n","n","n","n"],"filter_form_layout":["LayoutDefault"],"form_description":[""],"form_title":[""],"hide_back_button":["n"],"hide_continue_edit_check_box":["n"],"hide_continue_new_check_box":["n"],"hide_delete_button":["y"],"hide_detail_button":["n"],"hide_edit_button":["y"],"hide_export_button":["n"],"hide_filter_area":["n"],"hide_filter_button":["n"],"hide_new_button":["y"],"hide_pagination":["n"],"hide_query_info":["n"],"hide_reset_button":["n"],"hide_row_selector":["n"],"info_field_editable":["n","n","n","n","n","n","n"],"package":["pay"],"path":["/home/phantom/public/work/cuckoo-admin/tables/pay"],"permission":["n"],"pk":["id"],"table":["collects"],"table_description":[""],"table_title":["归集记录"]}	2021-06-05 18:06:48.165098	2021-06-05 18:06:48.165098
119	1	/admin/info/transfer	GET	::1		2021-06-05 18:07:23.142201	2021-06-05 18:07:23.142201
120	1	/admin/info/collect	GET	::1		2021-06-05 18:07:27.482888	2021-06-05 18:07:27.482888
121	1	/admin	GET	::1		2021-06-05 18:09:37.645783	2021-06-05 18:09:37.645783
122	1	/admin/info/transfer	GET	::1		2021-06-05 18:09:45.197694	2021-06-05 18:09:45.197694
123	1	/admin/info/collect	GET	::1		2021-06-05 18:09:52.951637	2021-06-05 18:09:52.951637
124	1	/admin/info/collect	GET	::1		2021-06-05 18:11:06.885593	2021-06-05 18:11:06.885593
125	1	/admin/info/collect	GET	::1		2021-06-05 18:13:40.922365	2021-06-05 18:13:40.922365
126	1	/admin/info/collect	GET	::1		2021-06-05 18:14:01.03347	2021-06-05 18:14:01.03347
127	1	/admin/info/collect	GET	::1		2021-06-05 18:14:46.981663	2021-06-05 18:14:46.981663
128	1	/admin/info/collect	GET	::1		2021-06-05 18:14:48.723328	2021-06-05 18:14:48.723328
129	1	/admin/info/collect	GET	::1		2021-06-05 18:14:53.365778	2021-06-05 18:14:53.365778
130	1	/admin/menu	GET	::1		2021-06-05 18:15:02.616257	2021-06-05 18:15:02.616257
131	1	/admin/menu/new	POST	::1	{"__go_admin_previous_":["/admin/menu"],"__go_admin_t_":["ef72ddcf-16d0-431d-a088-0795855ba8cc"],"header":[""],"icon":["fa-database"],"parent_id":["8"],"plugin_name":[""],"roles[]":["1"],"title":["归集记录"],"uri":["/collect"]}	2021-06-05 18:16:21.6623	2021-06-05 18:16:21.6623
132	1	/admin/menu	GET	::1		2021-06-05 18:16:23.940728	2021-06-05 18:16:23.940728
133	1	/admin/menu	GET	::1		2021-06-05 18:16:25.55638	2021-06-05 18:16:25.55638
134	1	/admin/menu	GET	::1		2021-06-05 18:16:33.235497	2021-06-05 18:16:33.235497
135	1	/admin/menu/edit/show	GET	::1		2021-06-05 18:16:40.212263	2021-06-05 18:16:40.212263
212	1	/admin/info/address	GET	::1		2021-06-05 18:35:04.063118	2021-06-05 18:35:04.063118
213	1	/admin/info/address	GET	::1		2021-06-05 18:35:04.910777	2021-06-05 18:35:04.910777
214	1	/admin/export/address	POST	::1		2021-06-05 18:35:23.671491	2021-06-05 18:35:23.671491
136	1	/admin/menu/edit	POST	::1	{"__go_admin_previous_":["/admin/menu"],"__go_admin_t_":["c19dedd3-c25e-40b2-84d8-3a02b3be5f3b"],"created_at":["2021-06-05T18:16:21.643598Z"],"header":[""],"icon":["fa-database"],"id":["10"],"parent_id":["8"],"plugin_name":[""],"roles[]":["1"],"title":["归集记录"],"updated_at":["2021-06-05T18:16:21.643598Z"],"uri":["/info/collect"]}	2021-06-05 18:16:48.676089	2021-06-05 18:16:48.676089
137	1	/admin/menu	GET	::1		2021-06-05 18:16:50.287477	2021-06-05 18:16:50.287477
138	1	/admin/info/collect	GET	::1		2021-06-05 18:16:52.502063	2021-06-05 18:16:52.502063
139	1	/admin/info/transfer	GET	::1		2021-06-05 18:17:20.607529	2021-06-05 18:17:20.607529
140	1	/admin/info/collect	GET	::1		2021-06-05 18:17:26.54769	2021-06-05 18:17:26.54769
141	1	/admin/info/transfer	GET	::1		2021-06-05 18:18:05.445777	2021-06-05 18:18:05.445777
142	1	/admin/info/collect	GET	::1		2021-06-05 18:18:10.847696	2021-06-05 18:18:10.847696
143	1	/admin/info/collect	GET	::1		2021-06-05 18:18:21.002519	2021-06-05 18:18:21.002519
144	1	/admin/info/collect	GET	::1		2021-06-05 18:18:32.478054	2021-06-05 18:18:32.478054
145	1	/admin/info/transfer	GET	::1		2021-06-05 18:18:37.577157	2021-06-05 18:18:37.577157
146	1	/admin/info/collect	GET	::1		2021-06-05 18:18:38.840457	2021-06-05 18:18:38.840457
147	1	/admin/info/transfer	GET	::1		2021-06-05 18:18:43.094704	2021-06-05 18:18:43.094704
148	1	/admin/info/collect	GET	::1		2021-06-05 18:18:44.534016	2021-06-05 18:18:44.534016
149	1	/admin	GET	::1		2021-06-05 18:18:58.667917	2021-06-05 18:18:58.667917
150	1	/admin/info/transfer	GET	::1		2021-06-05 18:19:01.427211	2021-06-05 18:19:01.427211
151	1	/admin/info/collect	GET	::1		2021-06-05 18:19:02.639452	2021-06-05 18:19:02.639452
152	1	/admin/info/collect	GET	::1		2021-06-05 18:20:00.23369	2021-06-05 18:20:00.23369
153	1	/admin/info/collect	GET	::1		2021-06-05 18:20:01.398925	2021-06-05 18:20:01.398925
154	1	/admin/menu	GET	::1		2021-06-05 18:20:08.250791	2021-06-05 18:20:08.250791
155	1	/admin/menu/edit/show	GET	::1		2021-06-05 18:20:11.906742	2021-06-05 18:20:11.906742
156	1	/admin/menu	GET	::1		2021-06-05 18:20:26.464786	2021-06-05 18:20:26.464786
157	1	/admin/menu/edit/show	GET	::1		2021-06-05 18:20:29.504503	2021-06-05 18:20:29.504503
158	1	/admin/menu	GET	::1		2021-06-05 18:20:39.512031	2021-06-05 18:20:39.512031
159	1	/admin/menu/edit/show	GET	::1		2021-06-05 18:20:40.905193	2021-06-05 18:20:40.905193
160	1	/admin/menu/edit/show	GET	::1		2021-06-05 18:20:44.623024	2021-06-05 18:20:44.623024
161	1	/admin/menu/edit	POST	::1	{"__go_admin_previous_":["/admin/menu"],"__go_admin_t_":["5ca42ad1-80ba-468a-b725-857792f02feb"],"created_at":["2021-06-05T18:16:21.643598Z"],"header":[""],"icon":["fa-500px"],"id":["10"],"parent_id":["8"],"plugin_name":[""],"roles[]":["1"],"title":["归集记录"],"updated_at":["2021-06-05T18:16:48Z"],"uri":["/info/collect"]}	2021-06-05 18:20:49.556705	2021-06-05 18:20:49.556705
162	1	/admin/menu	GET	::1		2021-06-05 18:20:53.668101	2021-06-05 18:20:53.668101
163	1	/admin/info/transfer	GET	::1		2021-06-05 18:20:57.058422	2021-06-05 18:20:57.058422
164	1	/admin/info/collect	GET	::1		2021-06-05 18:20:58.101332	2021-06-05 18:20:58.101332
165	1	/admin/info/transfer	GET	::1		2021-06-05 18:20:59.602265	2021-06-05 18:20:59.602265
166	1	/admin/info/collect	GET	::1		2021-06-05 18:21:05.776616	2021-06-05 18:21:05.776616
167	1	/admin/info/collect	GET	::1		2021-06-05 18:21:11.191915	2021-06-05 18:21:11.191915
168	1	/admin/info/collect	GET	::1		2021-06-05 18:21:12.376567	2021-06-05 18:21:12.376567
169	1	/admin/info/collect	GET	::1		2021-06-05 18:21:13.94376	2021-06-05 18:21:13.94376
170	1	/admin/info/collect	GET	::1		2021-06-05 18:22:02.686283	2021-06-05 18:22:02.686283
171	1	/admin/info/transfer	GET	::1		2021-06-05 18:22:03.725621	2021-06-05 18:22:03.725621
172	1	/admin/info/collect	GET	::1		2021-06-05 18:22:04.572874	2021-06-05 18:22:04.572874
173	1	/admin/info/transfer	GET	::1		2021-06-05 18:22:15.910049	2021-06-05 18:22:15.910049
174	1	/admin/info/collect	GET	::1		2021-06-05 18:22:17.26561	2021-06-05 18:22:17.26561
175	1	/admin/info/transfer	GET	::1		2021-06-05 18:22:18.660302	2021-06-05 18:22:18.660302
176	1	/admin/info/collect	GET	::1		2021-06-05 18:22:20.648738	2021-06-05 18:22:20.648738
177	1	/admin/info/transfer	GET	::1		2021-06-05 18:22:27.71363	2021-06-05 18:22:27.71363
178	1	/admin	GET	::1		2021-06-05 18:22:33.179586	2021-06-05 18:22:33.179586
179	1	/admin/menu	GET	::1		2021-06-05 18:22:41.779839	2021-06-05 18:22:41.779839
180	1	/admin/menu/edit/show	GET	::1		2021-06-05 18:22:46.080782	2021-06-05 18:22:46.080782
181	1	/admin	GET	::1		2021-06-05 18:22:51.224034	2021-06-05 18:22:51.224034
182	1	/admin/menu/edit/show	GET	::1		2021-06-05 18:22:52.844487	2021-06-05 18:22:52.844487
183	1	/admin/menu	GET	::1		2021-06-05 18:22:56.909469	2021-06-05 18:22:56.909469
184	1	/admin/menu/delete	POST	::1		2021-06-05 18:23:00.739111	2021-06-05 18:23:00.739111
185	1	/admin/menu	GET	::1		2021-06-05 18:23:00.765208	2021-06-05 18:23:00.765208
186	1	/admin/menu	GET	::1		2021-06-05 18:23:03.116638	2021-06-05 18:23:03.116638
187	1	/admin/info/collect	GET	::1		2021-06-05 18:23:05.237938	2021-06-05 18:23:05.237938
188	1	/admin/menu	GET	::1		2021-06-05 18:23:10.304389	2021-06-05 18:23:10.304389
189	1	/admin/menu/edit/show	GET	::1		2021-06-05 18:23:13.198936	2021-06-05 18:23:13.198936
190	1	/admin/menu/edit	POST	::1	{"__go_admin_previous_":["/admin/menu"],"__go_admin_t_":["f8f0252c-a588-4201-b551-a57a54eb2f3b"],"created_at":["2021-06-05T18:16:21.643598Z"],"header":[""],"icon":["fa-database"],"id":["10"],"parent_id":["8"],"plugin_name":[""],"roles[]":["1"],"title":["归集记录"],"updated_at":["2021-06-05T18:20:49Z"],"uri":["/info/collect"]}	2021-06-05 18:23:35.903343	2021-06-05 18:23:35.903343
191	1	/admin/menu	GET	::1		2021-06-05 18:23:37.885468	2021-06-05 18:23:37.885468
192	1	/admin/menu	GET	::1		2021-06-05 18:23:39.981455	2021-06-05 18:23:39.981455
193	1	/admin/info/transfer	GET	::1		2021-06-05 18:24:08.64977	2021-06-05 18:24:08.64977
194	1	/admin/info/collect	GET	::1		2021-06-05 18:24:09.774872	2021-06-05 18:24:09.774872
195	1	/admin/info/transfer	GET	::1		2021-06-05 18:24:11.012526	2021-06-05 18:24:11.012526
196	1	/admin/info/collect	GET	::1		2021-06-05 18:24:12.220888	2021-06-05 18:24:12.220888
197	1	/admin/info/transfer	GET	::1		2021-06-05 18:24:19.419981	2021-06-05 18:24:19.419981
198	1	/admin/info/generate/new	GET	::1		2021-06-05 18:26:37.451209	2021-06-05 18:26:37.451209
199	1	/admin/operation/_tool_choose_conn	POST	::1		2021-06-05 18:26:48.293507	2021-06-05 18:26:48.293507
200	1	/admin/operation/_tool_choose_table	POST	::1		2021-06-05 18:26:51.235712	2021-06-05 18:26:51.235712
201	1	/admin/new/generate	POST	::1	{"__checkbox__hide_back_button":["on"],"__checkbox__hide_continue_edit_check_box":["on"],"__checkbox__hide_continue_new_check_box":["on"],"__checkbox__hide_export_button":["on"],"__checkbox__hide_filter_area":["on"],"__checkbox__hide_filter_button":["on"],"__checkbox__hide_pagination":["on"],"__checkbox__hide_reset_button":["on"],"__checkbox__hide_row_selector":["on"],"__go_admin_previous_":["/admin/info/generate?__page=1\\u0026__pageSize=10\\u0026__sort=id\\u0026__sort_type=desc"],"__go_admin_t_":["63bc5c3e-ecfb-4d18-a5a7-181c3b21a327"],"conn":["default"],"detail_description":[""],"detail_display":["0"],"detail_title":[""],"extra_code":[""],"field_canadd":["n","y","y","y","y","y"],"field_canedit":["y","y","y","y","y","y"],"field_db_type":["Int8","Timestamptz","Text","Text"],"field_db_type_form":["Int8","Timestamptz","Timestamptz","Timestamptz","Text","Text"],"field_default":["","","","","",""],"field_display":["","1","1","","",""],"field_filterable":["n","n","y","n"],"field_form_type_form":["Default","Datetime","Datetime","Datetime","RichText","RichText"],"field_head":["Id","创建时间","地址","私钥(加密)"],"field_head_form":["Id","Created_at","Updated_at","Deleted_at","Addr","Private_key"],"field_hide":["n","n","n","y"],"field_name":["id","created_at","addr","private_key"],"field_name_form":["id","created_at","updated_at","deleted_at","addr","private_key"],"field_sortable":["y","n","n","n"],"filter_form_layout":["LayoutTwoCol"],"form_description":[""],"form_title":[""],"hide_back_button":["n"],"hide_continue_edit_check_box":["n"],"hide_continue_new_check_box":["n"],"hide_delete_button":["y"],"hide_detail_button":["y"],"hide_edit_button":["y"],"hide_export_button":["n"],"hide_filter_area":["n"],"hide_filter_button":["n"],"hide_new_button":["y"],"hide_pagination":["n"],"hide_query_info":["y"],"hide_reset_button":["n"],"hide_row_selector":["n"],"info_field_editable":["n","n","n","n"],"package":["pay"],"path":["/home/phantom/public/work/cuckoo-admin/tables/pay"],"permission":["n"],"pk":["id"],"table":["addresses"],"table_description":["地址"],"table_title":["地址列表"]}	2021-06-05 18:31:15.653996	2021-06-05 18:31:15.653996
202	1	/admin/info/generate/new	GET	::1		2021-06-05 18:32:21.418883	2021-06-05 18:32:21.418883
203	1	/admin/info/generate/new	GET	::1		2021-06-05 18:32:24.71643	2021-06-05 18:32:24.71643
204	1	/admin	GET	::1		2021-06-05 18:32:26.592667	2021-06-05 18:32:26.592667
205	1	/admin	GET	::1		2021-06-05 18:32:28.214647	2021-06-05 18:32:28.214647
206	1	/admin	GET	::1		2021-06-05 18:32:31.846387	2021-06-05 18:32:31.846387
207	1	/admin/info/transfer	GET	::1		2021-06-05 18:32:36.164197	2021-06-05 18:32:36.164197
208	1	/admin/info/address	GET	::1		2021-06-05 18:32:39.410479	2021-06-05 18:32:39.410479
209	1	/admin/info/address	GET	::1		2021-06-05 18:34:46.531141	2021-06-05 18:34:46.531141
210	1	/admin/info/address	GET	::1		2021-06-05 18:34:49.788082	2021-06-05 18:34:49.788082
211	1	/admin/info/address	GET	::1		2021-06-05 18:34:56.915269	2021-06-05 18:34:56.915269
215	1	/admin/menu	GET	::1		2021-06-05 18:36:03.276488	2021-06-05 18:36:03.276488
216	1	/admin/menu/new	POST	::1	{"__go_admin_previous_":["/admin/menu"],"__go_admin_t_":["7d4ac3c1-f636-402c-a5a0-4e79becda180"],"header":[""],"icon":["fa-th"],"parent_id":["8"],"plugin_name":[""],"roles[]":["1"],"title":["地址列表"],"uri":["/info/address"]}	2021-06-05 18:36:55.282683	2021-06-05 18:36:55.282683
217	1	/admin/menu	GET	::1		2021-06-05 18:36:57.28439	2021-06-05 18:36:57.28439
218	1	/admin/menu	GET	::1		2021-06-05 18:36:59.114776	2021-06-05 18:36:59.114776
219	1	/admin/info/collect	GET	::1		2021-06-05 18:37:01.330862	2021-06-05 18:37:01.330862
220	1	/admin/info/transfer	GET	::1		2021-06-05 18:37:02.214765	2021-06-05 18:37:02.214765
221	1	/admin/info/address	GET	::1		2021-06-05 18:37:03.218751	2021-06-05 18:37:03.218751
222	1	/admin/info/collect	GET	::1		2021-06-05 18:37:04.805461	2021-06-05 18:37:04.805461
223	1	/admin/info/transfer	GET	::1		2021-06-05 18:37:06.275713	2021-06-05 18:37:06.275713
224	1	/admin/info/collect	GET	::1		2021-06-05 18:37:08.951759	2021-06-05 18:37:08.951759
225	1	/admin/info/address	GET	::1		2021-06-05 18:37:10.199419	2021-06-05 18:37:10.199419
226	1	/admin/info/collect	GET	::1		2021-06-05 18:37:12.360028	2021-06-05 18:37:12.360028
227	1	/admin/info/address	GET	::1		2021-06-05 18:37:17.320823	2021-06-05 18:37:17.320823
228	1	/admin/info/collect	GET	::1		2021-06-05 18:37:30.278861	2021-06-05 18:37:30.278861
229	1	/admin/info/transfer	GET	::1		2021-06-05 18:37:32.335729	2021-06-05 18:37:32.335729
230	1	/admin/info/transfer/detail	GET	::1		2021-06-05 18:37:35.167549	2021-06-05 18:37:35.167549
231	1	/admin/info/collect	GET	::1		2021-06-05 18:44:47.09914	2021-06-05 18:44:47.09914
232	1	/admin/info/transfer	GET	::1		2021-06-05 18:45:17.075492	2021-06-05 18:45:17.075492
233	1	/admin/info/transfer	GET	::1		2021-06-05 18:49:27.158737	2021-06-05 18:49:27.158737
234	1	/admin/info/transfer	GET	::1		2021-06-05 18:49:29.124383	2021-06-05 18:49:29.124383
235	1	/admin/info/collect	GET	::1		2021-06-05 18:49:30.60783	2021-06-05 18:49:30.60783
236	1	/admin/info/address	GET	::1		2021-06-05 18:49:31.479467	2021-06-05 18:49:31.479467
237	1	/admin/info/collect	GET	::1		2021-06-05 18:49:32.280125	2021-06-05 18:49:32.280125
238	1	/admin/info/transfer	GET	::1		2021-06-05 18:49:33.052039	2021-06-05 18:49:33.052039
239	1	/admin/info/collect	GET	::1		2021-06-05 18:49:33.657164	2021-06-05 18:49:33.657164
240	1	/admin/info/address	GET	::1		2021-06-05 18:49:34.151488	2021-06-05 18:49:34.151488
241	1	/admin/info/collect	GET	::1		2021-06-05 18:49:35.180971	2021-06-05 18:49:35.180971
242	1	/admin/info/transfer	GET	::1		2021-06-05 18:49:35.859017	2021-06-05 18:49:35.859017
243	1	/admin/info/transfer	GET	::1		2021-06-05 19:09:35.391097	2021-06-05 19:09:35.391097
244	1	/admin/info/transfer	GET	::1		2021-06-05 19:12:04.692693	2021-06-05 19:12:04.692693
245	1	/admin/info/transfer/detail	GET	::1		2021-06-05 19:12:11.267222	2021-06-05 19:12:11.267222
246	1	/admin/info/transfer/detail	GET	::1		2021-06-05 19:12:50.151658	2021-06-05 19:12:50.151658
247	1	/admin/info/transfer	GET	::1		2021-06-05 19:13:48.457149	2021-06-05 19:13:48.457149
248	1	/admin/info/transfer	GET	::1		2021-06-05 19:13:49.431915	2021-06-05 19:13:49.431915
249	1	/admin/info/transfer/detail	GET	::1		2021-06-05 19:13:51.905568	2021-06-05 19:13:51.905568
250	1	/admin/info/transfer	GET	::1		2021-06-05 19:14:09.686369	2021-06-05 19:14:09.686369
251	1	/admin/info/transfer	GET	::1		2021-06-05 19:14:10.361428	2021-06-05 19:14:10.361428
252	1	/admin/info/transfer	GET	::1		2021-06-05 19:14:22.893969	2021-06-05 19:14:22.893969
253	1	/admin/info/transfer/detail	GET	::1		2021-06-05 19:14:24.467141	2021-06-05 19:14:24.467141
254	1	/admin/info/transfer	GET	::1		2021-06-05 19:14:34.058045	2021-06-05 19:14:34.058045
255	1	/admin/info/transfer/detail	GET	::1		2021-06-05 19:16:26.297878	2021-06-05 19:16:26.297878
256	1	/admin	GET	::1		2021-06-05 19:21:14.506029	2021-06-05 19:21:14.506029
257	1	/admin	GET	::1		2021-06-05 19:21:15.703665	2021-06-05 19:21:15.703665
258	1	/admin/info/address	GET	::1		2021-06-05 19:21:17.988665	2021-06-05 19:21:17.988665
259	1	/admin/info/collect	GET	::1		2021-06-05 19:21:19.049113	2021-06-05 19:21:19.049113
260	1	/admin/info/transfer	GET	::1		2021-06-05 19:21:19.969883	2021-06-05 19:21:19.969883
261	1	/admin/info/transfer/detail	GET	::1		2021-06-05 19:21:21.723241	2021-06-05 19:21:21.723241
262	1	/admin/info/transfer/detail	GET	::1		2021-06-05 19:21:43.705041	2021-06-05 19:21:43.705041
263	1	/admin/info/transfer	GET	::1		2021-06-05 19:21:45.697691	2021-06-05 19:21:45.697691
264	1	/admin/info/transfer	GET	::1		2021-06-05 19:21:49.859193	2021-06-05 19:21:49.859193
265	1	/admin/info/transfer	GET	::1		2021-06-05 19:21:50.680451	2021-06-05 19:21:50.680451
266	1	/admin/info/transfer/detail	GET	::1		2021-06-05 19:21:53.207617	2021-06-05 19:21:53.207617
267	1	/admin/info/transfer/detail	GET	::1		2021-06-05 19:22:27.240774	2021-06-05 19:22:27.240774
268	1	/admin/info/transfer	GET	::1		2021-06-05 19:22:28.91007	2021-06-05 19:22:28.91007
269	1	/admin/info/transfer	GET	::1		2021-06-05 19:22:30.136059	2021-06-05 19:22:30.136059
270	1	/admin/info/transfer/detail	GET	::1		2021-06-05 19:22:32.556827	2021-06-05 19:22:32.556827
271	1	/admin/info/transfer/detail	GET	::1		2021-06-05 19:22:41.564317	2021-06-05 19:22:41.564317
272	1	/admin/info/transfer	GET	::1		2021-06-05 19:22:44.550729	2021-06-05 19:22:44.550729
273	1	/admin/info/transfer	GET	::1		2021-06-05 19:22:48.151452	2021-06-05 19:22:48.151452
274	1	/admin/info/transfer/detail	GET	::1		2021-06-05 19:22:50.195471	2021-06-05 19:22:50.195471
275	1	/admin/info/transfer/detail	GET	::1		2021-06-05 19:23:18.907983	2021-06-05 19:23:18.907983
276	1	/admin/info/transfer	GET	::1		2021-06-05 19:23:19.471344	2021-06-05 19:23:19.471344
277	1	/admin/info/transfer	GET	::1		2021-06-05 19:23:24.215946	2021-06-05 19:23:24.215946
278	1	/admin/info/transfer	GET	::1		2021-06-05 19:26:26.143785	2021-06-05 19:26:26.143785
279	1	/admin/operation/_see_more_example	POST	::1		2021-06-05 19:26:28.781297	2021-06-05 19:26:28.781297
280	1	/admin/operation/_see_more_example	POST	::1		2021-06-05 19:26:32.091801	2021-06-05 19:26:32.091801
281	1	/admin/operation/_see_more_example	POST	::1		2021-06-05 19:26:42.573719	2021-06-05 19:26:42.573719
282	1	/admin/operation/_see_more_example	POST	::1		2021-06-05 19:26:52.765745	2021-06-05 19:26:52.765745
283	1	/admin/menu	GET	::1		2021-06-05 19:27:18.030392	2021-06-05 19:27:18.030392
284	1	/admin/menu	GET	::1		2021-06-05 19:38:20.643861	2021-06-05 19:38:20.643861
285	1	/admin/info/address	GET	::1		2021-06-05 19:38:23.298963	2021-06-05 19:38:23.298963
286	1	/admin/info/collect	GET	::1		2021-06-05 19:38:24.118062	2021-06-05 19:38:24.118062
287	1	/admin/info/transfer	GET	::1		2021-06-05 19:38:24.801303	2021-06-05 19:38:24.801303
288	1	/admin/operation/_info_callback	POST	::1		2021-06-05 19:38:27.614057	2021-06-05 19:38:27.614057
289	1	/admin/operation/_info_callback	POST	::1		2021-06-05 19:38:31.838108	2021-06-05 19:38:31.838108
290	1	/admin/info/transfer/detail	GET	::1		2021-06-05 19:38:59.019761	2021-06-05 19:38:59.019761
291	1	/admin/info/transfer	GET	::1		2021-06-05 19:39:02.323075	2021-06-05 19:39:02.323075
292	1	/admin/info/transfer	GET	::1		2021-06-05 19:39:52.04726	2021-06-05 19:39:52.04726
293	1	/admin/operation/_info_callback	POST	::1		2021-06-05 19:39:55.480162	2021-06-05 19:39:55.480162
294	1	/admin/operation/_info_callback	POST	::1		2021-06-05 19:40:25.774773	2021-06-05 19:40:25.774773
295	1	/admin/info/manager	GET	::1		2021-06-05 19:42:46.576382	2021-06-05 19:42:46.576382
296	1	/admin/info/manager/detail	GET	::1		2021-06-05 19:42:52.338787	2021-06-05 19:42:52.338787
297	1	/admin/info/roles	GET	::1		2021-06-05 19:42:57.752176	2021-06-05 19:42:57.752176
298	1	/admin/menu	GET	::1		2021-06-05 19:43:00.396353	2021-06-05 19:43:00.396353
299	1	/admin/info/permission	GET	::1		2021-06-05 19:43:01.300198	2021-06-05 19:43:01.300198
300	1	/admin/info/permission/detail	GET	::1		2021-06-05 19:43:08.169624	2021-06-05 19:43:08.169624
301	1	/admin/menu	GET	::1		2021-06-05 19:43:12.216607	2021-06-05 19:43:12.216607
302	1	/admin/info/op	GET	::1		2021-06-05 19:43:12.659325	2021-06-05 19:43:12.659325
303	1	/admin/info/permission	GET	::1		2021-06-05 19:43:19.64906	2021-06-05 19:43:19.64906
304	1	/admin/menu	GET	::1		2021-06-05 19:43:21.880267	2021-06-05 19:43:21.880267
305	1	/admin/info/roles	GET	::1		2021-06-05 19:43:23.517692	2021-06-05 19:43:23.517692
306	1	/admin/info/manager	GET	::1		2021-06-05 19:43:26.808446	2021-06-05 19:43:26.808446
307	1	/admin/info/roles	GET	::1		2021-06-05 19:43:30.71196	2021-06-05 19:43:30.71196
308	1	/admin/info/manager	GET	::1		2021-06-05 19:43:31.693603	2021-06-05 19:43:31.693603
309	1	/admin/info/permission	GET	::1		2021-06-05 19:43:32.927523	2021-06-05 19:43:32.927523
310	1	/admin/menu	GET	::1		2021-06-05 19:43:35.455694	2021-06-05 19:43:35.455694
311	1	/admin/info/permission	GET	::1		2021-06-05 19:43:36.290694	2021-06-05 19:43:36.290694
312	1	/admin/info/permission	GET	::1		2021-06-05 19:45:45.756661	2021-06-05 19:45:45.756661
313	1	/admin/info/transfer	GET	::1		2021-06-05 19:45:48.334382	2021-06-05 19:45:48.334382
314	1	/admin/operation/_info_callback	POST	::1		2021-06-05 19:45:51.603523	2021-06-05 19:45:51.603523
315	1	/admin/info/transfer	GET	::1		2021-06-05 19:47:49.476148	2021-06-05 19:47:49.476148
316	1	/admin/operation/_info_callback	POST	::1		2021-06-05 19:47:51.18238	2021-06-05 19:47:51.18238
317	1	/admin/info/transfer	GET	::1		2021-06-05 19:50:43.589358	2021-06-05 19:50:43.589358
318	1	/admin/operation/_info_callback	POST	::1		2021-06-05 19:50:45.090049	2021-06-05 19:50:45.090049
319	1	/admin/info/transfer	GET	::1		2021-06-05 19:57:55.539018	2021-06-05 19:57:55.539018
320	1	/admin/operation/_info_callback	POST	::1		2021-06-05 19:57:57.489444	2021-06-05 19:57:57.489444
321	1	/admin/operation/_info_callback	POST	::1		2021-06-05 19:58:17.681827	2021-06-05 19:58:17.681827
322	1	/admin/info/generate/new	GET	::1		2021-06-05 20:12:39.403643	2021-06-05 20:12:39.403643
323	1	/admin/info/transfer	GET	::1		2021-06-05 20:12:55.819048	2021-06-05 20:12:55.819048
324	1	/admin/operation/_info_callback	POST	::1		2021-06-05 20:12:57.480681	2021-06-05 20:12:57.480681
325	1	/admin/info/transfer	GET	::1		2021-06-05 20:13:33.254489	2021-06-05 20:13:33.254489
326	1	/admin/operation/_info_callback	POST	::1		2021-06-05 20:13:35.266245	2021-06-05 20:13:35.266245
327	1	/admin/info/transfer	GET	::1		2021-06-05 20:13:50.03732	2021-06-05 20:13:50.03732
328	1	/admin/operation/_info_callback	POST	::1		2021-06-05 20:13:51.35413	2021-06-05 20:13:51.35413
329	1	/admin/info/transfer	GET	::1		2021-06-05 20:27:18.50949	2021-06-05 20:27:18.50949
330	1	/admin/operation/_info_callback	POST	::1		2021-06-05 20:27:21.202173	2021-06-05 20:27:21.202173
331	1	/admin/info/transfer	GET	::1		2021-06-05 20:27:49.697876	2021-06-05 20:27:49.697876
332	1	/admin/operation/_info_callback	POST	::1		2021-06-05 20:27:50.906565	2021-06-05 20:27:50.906565
333	1	/admin/info/transfer	GET	::1		2021-06-05 20:28:50.554278	2021-06-05 20:28:50.554278
334	1	/admin/operation/_info_callback	POST	::1		2021-06-05 20:28:52.780449	2021-06-05 20:28:52.780449
335	1	/admin/info/transfer	GET	::1		2021-06-05 20:34:27.221333	2021-06-05 20:34:27.221333
336	1	/admin/operation/_info_callback	POST	::1		2021-06-05 20:34:28.731497	2021-06-05 20:34:28.731497
337	1	/admin/info/transfer	GET	::1		2021-06-05 20:35:19.47035	2021-06-05 20:35:19.47035
338	1	/admin/operation/_info_callback	POST	::1		2021-06-05 20:35:20.716827	2021-06-05 20:35:20.716827
339	1	/admin/info/transfer	GET	::1		2021-06-05 20:35:46.407047	2021-06-05 20:35:46.407047
340	1	/admin/operation/_info_callback	POST	::1		2021-06-05 20:35:47.621547	2021-06-05 20:35:47.621547
341	1	/admin/operation/_info_callback	POST	::1		2021-06-05 20:36:03.468238	2021-06-05 20:36:03.468238
342	1	/admin/info/transfer	GET	::1		2021-06-05 20:36:07.991057	2021-06-05 20:36:07.991057
343	1	/admin/info/transfer/detail	GET	::1		2021-06-05 20:36:13.024857	2021-06-05 20:36:13.024857
344	1	/admin/info/transfer/detail	GET	::1		2021-06-05 20:37:15.630091	2021-06-05 20:37:15.630091
345	1	/admin/info/transfer/detail	GET	::1		2021-06-05 20:39:27.545868	2021-06-05 20:39:27.545868
346	1	/admin/info/transfer	GET	::1		2021-06-05 20:40:14.667482	2021-06-05 20:40:14.667482
347	1	/admin/operation/_info_callback	POST	::1		2021-06-05 20:40:17.271279	2021-06-05 20:40:17.271279
348	1	/admin/info/transfer	GET	::1		2021-06-05 20:40:20.475558	2021-06-05 20:40:20.475558
349	1	/admin/info/transfer/detail	GET	::1		2021-06-05 20:40:38.748538	2021-06-05 20:40:38.748538
350	1	/admin/info/transfer	GET	::1		2021-06-05 20:41:08.191224	2021-06-05 20:41:08.191224
351	1	/admin/info/transfer	GET	::1		2021-06-05 20:41:08.722976	2021-06-05 20:41:08.722976
352	1	/admin/info/transfer/detail	GET	::1		2021-06-05 20:41:13.815841	2021-06-05 20:41:13.815841
353	1	/admin/info/transfer/detail	GET	::1		2021-06-05 20:43:11.879403	2021-06-05 20:43:11.879403
354	1	/admin/info/transfer/detail	GET	::1		2021-06-05 20:43:33.975032	2021-06-05 20:43:33.975032
355	1	/admin/info/transfer/detail	GET	::1		2021-06-05 20:43:43.77222	2021-06-05 20:43:43.77222
356	1	/admin/info/transfer	GET	::1		2021-06-05 20:43:45.683989	2021-06-05 20:43:45.683989
357	1	/admin/operation/_info_callback	POST	::1		2021-06-05 20:43:47.117365	2021-06-05 20:43:47.117365
358	1	/admin/info/transfer/detail	GET	::1		2021-06-05 20:43:51.494219	2021-06-05 20:43:51.494219
359	1	/admin/info/transfer/detail	GET	::1		2021-06-05 20:44:14.164907	2021-06-05 20:44:14.164907
360	1	/admin/info/transfer	GET	::1		2021-06-05 20:44:15.574453	2021-06-05 20:44:15.574453
361	1	/admin/info/transfer	GET	::1		2021-06-05 20:44:16.771151	2021-06-05 20:44:16.771151
362	1	/admin/info/transfer/edit	GET	::1		2021-06-05 20:44:20.541014	2021-06-05 20:44:20.541014
363	1	/admin/info/transfer/edit	GET	::1		2021-06-05 20:44:20.564889	2021-06-05 20:44:20.564889
364	1	/admin/info/transfer	GET	::1		2021-06-05 20:48:21.628734	2021-06-05 20:48:21.628734
365	1	/admin/info/transfer/edit	GET	::1		2021-06-05 20:48:25.78578	2021-06-05 20:48:25.78578
366	1	/admin/info/transfer/edit	GET	::1		2021-06-05 20:48:25.807137	2021-06-05 20:48:25.807137
367	1	/admin/info/transfer	GET	::1		2021-06-05 20:49:52.471715	2021-06-05 20:49:52.471715
368	1	/admin/info/transfer	GET	::1		2021-06-05 20:49:55.265131	2021-06-05 20:49:55.265131
369	1	/admin/info/transfer/edit	GET	::1		2021-06-05 20:49:58.29941	2021-06-05 20:49:58.29941
370	1	/admin/info/transfer/edit	GET	::1		2021-06-05 20:49:58.327659	2021-06-05 20:49:58.327659
371	1	/admin/info/generate/new	GET	::1		2021-06-05 20:51:19.026495	2021-06-05 20:51:19.026495
372	1	/admin/operation/_tool_choose_conn	POST	::1		2021-06-05 20:51:25.182826	2021-06-05 20:51:25.182826
373	1	/admin/operation/_tool_choose_table	POST	::1		2021-06-05 20:51:27.945372	2021-06-05 20:51:27.945372
374	1	/admin/new/generate	POST	::1	{"__checkbox__hide_back_button":["on"],"__checkbox__hide_delete_button":["on"],"__checkbox__hide_detail_button":["on"],"__checkbox__hide_edit_button":["on"],"__checkbox__hide_export_button":["on"],"__checkbox__hide_filter_area":["on"],"__checkbox__hide_filter_button":["on"],"__checkbox__hide_new_button":["on"],"__checkbox__hide_pagination":["on"],"__checkbox__hide_query_info":["on"],"__checkbox__hide_reset_button":["on"],"__checkbox__hide_row_selector":["on"],"__go_admin_previous_":["/admin/info/generate?__page=1\\u0026__pageSize=10\\u0026__sort=id\\u0026__sort_type=desc"],"__go_admin_t_":["152b23d2-7ac9-4234-a47b-fec9b0084c05"],"conn":["default"],"detail_description":[""],"detail_display":["0"],"detail_title":[""],"extra_code":[""],"field_canadd":["y"],"field_canedit":["y"],"field_db_type":["Int8","Timestamptz","Timestamptz","Timestamptz","Text","Int8","Int8","Text","Text","Text","Text","Int8","Bool","Int8","Text"],"field_db_type_form":["Text"],"field_default":[""],"field_display":[""],"field_filterable":["n","n","n","n","n","n","n","n","n","n","n","n","n","n","n"],"field_form_type_form":["RichText"],"field_head":["Id","Created_at","Updated_at","Deleted_at","Tx_id","Block_height","Timestamp","From","To","Tx_type","Value","Status","Call_back","Call_back_num","Call_back_url"],"field_head_form":["回调地址"],"field_hide":["n","n","n","n","n","n","n","n","n","n","n","n","n","n","n"],"field_name":["id","created_at","updated_at","deleted_at","tx_id","block_height","timestamp","from","to","tx_type","value","status","call_back","call_back_num","call_back_url"],"field_name_form":["call_back_url"],"field_sortable":["n","n","n","n","n","n","n","n","n","n","n","n","n","n","n"],"filter_form_layout":["LayoutDefault"],"form_description":[""],"form_title":["设置回调地址"],"hide_back_button":["n"],"hide_continue_edit_check_box":["y"],"hide_continue_new_check_box":["y"],"hide_delete_button":["n"],"hide_detail_button":["n"],"hide_edit_button":["n"],"hide_export_button":["n"],"hide_filter_area":["n"],"hide_filter_button":["n"],"hide_new_button":["n"],"hide_pagination":["n"],"hide_query_info":["n"],"hide_reset_button":["n"],"hide_row_selector":["n"],"info_field_editable":["n","n","n","n","n","n","n","n","n","n","n","n","n","n","n"],"package":["pay"],"path":["/home/phantom/public/work/cuckoo-admin/tables"],"permission":["n"],"pk":["id"],"table":["transfers"],"table_description":[""],"table_title":[""]}	2021-06-05 20:52:41.170845	2021-06-05 20:52:41.170845
375	1	/admin	GET	::1		2021-06-05 20:53:23.442667	2021-06-05 20:53:23.442667
376	1	/admin	GET	::1		2021-06-05 20:53:24.655671	2021-06-05 20:53:24.655671
377	1	/admin/info/transfer	GET	::1		2021-06-05 20:53:27.982769	2021-06-05 20:53:27.982769
378	1	/admin/info/transfer/edit	GET	::1		2021-06-05 20:53:29.975239	2021-06-05 20:53:29.975239
379	1	/admin/edit/transfer	POST	::1	{"__go_admin_previous_":["/admin/info/transfer?__page=1\\u0026__pageSize=10\\u0026__sort=id\\u0026__sort_type=desc"],"__go_admin_t_":["26adf800-0f6d-4037-b016-d08935c3c021"],"call_back_url":["\\u003cp\\u003ewww.baidu.com\\u003c/p\\u003e"],"id":["3"]}	2021-06-05 20:53:38.322558	2021-06-05 20:53:38.322558
380	1	/admin/info/transfer/detail	GET	::1		2021-06-05 20:53:40.752842	2021-06-05 20:53:40.752842
381	1	/admin/info/transfer	GET	::1		2021-06-05 20:53:43.716733	2021-06-05 20:53:43.716733
382	1	/admin/info/transfer/edit	GET	::1		2021-06-05 20:53:45.959483	2021-06-05 20:53:45.959483
383	1	/admin	GET	::1		2021-06-05 20:53:53.656039	2021-06-05 20:53:53.656039
384	1	/admin	GET	::1		2021-06-05 20:54:23.84706	2021-06-05 20:54:23.84706
386	1	/admin/menu	GET	::1		2021-06-05 20:54:36.307339	2021-06-05 20:54:36.307339
387	1	/admin	GET	::1		2021-06-05 20:54:43.432922	2021-06-05 20:54:43.432922
388	1	/admin	GET	::1		2021-06-05 20:55:53.069485	2021-06-05 20:55:53.069485
389	1	/admin/info/address	GET	::1		2021-06-05 20:55:57.599019	2021-06-05 20:55:57.599019
390	1	/admin/info/collect	GET	::1		2021-06-05 20:55:58.303854	2021-06-05 20:55:58.303854
391	1	/admin/info/transfer	GET	::1		2021-06-05 20:55:59.072	2021-06-05 20:55:59.072
\.


--
-- Data for Name: goadmin_permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.goadmin_permissions (id, name, slug, http_method, http_path, created_at, updated_at) FROM stdin;
1	All permission	*		*	2019-09-10 00:00:00	2019-09-10 00:00:00
2	Dashboard	dashboard	GET,PUT,POST,DELETE	/	2019-09-10 00:00:00	2019-09-10 00:00:00
3	transfers 查询	transfers_query	GET	/info/transfers	2021-06-05 16:47:54.579576	2021-06-05 16:47:54.579576
4	transfers 编辑页显示	transfers_show_edit	GET	/info/transfers/edit	2021-06-05 16:47:54.580438	2021-06-05 16:47:54.580438
5	transfers 新建记录页显示	transfers_show_create	GET	/info/transfers/new	2021-06-05 16:47:54.581301	2021-06-05 16:47:54.581301
6	transfers 编辑	transfers_edit	POST	/edit/transfers	2021-06-05 16:47:54.582073	2021-06-05 16:47:54.582073
7	transfers 新建	transfers_create	POST	/new/transfers	2021-06-05 16:47:54.582824	2021-06-05 16:47:54.582824
8	transfers 删除	transfers_delete	POST	/delete/transfers	2021-06-05 16:47:54.5836	2021-06-05 16:47:54.5836
9	transfers 导出	transfers_export	POST	/export/transfers	2021-06-05 16:47:54.584287	2021-06-05 16:47:54.584287
\.


--
-- Data for Name: goadmin_role_menu; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.goadmin_role_menu (role_id, menu_id, created_at, updated_at) FROM stdin;
1	1	2019-09-10 00:00:00	2019-09-10 00:00:00
1	9	2021-06-05 17:11:32.181511	2021-06-05 17:11:32.181511
1	8	2021-06-05 17:11:41.484178	2021-06-05 17:11:41.484178
1	10	2021-06-05 18:23:35.884234	2021-06-05 18:23:35.884234
1	11	2021-06-05 18:36:55.264497	2021-06-05 18:36:55.264497
\.


--
-- Data for Name: goadmin_role_permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.goadmin_role_permissions (role_id, permission_id, created_at, updated_at) FROM stdin;
1	1	2019-09-10 00:00:00	2019-09-10 00:00:00
1	2	2019-09-10 00:00:00	2019-09-10 00:00:00
2	2	2019-09-10 00:00:00	2019-09-10 00:00:00
0	3	\N	\N
0	3	\N	\N
0	3	\N	\N
0	3	\N	\N
0	3	\N	\N
0	3	\N	\N
0	3	\N	\N
0	3	\N	\N
0	3	\N	\N
0	3	\N	\N
0	3	\N	\N
0	3	\N	\N
0	3	\N	\N
0	3	\N	\N
0	3	\N	\N
0	3	\N	\N
\.


--
-- Data for Name: goadmin_role_users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.goadmin_role_users (role_id, user_id, created_at, updated_at) FROM stdin;
1	1	2019-09-10 00:00:00	2019-09-10 00:00:00
2	2	2019-09-10 00:00:00	2019-09-10 00:00:00
\.


--
-- Data for Name: goadmin_roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.goadmin_roles (id, name, slug, created_at, updated_at) FROM stdin;
1	Administrator	administrator	2019-09-10 00:00:00	2019-09-10 00:00:00
2	Operator	operator	2019-09-10 00:00:00	2019-09-10 00:00:00
\.


--
-- Data for Name: goadmin_session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.goadmin_session (id, sid, "values", created_at, updated_at) FROM stdin;
3	b0c5692e-e1a4-4e89-831a-543fa3e8a6a8	__csrf_token__	2021-06-05 16:03:44.850791	2021-06-05 16:03:44.850791
8	28282db2-9aa7-4d96-9a02-1ef1b0177543	__csrf_token__	2021-06-05 16:53:13.879717	2021-06-05 16:53:13.879717
10	41f6b941-24d5-41fe-8297-ad1a71412c3a	__csrf_token__	2021-06-05 16:55:13.699043	2021-06-05 16:55:13.699043
11	f59a4e26-450c-4fca-8634-a8e6dff648e3	__csrf_token__	2021-06-05 17:05:32.452233	2021-06-05 17:05:32.452233
13	0fba1da1-b777-40f0-95d9-8084010d84f0	__csrf_token__	2021-06-05 17:10:53.883249	2021-06-05 17:10:53.883249
14	2f7db2d8-b382-408b-82d2-38d69671e0e9	__csrf_token__	2021-06-05 17:10:56.762752	2021-06-05 17:10:56.762752
16	c32322ef-7931-4197-934c-9a297550b576	__csrf_token__	2021-06-05 17:11:32.187136	2021-06-05 17:11:32.187136
18	195dbec8-7323-44f5-ab0d-eadb43988c6c	__csrf_token__	2021-06-05 17:11:41.49098	2021-06-05 17:11:41.49098
19	9acbdb33-5b4c-4a67-82b2-255d9b925497	__csrf_token__	2021-06-05 17:11:43.426515	2021-06-05 17:11:43.426515
20	248e6d26-6d1d-44c6-8116-71519083dce8	__csrf_token__	2021-06-05 17:14:03.090147	2021-06-05 17:14:03.090147
22	df6099a3-787a-4487-a377-df79d4030eca	__csrf_token__	2021-06-05 18:06:48.164291	2021-06-05 18:06:48.164291
25	1109c612-f5af-4eea-8622-e41609a9284c	__csrf_token__	2021-06-05 18:16:21.650667	2021-06-05 18:16:21.650667
26	638ab605-a1bb-43c0-afae-5bed572bc78a	__csrf_token__	2021-06-05 18:16:23.920759	2021-06-05 18:16:23.920759
27	f4132a66-02b4-49a0-b528-71ed6ac2fbd5	__csrf_token__	2021-06-05 18:16:25.538328	2021-06-05 18:16:25.538328
28	73460fca-0eae-45d0-a6b6-6d7adc5ea802	__csrf_token__	2021-06-05 18:16:33.222087	2021-06-05 18:16:33.222087
30	6a323698-503a-4593-8733-2ce8b2d9b9b9	__csrf_token__	2021-06-05 18:16:48.664933	2021-06-05 18:16:48.664933
31	7c0752a6-c41f-4b55-bd78-585b186e6a6e	__csrf_token__	2021-06-05 18:16:50.267386	2021-06-05 18:16:50.267386
32	2c8a50a2-6b0f-47b4-9851-a494501984a2	__csrf_token__	2021-06-05 18:20:08.235215	2021-06-05 18:20:08.235215
33	0574a4c8-2b97-423f-b132-44651e81234d	__csrf_token__	2021-06-05 18:20:11.892835	2021-06-05 18:20:11.892835
34	99506d6f-08ee-4b77-8f14-48d0c8358d48	__csrf_token__	2021-06-05 18:20:26.448818	2021-06-05 18:20:26.448818
35	745441eb-0e0a-42d3-a95c-de5213fd0fb9	__csrf_token__	2021-06-05 18:20:29.494296	2021-06-05 18:20:29.494296
36	9e2fddee-c1be-48bc-b736-87a18c2b947f	__csrf_token__	2021-06-05 18:20:39.495593	2021-06-05 18:20:39.495593
37	a42551fc-cc74-4e0c-904a-6b5a5670781c	__csrf_token__	2021-06-05 18:20:40.888322	2021-06-05 18:20:40.888322
39	e6fc94db-75c1-4729-aca6-5693d2b50b56	__csrf_token__	2021-06-05 18:20:49.542166	2021-06-05 18:20:49.542166
40	863d7952-9285-4143-886c-4c8a692e1f16	__csrf_token__	2021-06-05 18:20:53.655808	2021-06-05 18:20:53.655808
41	fb8a7e6e-074f-49bd-92f3-1a50026bae14	__csrf_token__	2021-06-05 18:22:41.764862	2021-06-05 18:22:41.764862
42	f2d0f0ff-7302-48b6-b19a-1a56cb2846f7	__csrf_token__	2021-06-05 18:22:46.069221	2021-06-05 18:22:46.069221
43	ccb7934a-8e2c-4b5a-b859-b815095bfd1e	__csrf_token__	2021-06-05 18:22:52.826394	2021-06-05 18:22:52.826394
44	2db4b548-434c-402a-bece-c4c2588a0a36	__csrf_token__	2021-06-05 18:22:56.890628	2021-06-05 18:22:56.890628
45	deffe0b0-c3eb-4ab8-aa9c-87c9db9680d0	__csrf_token__	2021-06-05 18:23:00.749951	2021-06-05 18:23:00.749951
46	2d073c13-7724-435f-b90f-1f1cc2ad75cd	__csrf_token__	2021-06-05 18:23:03.104289	2021-06-05 18:23:03.104289
47	9fa3b0b3-ae92-4d2f-927e-4301f3bf593f	__csrf_token__	2021-06-05 18:23:10.286769	2021-06-05 18:23:10.286769
49	98741170-4e89-4ca6-b29a-6bced5a10168	__csrf_token__	2021-06-05 18:23:35.889472	2021-06-05 18:23:35.889472
50	3fcd2685-3681-458d-8ad2-2153129b246a	__csrf_token__	2021-06-05 18:23:37.865561	2021-06-05 18:23:37.865561
51	2fb0c955-f339-4c71-a629-899692275269	__csrf_token__	2021-06-05 18:23:39.961845	2021-06-05 18:23:39.961845
53	2dd893c7-19f3-4d87-bd61-f9c505b53039	__csrf_token__	2021-06-05 18:31:15.653117	2021-06-05 18:31:15.653117
54	3c4e3203-e666-4184-a158-39b298867fd2	__csrf_token__	2021-06-05 18:32:21.38842	2021-06-05 18:32:21.38842
55	f18e0b9a-00d1-4500-9be6-dc8a37353df6	__csrf_token__	2021-06-05 18:32:24.690855	2021-06-05 18:32:24.690855
57	6efff252-af0a-4263-9baf-76f42d0a3342	__csrf_token__	2021-06-05 18:36:55.270214	2021-06-05 18:36:55.270214
58	3b3826f2-0453-430d-9972-9e00a49a6455	__csrf_token__	2021-06-05 18:36:57.265481	2021-06-05 18:36:57.265481
59	348dd7ac-c719-4866-9334-b38a026b78ff	__csrf_token__	2021-06-05 18:36:59.095576	2021-06-05 18:36:59.095576
60	ae511a1e-3cc0-4302-8076-406d4d0d5040	__csrf_token__	2021-06-05 19:27:18.014284	2021-06-05 19:27:18.014284
61	7d33fc7b-a032-4546-b4dd-714358ca86c7	__csrf_token__	2021-06-05 19:38:20.625512	2021-06-05 19:38:20.625512
62	1c6f202e-3dcb-478d-a37c-f1f202acfd53	__csrf_token__	2021-06-05 19:43:00.385736	2021-06-05 19:43:00.385736
63	de49073a-264f-483a-aaf2-b8fabe177352	__csrf_token__	2021-06-05 19:43:12.197673	2021-06-05 19:43:12.197673
64	612f1ac9-a036-4d6e-a495-e8a2e91821ae	__csrf_token__	2021-06-05 19:43:21.862919	2021-06-05 19:43:21.862919
65	4a1fba1d-41f3-41e1-89f8-47d28b599cf0	__csrf_token__	2021-06-05 19:43:35.437417	2021-06-05 19:43:35.437417
66	7b568d09-2abd-4a1f-bb14-fdc3e51e16a2	{"user_id":1}	2021-06-05 20:12:39.364251	2021-06-05 20:12:39.364251
67	4fba949e-4b8b-42e7-8775-ad60ef73b264	__csrf_token__	2021-06-05 20:12:39.381372	2021-06-05 20:12:39.381372
69	3d439fac-55e7-4ef5-ac27-d2b708f3f7e4	__csrf_token__	2021-06-05 20:52:41.170067	2021-06-05 20:52:41.170067
71	371c9d6a-eb39-4ca9-b76d-e7c7e1875804	__csrf_token__	2021-06-05 20:53:45.943204	2021-06-05 20:53:45.943204
72	abf15d9f-33e9-4d2f-b2d7-bd980ca85498	__csrf_token__	2021-06-05 20:54:36.288423	2021-06-05 20:54:36.288423
\.


--
-- Data for Name: goadmin_site; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.goadmin_site (id, key, value, type, description, state, created_at, updated_at) FROM stdin;
1	login_url	/login	0	\N	1	2021-06-05 15:56:32.049842	2021-06-05 15:56:32.049842
2	sql_log	false	0	\N	1	2021-06-05 15:56:32.055421	2021-06-05 15:56:32.055421
3	info_log_off	false	0	\N	1	2021-06-05 15:56:32.056327	2021-06-05 15:56:32.056327
4	asset_root_path	./public/	0	\N	1	2021-06-05 15:56:32.056952	2021-06-05 15:56:32.056952
5	access_log_off	false	0	\N	1	2021-06-05 15:56:32.057586	2021-06-05 15:56:32.057586
6	custom_500_html		0	\N	1	2021-06-05 15:56:32.05818	2021-06-05 15:56:32.05818
7	logger_rotate_max_size	0	0	\N	1	2021-06-05 15:56:32.058787	2021-06-05 15:56:32.058787
8	logger_encoder_level_key		0	\N	1	2021-06-05 15:56:32.059404	2021-06-05 15:56:32.059404
9	logger_encoder_stacktrace_key		0	\N	1	2021-06-05 15:56:32.059988	2021-06-05 15:56:32.059988
10	color_scheme		0	\N	1	2021-06-05 15:56:32.06056	2021-06-05 15:56:32.06056
11	env	local	0	\N	1	2021-06-05 15:56:32.061113	2021-06-05 15:56:32.061113
12	error_log_path	/home/phantom/public/work/cuckoo-admin/logs/error.log	0	\N	1	2021-06-05 15:56:32.061677	2021-06-05 15:56:32.061677
13	logger_encoder_caller		0	\N	1	2021-06-05 15:56:32.062254	2021-06-05 15:56:32.062254
14	auth_user_table	goadmin_users	0	\N	1	2021-06-05 15:56:32.062819	2021-06-05 15:56:32.062819
15	allow_del_operation_log	false	0	\N	1	2021-06-05 15:56:32.06338	2021-06-05 15:56:32.06338
16	logger_encoder_message_key		0	\N	1	2021-06-05 15:56:32.063951	2021-06-05 15:56:32.063951
17	logger_encoder_level		0	\N	1	2021-06-05 15:56:32.064515	2021-06-05 15:56:32.064515
18	logger_level	0	0	\N	1	2021-06-05 15:56:32.065074	2021-06-05 15:56:32.065074
19	hide_tool_entrance	false	0	\N	1	2021-06-05 15:56:32.065638	2021-06-05 15:56:32.065638
20	go_mod_file_path	/home/phantom/public/work/cuckoo-admin/go.mod	0	\N	1	2021-06-05 15:56:32.066196	2021-06-05 15:56:32.066196
21	hide_plugin_entrance	false	0	\N	1	2021-06-05 15:56:32.066745	2021-06-05 15:56:32.066745
22	language	cn	0	\N	1	2021-06-05 15:56:32.067308	2021-06-05 15:56:32.067308
23	access_log_path	/home/phantom/public/work/cuckoo-admin/logs/access.log	0	\N	1	2021-06-05 15:56:32.067881	2021-06-05 15:56:32.067881
24	logger_rotate_max_age	0	0	\N	1	2021-06-05 15:56:32.068439	2021-06-05 15:56:32.068439
25	logger_encoder_caller_key		0	\N	1	2021-06-05 15:56:32.068955	2021-06-05 15:56:32.068955
26	animation_duration	0.00	0	\N	1	2021-06-05 15:56:32.069519	2021-06-05 15:56:32.069519
27	mini_logo	CP	0	\N	1	2021-06-05 15:56:32.070075	2021-06-05 15:56:32.070075
28	custom_head_html		0	\N	1	2021-06-05 15:56:32.070638	2021-06-05 15:56:32.070638
29	login_logo	CuclooPayAdmin	0	\N	1	2021-06-05 15:56:32.071202	2021-06-05 15:56:32.071202
30	prohibit_config_modification	false	0	\N	1	2021-06-05 15:56:32.07177	2021-06-05 15:56:32.07177
31	bootstrap_file_path	/home/phantom/public/work/cuckoo-admin/bootstrap.go	0	\N	1	2021-06-05 15:56:32.072331	2021-06-05 15:56:32.072331
32	hide_app_info_entrance	false	0	\N	1	2021-06-05 15:56:32.072886	2021-06-05 15:56:32.072886
33	index_url	/	0	\N	1	2021-06-05 15:56:32.073454	2021-06-05 15:56:32.073454
34	asset_url		0	\N	1	2021-06-05 15:56:32.074012	2021-06-05 15:56:32.074012
35	open_admin_api	false	0	\N	1	2021-06-05 15:56:32.074581	2021-06-05 15:56:32.074581
36	session_life_time	7200	0	\N	1	2021-06-05 15:56:32.075142	2021-06-05 15:56:32.075142
37	file_upload_engine	{"name":"local"}	0	\N	1	2021-06-05 15:56:32.075707	2021-06-05 15:56:32.075707
38	site_off	false	0	\N	1	2021-06-05 15:56:32.076263	2021-06-05 15:56:32.076263
39	login_title	GoAdmin	0	\N	1	2021-06-05 15:56:32.076815	2021-06-05 15:56:32.076815
40	extra		0	\N	1	2021-06-05 15:56:32.077375	2021-06-05 15:56:32.077375
41	no_limit_login_ip	false	0	\N	1	2021-06-05 15:56:32.07788	2021-06-05 15:56:32.07788
42	url_prefix	admin	0	\N	1	2021-06-05 15:56:32.078433	2021-06-05 15:56:32.078433
43	debug	true	0	\N	1	2021-06-05 15:56:32.079002	2021-06-05 15:56:32.079002
44	logger_encoder_time		0	\N	1	2021-06-05 15:56:32.079564	2021-06-05 15:56:32.079564
45	logger_encoder_encoding		0	\N	1	2021-06-05 15:56:32.080124	2021-06-05 15:56:32.080124
46	footer_info		0	\N	1	2021-06-05 15:56:32.080686	2021-06-05 15:56:32.080686
47	title	CuclooPayAdmin	0	\N	1	2021-06-05 15:56:32.081255	2021-06-05 15:56:32.081255
48	info_log_path	/home/phantom/public/work/cuckoo-admin/logs/info.log	0	\N	1	2021-06-05 15:56:32.081816	2021-06-05 15:56:32.081816
49	custom_foot_html		0	\N	1	2021-06-05 15:56:32.082377	2021-06-05 15:56:32.082377
50	app_id	QKK1ulhoTCPn	0	\N	1	2021-06-05 15:56:32.08293	2021-06-05 15:56:32.08293
51	access_assets_log_off	false	0	\N	1	2021-06-05 15:56:32.083499	2021-06-05 15:56:32.083499
52	logger_rotate_compress	false	0	\N	1	2021-06-05 15:56:32.084057	2021-06-05 15:56:32.084057
53	animation_delay	0.00	0	\N	1	2021-06-05 15:56:32.084609	2021-06-05 15:56:32.084609
54	hide_visitor_user_center_entrance	false	0	\N	1	2021-06-05 15:56:32.08516	2021-06-05 15:56:32.08516
55	domain		0	\N	1	2021-06-05 15:56:32.085718	2021-06-05 15:56:32.085718
56	logo	CuclooPay	0	\N	1	2021-06-05 15:56:32.086279	2021-06-05 15:56:32.086279
57	custom_404_html		0	\N	1	2021-06-05 15:56:32.086792	2021-06-05 15:56:32.086792
58	custom_403_html		0	\N	1	2021-06-05 15:56:32.087348	2021-06-05 15:56:32.087348
59	logger_encoder_time_key		0	\N	1	2021-06-05 15:56:32.087909	2021-06-05 15:56:32.087909
60	animation_type		0	\N	1	2021-06-05 15:56:32.088466	2021-06-05 15:56:32.088466
61	hide_config_center_entrance	false	0	\N	1	2021-06-05 15:56:32.089028	2021-06-05 15:56:32.089028
62	exclude_theme_components	null	0	\N	1	2021-06-05 15:56:32.089638	2021-06-05 15:56:32.089638
63	operation_log_off	false	0	\N	1	2021-06-05 15:56:32.090203	2021-06-05 15:56:32.090203
64	theme	sword	0	\N	1	2021-06-05 15:56:32.09077	2021-06-05 15:56:32.09077
65	error_log_off	false	0	\N	1	2021-06-05 15:56:32.091329	2021-06-05 15:56:32.091329
66	logger_rotate_max_backups	0	0	\N	1	2021-06-05 15:56:32.091905	2021-06-05 15:56:32.091905
67	logger_encoder_name_key		0	\N	1	2021-06-05 15:56:32.092471	2021-06-05 15:56:32.092471
68	logger_encoder_duration		0	\N	1	2021-06-05 15:56:32.093038	2021-06-05 15:56:32.093038
\.


--
-- Data for Name: goadmin_user_permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.goadmin_user_permissions (user_id, permission_id, created_at, updated_at) FROM stdin;
1	1	2019-09-10 00:00:00	2019-09-10 00:00:00
2	2	2019-09-10 00:00:00	2019-09-10 00:00:00
0	1	\N	\N
0	1	\N	\N
0	1	\N	\N
0	1	\N	\N
0	1	\N	\N
0	1	\N	\N
0	1	\N	\N
0	1	\N	\N
0	1	\N	\N
0	1	\N	\N
0	1	\N	\N
0	1	\N	\N
0	1	\N	\N
0	1	\N	\N
0	1	\N	\N
0	1	\N	\N
\.


--
-- Data for Name: goadmin_users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.goadmin_users (id, username, password, name, avatar, remember_token, created_at, updated_at) FROM stdin;
2	operator	$2a$10$rVqkOzHjN2MdlEprRflb1eGP0oZXuSrbJLOmJagFsCd81YZm0bsh.	Operator		\N	2019-09-10 00:00:00	2019-09-10 00:00:00
1	admin	$2a$10$2Pw9WoVbpRBdFj4Q8Tz2AO2P4fQ8MEZboHcnC5Y4UZx4PaFy8PTUC	admin		tlNcBVK9AvfYH7WEnwB1RKvocJu8FfRy4um3DJtwdHuJy0dwFsLOgAc0xUfh	2019-09-10 00:00:00	2019-09-10 00:00:00
\.


--
-- Data for Name: sync_trons; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sync_trons (id, height) FROM stdin;
sync_id	30812297
\.


--
-- Data for Name: transfers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.transfers (id, created_at, updated_at, deleted_at, tx_id, block_height, "timestamp", "from", "to", tx_type, value, status, call_back, call_back_num, call_back_url, call_back_time) FROM stdin;
1	2021-06-05 18:50:45+08	2021-06-05 18:50:48+08	\N	e5fa5e080ac8882bb44f8968c159ac98eadb1f79eee4071e5172d636b20f2eec	30779003	1622796753000	TCiUAp1XsVBnB1CiTrydYNB14ztGvQcDvM	TTfra6CDr1bAZMCuttAjRQzvp5tN7ofnmP	USDT	0.3	1	t	59	http://127.0.0.1:9001/callback	1622896563
2	2021-06-05 18:50:45+08	2021-06-05 18:50:48+08	\N	e5fa5e080ac8882bb44f8968c159ac98eadb1f79eee4071e5172d636b20f2eec2	30779003	1622796753000	TCiUAp1XsVBnB1CiTrydYNB14ztGvQcDvM	TTfra6CDr1bAZMCuttAjRQzvp5tN7ofnmP	USDT	0.3	1	t	0	http://127.0.0.1:9001/callback	1622896817
3	2021-06-05 18:50:45+08	2021-06-05 18:50:48+08	\N	e5fa5e080ac8882bb44f8968c159ac98eadb1f79eee4071e5172d636b20f2eec3	30779003	1622796753000	TCiUAp1XsVBnB1CiTrydYNB14ztGvQcDvM	TTfra6CDr1bAZMCuttAjRQzvp5tN7ofnmP	USDT	0.3	1	f	0	<p>www.baidu.com</p>	\N
\.


--
-- Name: addresses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.addresses_id_seq', 1, false);


--
-- Name: collects_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.collects_id_seq', 1, false);


--
-- Name: goadmin_menu_myid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.goadmin_menu_myid_seq', 11, true);


--
-- Name: goadmin_operation_log_myid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.goadmin_operation_log_myid_seq', 391, true);


--
-- Name: goadmin_permissions_myid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.goadmin_permissions_myid_seq', 9, true);


--
-- Name: goadmin_roles_myid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.goadmin_roles_myid_seq', 2, true);


--
-- Name: goadmin_session_myid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.goadmin_session_myid_seq', 72, true);


--
-- Name: goadmin_site_myid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.goadmin_site_myid_seq', 1, true);


--
-- Name: goadmin_users_myid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.goadmin_users_myid_seq', 2, true);


--
-- Name: transfers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.transfers_id_seq', 1, false);


--
-- Name: addresses addresses_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.addresses
    ADD CONSTRAINT addresses_pkey PRIMARY KEY (id);


--
-- Name: collects collects_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.collects
    ADD CONSTRAINT collects_pkey PRIMARY KEY (id);


--
-- Name: goadmin_menu goadmin_menu_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.goadmin_menu
    ADD CONSTRAINT goadmin_menu_pkey PRIMARY KEY (id);


--
-- Name: goadmin_operation_log goadmin_operation_log_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.goadmin_operation_log
    ADD CONSTRAINT goadmin_operation_log_pkey PRIMARY KEY (id);


--
-- Name: goadmin_permissions goadmin_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.goadmin_permissions
    ADD CONSTRAINT goadmin_permissions_pkey PRIMARY KEY (id);


--
-- Name: goadmin_roles goadmin_roles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.goadmin_roles
    ADD CONSTRAINT goadmin_roles_pkey PRIMARY KEY (id);


--
-- Name: goadmin_session goadmin_session_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.goadmin_session
    ADD CONSTRAINT goadmin_session_pkey PRIMARY KEY (id);


--
-- Name: goadmin_site goadmin_site_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.goadmin_site
    ADD CONSTRAINT goadmin_site_pkey PRIMARY KEY (id);


--
-- Name: goadmin_users goadmin_users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.goadmin_users
    ADD CONSTRAINT goadmin_users_pkey PRIMARY KEY (id);


--
-- Name: sync_trons sync_trons_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sync_trons
    ADD CONSTRAINT sync_trons_pkey PRIMARY KEY (id);


--
-- Name: transfers transfers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transfers
    ADD CONSTRAINT transfers_pkey PRIMARY KEY (id);


--
-- Name: idx_addresses_deleted_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_addresses_deleted_at ON public.addresses USING btree (deleted_at);


--
-- Name: idx_collects_deleted_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_collects_deleted_at ON public.collects USING btree (deleted_at);


--
-- Name: idx_transfers_deleted_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_transfers_deleted_at ON public.transfers USING btree (deleted_at);


--
-- Name: idx_transfers_tx_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_transfers_tx_id ON public.transfers USING btree (tx_id);


--
-- PostgreSQL database dump complete
--

