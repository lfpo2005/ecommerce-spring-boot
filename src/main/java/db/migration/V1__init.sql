--
-- PostgreSQL database dump
--

-- Dumped from database version 11.17
-- Dumped by pg_dump version 11.17

-- Started on 2022-10-12 22:49:52

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = ''UTF8'';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config(''search_path'', '''', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 3111 (class 1262 OID 25828)
-- Name: ecommerce-test; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE "ecommerce-test" WITH TEMPLATE = template0 ENCODING = ''UTF8'' LC_COLLATE = ''Portuguese_Brazil.1252'' LC_CTYPE = ''Portuguese_Brazil.1252'';


ALTER DATABASE "ecommerce-test" OWNER TO postgres;

\connect -reuse-previous=on "dbname=''ecommerce-test''"

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = ''UTF8'';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config(''search_path'', '''', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 256 (class 1255 OID 26110)
-- Name: validatepersonkey(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.validatepersonkey() RETURNS trigger
    LANGUAGE plpgsql
AS
$$
declare
    exist integer;

begin
    exist = (select count(1) from pessoa_fisica where id = NEW.person_id);
    if (exist <= 0) then
        exist = (select count(1) from pessoa_juridica where id = NEW.person_id);
        if (exist <= 0) then
            raise exception ''The Id or PK of the person to perform the association was not found!'';
        end if;
    end if;
    return new;
end ;
$$;


ALTER FUNCTION public.validatepersonkey() OWNER TO postgres;

SET default_tablespace = '''';

SET default_with_oids = false;

--
-- TOC entry 216 (class 1259 OID 37363)
-- Name: acesso; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.acesso
(
    id        bigint                 NOT NULL,
    descricao character varying(255) NOT NULL
);


ALTER TABLE public.acesso
    OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 37368)
-- Name: avaliacao_produto; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.avaliacao_produto
(
    id         bigint                 NOT NULL,
    descricao  character varying(255) NOT NULL,
    nota       integer                NOT NULL,
    pessoa_id  bigint                 NOT NULL,
    produto_id bigint                 NOT NULL
);


ALTER TABLE public.avaliacao_produto
    OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 37373)
-- Name: categoria_produto; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.categoria_produto
(
    id        bigint                NOT NULL,
    nome_desc character varying(25) NOT NULL
);


ALTER TABLE public.categoria_produto
    OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 37378)
-- Name: conta_pagar; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.conta_pagar
(
    id             bigint                 NOT NULL,
    descricao      character varying(255) NOT NULL,
    dt_pagamento   date,
    dt_vencimento  date                   NOT NULL,
    status         character varying(255) NOT NULL,
    valor_desconto numeric(19, 2),
    valor_total    numeric(19, 2)         NOT NULL,
    pessoa_id      bigint                 NOT NULL,
    pessoa_forn_id bigint                 NOT NULL
);


ALTER TABLE public.conta_pagar
    OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 37386)
-- Name: conta_receber; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.conta_receber
(
    id             bigint                 NOT NULL,
    descricao      character varying(255) NOT NULL,
    dt_pagamento   date,
    dt_vencimento  date                   NOT NULL,
    status         character varying(255) NOT NULL,
    valor_desconto numeric(19, 2),
    valor_total    numeric(19, 2)         NOT NULL,
    pessoa_id      bigint                 NOT NULL
);


ALTER TABLE public.conta_receber
    OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 37394)
-- Name: cup_desc; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cup_desc
(
    id                  bigint                 NOT NULL,
    cod_desc            character varying(255) NOT NULL,
    data_validade_cupom date                   NOT NULL,
    valor_porcent_desc  numeric(19, 2),
    valor_real_desc     numeric(19, 2)
);


ALTER TABLE public.cup_desc
    OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 37399)
-- Name: endereco; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.endereco
(
    id            bigint                 NOT NULL,
    bairro        character varying(30)  NOT NULL,
    cep           character varying(15)  NOT NULL,
    cidade        character varying(50)  NOT NULL,
    complemento   character varying(50),
    numero        character varying(10)  NOT NULL,
    rua_logra     character varying(60)  NOT NULL,
    tipo_endereco character varying(255) NOT NULL,
    uf            character varying(30)  NOT NULL,
    pessoa_id     bigint                 NOT NULL
);


ALTER TABLE public.endereco
    OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 37407)
-- Name: forma_pagamento; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.forma_pagamento
(
    id        bigint                NOT NULL,
    descricao character varying(15) NOT NULL
);


ALTER TABLE public.forma_pagamento
    OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 37412)
-- Name: imagem_produto; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.imagem_produto
(
    id               bigint NOT NULL,
    imagem_miniatura text   NOT NULL,
    imagem_original  text   NOT NULL,
    produto_id       bigint NOT NULL
);


ALTER TABLE public.imagem_produto
    OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 37420)
-- Name: item_venda_loja; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.item_venda_loja
(
    id                         bigint           NOT NULL,
    quantidade                 double precision NOT NULL,
    produto_id                 bigint           NOT NULL,
    venda_compra_loja_virtu_id bigint           NOT NULL
);


ALTER TABLE public.item_venda_loja
    OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 37425)
-- Name: marca_produto; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.marca_produto
(
    id        bigint                NOT NULL,
    nome_desc character varying(10) NOT NULL
);


ALTER TABLE public.marca_produto
    OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 37430)
-- Name: nota_fiscal_compra; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.nota_fiscal_compra
(
    id             bigint                 NOT NULL,
    data_compra    date                   NOT NULL,
    descricao_obs  character varying(255),
    numero_nota    character varying(255) NOT NULL,
    serie_nota     character varying(10)  NOT NULL,
    valor_desconto numeric(19, 2),
    valor_icms     numeric(19, 2)         NOT NULL,
    valor_total    numeric(19, 2)         NOT NULL,
    conta_pagar_id bigint                 NOT NULL,
    pessoa_id      bigint                 NOT NULL
);


ALTER TABLE public.nota_fiscal_compra
    OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 37438)
-- Name: nota_fiscal_venda; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.nota_fiscal_venda
(
    id                        bigint                 NOT NULL,
    numero                    character varying(255) NOT NULL,
    pdf                       text                   NOT NULL,
    serie                     character varying(10)  NOT NULL,
    tipo                      character varying(255) NOT NULL,
    xml                       text                   NOT NULL,
    venda_compra_loja_virt_id bigint                 NOT NULL
);


ALTER TABLE public.nota_fiscal_venda
    OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 37446)
-- Name: nota_item_produto; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.nota_item_produto
(
    id                    bigint           NOT NULL,
    quantidade            double precision NOT NULL,
    nota_fiscal_compra_id bigint           NOT NULL,
    produto_id            bigint           NOT NULL
);


ALTER TABLE public.nota_item_produto
    OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 37451)
-- Name: pessoa_fisica; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pessoa_fisica
(
    id              bigint                 NOT NULL,
    email           character varying(255) NOT NULL,
    nome            character varying(150) NOT NULL,
    telefone        character varying(25)  NOT NULL,
    tipo_pessoa     character varying(15),
    cpf             character varying(255) NOT NULL,
    data_nascimento date,
    sexo            character varying(255) NOT NULL
);


ALTER TABLE public.pessoa_fisica
    OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 37459)
-- Name: pessoa_juridica; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pessoa_juridica
(
    id             bigint                 NOT NULL,
    email          character varying(255) NOT NULL,
    nome           character varying(150) NOT NULL,
    telefone       character varying(25)  NOT NULL,
    tipo_pessoa    character varying(15),
    cnpj           character varying(30)  NOT NULL,
    insc_estadual  character varying(30)  NOT NULL,
    insc_municipal character varying(30),
    nome_fantasia  character varying(150) NOT NULL,
    razao_social   character varying(255) NOT NULL
);


ALTER TABLE public.pessoa_juridica
    OWNER TO postgres;

--
-- TOC entry 232 (class 1259 OID 37467)
-- Name: produto; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.produto
(
    id                  bigint                NOT NULL,
    qtd_estoque         integer               NOT NULL,
    qtde_alerta_estoque integer,
    alerta_qtde_estoque boolean,
    altura              double precision      NOT NULL,
    ativo               boolean               NOT NULL,
    descricao           text                  NOT NULL,
    largura             double precision      NOT NULL,
    link_youtube        character varying(255),
    nome                character varying(60) NOT NULL,
    peso                double precision      NOT NULL,
    profundidade        double precision      NOT NULL,
    qtde_clique         integer,
    tipo_unidade        character varying(20) NOT NULL,
    valor_venda         numeric(19, 2)        NOT NULL
);


ALTER TABLE public.produto
    OWNER TO postgres;

--
-- TOC entry 196 (class 1259 OID 25973)
-- Name: seq_access; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_access
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_access
    OWNER TO postgres;

--
-- TOC entry 197 (class 1259 OID 25975)
-- Name: seq_account_pay; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_account_pay
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_account_pay
    OWNER TO postgres;

--
-- TOC entry 198 (class 1259 OID 25977)
-- Name: seq_account_receiver; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_account_receiver
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_account_receiver
    OWNER TO postgres;

--
-- TOC entry 237 (class 1259 OID 37497)
-- Name: seq_acesso; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_acesso
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_acesso
    OWNER TO postgres;

--
-- TOC entry 199 (class 1259 OID 25979)
-- Name: seq_address; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_address
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_address
    OWNER TO postgres;

--
-- TOC entry 238 (class 1259 OID 37499)
-- Name: seq_avaliacao_produto; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_avaliacao_produto
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_avaliacao_produto
    OWNER TO postgres;

--
-- TOC entry 200 (class 1259 OID 25981)
-- Name: seq_brand_product; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_brand_product
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_brand_product
    OWNER TO postgres;

--
-- TOC entry 239 (class 1259 OID 37501)
-- Name: seq_categoria_produto; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_categoria_produto
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_categoria_produto
    OWNER TO postgres;

--
-- TOC entry 201 (class 1259 OID 25983)
-- Name: seq_category_product; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_category_product
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_category_product
    OWNER TO postgres;

--
-- TOC entry 240 (class 1259 OID 37503)
-- Name: seq_conta_pagar; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_conta_pagar
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_conta_pagar
    OWNER TO postgres;

--
-- TOC entry 241 (class 1259 OID 37505)
-- Name: seq_conta_receber; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_conta_receber
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_conta_receber
    OWNER TO postgres;

--
-- TOC entry 242 (class 1259 OID 37507)
-- Name: seq_cup_desc; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_cup_desc
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_cup_desc
    OWNER TO postgres;

--
-- TOC entry 202 (class 1259 OID 25985)
-- Name: seq_discount_coupon; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_discount_coupon
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_discount_coupon
    OWNER TO postgres;

--
-- TOC entry 243 (class 1259 OID 37509)
-- Name: seq_endereco; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_endereco
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_endereco
    OWNER TO postgres;

--
-- TOC entry 203 (class 1259 OID 25987)
-- Name: seq_form_payment; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_form_payment
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_form_payment
    OWNER TO postgres;

--
-- TOC entry 244 (class 1259 OID 37511)
-- Name: seq_forma_pagamento; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_forma_pagamento
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_forma_pagamento
    OWNER TO postgres;

--
-- TOC entry 204 (class 1259 OID 25989)
-- Name: seq_image_product; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_image_product
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_image_product
    OWNER TO postgres;

--
-- TOC entry 245 (class 1259 OID 37513)
-- Name: seq_imagem_produto; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_imagem_produto
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_imagem_produto
    OWNER TO postgres;

--
-- TOC entry 205 (class 1259 OID 25991)
-- Name: seq_invoice_product; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_invoice_product
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_invoice_product
    OWNER TO postgres;

--
-- TOC entry 206 (class 1259 OID 25993)
-- Name: seq_item_sales_store; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_item_sales_store
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_item_sales_store
    OWNER TO postgres;

--
-- TOC entry 246 (class 1259 OID 37515)
-- Name: seq_item_venda_loja; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_item_venda_loja
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_item_venda_loja
    OWNER TO postgres;

--
-- TOC entry 247 (class 1259 OID 37517)
-- Name: seq_marca_produto; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_marca_produto
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_marca_produto
    OWNER TO postgres;

--
-- TOC entry 248 (class 1259 OID 37519)
-- Name: seq_nota_fiscal_compra; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_nota_fiscal_compra
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_nota_fiscal_compra
    OWNER TO postgres;

--
-- TOC entry 249 (class 1259 OID 37521)
-- Name: seq_nota_fiscal_venda; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_nota_fiscal_venda
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_nota_fiscal_venda
    OWNER TO postgres;

--
-- TOC entry 250 (class 1259 OID 37523)
-- Name: seq_nota_item_produto; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_nota_item_produto
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_nota_item_produto
    OWNER TO postgres;

--
-- TOC entry 207 (class 1259 OID 25995)
-- Name: seq_person; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_person
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_person
    OWNER TO postgres;

--
-- TOC entry 251 (class 1259 OID 37525)
-- Name: seq_pessoa; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_pessoa
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_pessoa
    OWNER TO postgres;

--
-- TOC entry 208 (class 1259 OID 25997)
-- Name: seq_phone_number; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_phone_number
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_phone_number
    OWNER TO postgres;

--
-- TOC entry 209 (class 1259 OID 25999)
-- Name: seq_product; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_product
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_product
    OWNER TO postgres;

--
-- TOC entry 210 (class 1259 OID 26001)
-- Name: seq_product_review; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_product_review
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_product_review
    OWNER TO postgres;

--
-- TOC entry 252 (class 1259 OID 37527)
-- Name: seq_produto; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_produto
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_produto
    OWNER TO postgres;

--
-- TOC entry 211 (class 1259 OID 26003)
-- Name: seq_purchase_invoice; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_purchase_invoice
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_purchase_invoice
    OWNER TO postgres;

--
-- TOC entry 212 (class 1259 OID 26005)
-- Name: seq_sale_purchase_virtual_store; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_sale_purchase_virtual_store
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_sale_purchase_virtual_store
    OWNER TO postgres;

--
-- TOC entry 213 (class 1259 OID 26007)
-- Name: seq_sales_invoice; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_sales_invoice
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_sales_invoice
    OWNER TO postgres;

--
-- TOC entry 253 (class 1259 OID 37529)
-- Name: seq_status_rastreio; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_status_rastreio
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_status_rastreio
    OWNER TO postgres;

--
-- TOC entry 214 (class 1259 OID 26009)
-- Name: seq_status_tracking; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_status_tracking
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_status_tracking
    OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 26011)
-- Name: seq_user; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_user
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_user
    OWNER TO postgres;

--
-- TOC entry 254 (class 1259 OID 37531)
-- Name: seq_usuario; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_usuario
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_usuario
    OWNER TO postgres;

--
-- TOC entry 255 (class 1259 OID 37533)
-- Name: seq_vd_cp_loja_virt; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_vd_cp_loja_virt
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_vd_cp_loja_virt
    OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 37475)
-- Name: status_rastreio; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.status_rastreio
(
    id                        bigint NOT NULL,
    centro_distribuicao       character varying(150),
    cidade                    character varying(150),
    estado                    character varying(15),
    status                    character varying(30),
    venda_compra_loja_virt_id bigint NOT NULL
);


ALTER TABLE public.status_rastreio
    OWNER TO postgres;

--
-- TOC entry 234 (class 1259 OID 37480)
-- Name: usuario; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.usuario
(
    id               bigint                 NOT NULL,
    data_atual_senha date                   NOT NULL,
    login            character varying(15)  NOT NULL,
    senha            character varying(255) NOT NULL,
    pessoa_id        bigint                 NOT NULL
);


ALTER TABLE public.usuario
    OWNER TO postgres;

--
-- TOC entry 235 (class 1259 OID 37485)
-- Name: usuarios_acesso; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.usuarios_acesso
(
    usuario_id bigint NOT NULL,
    acesso_id  bigint NOT NULL
);


ALTER TABLE public.usuarios_acesso
    OWNER TO postgres;

--
-- TOC entry 236 (class 1259 OID 37488)
-- Name: vd_cp_loja_virt; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.vd_cp_loja_virt
(
    id                   bigint         NOT NULL,
    data_entrega         date           NOT NULL,
    data_venda           date           NOT NULL,
    dia_entrega          integer        NOT NULL,
    valor_desconto       numeric(19, 2),
    valor_fret           numeric(19, 2) NOT NULL,
    valor_total          numeric(19, 2) NOT NULL,
    cupom_desc_id        bigint,
    endereco_cobranca_id bigint         NOT NULL,
    endereco_entrega_id  bigint         NOT NULL,
    forma_pagamento_id   bigint         NOT NULL,
    nota_fiscal_venda_id bigint         NOT NULL,
    pessoa_id            bigint         NOT NULL
);


ALTER TABLE public.vd_cp_loja_virt
    OWNER TO postgres;

--
-- TOC entry 3066 (class 0 OID 37363)
-- Dependencies: 216
-- Data for Name: acesso; Type: TABLE DATA; Schema: public; Owner: postgres
--


--
-- TOC entry 3067 (class 0 OID 37368)
-- Dependencies: 217
-- Data for Name: avaliacao_produto; Type: TABLE DATA; Schema: public; Owner: postgres
--


--
-- TOC entry 3068 (class 0 OID 37373)
-- Dependencies: 218
-- Data for Name: categoria_produto; Type: TABLE DATA; Schema: public; Owner: postgres
--


--
-- TOC entry 3069 (class 0 OID 37378)
-- Dependencies: 219
-- Data for Name: conta_pagar; Type: TABLE DATA; Schema: public; Owner: postgres
--


--
-- TOC entry 3070 (class 0 OID 37386)
-- Dependencies: 220
-- Data for Name: conta_receber; Type: TABLE DATA; Schema: public; Owner: postgres
--


--
-- TOC entry 3071 (class 0 OID 37394)
-- Dependencies: 221
-- Data for Name: cup_desc; Type: TABLE DATA; Schema: public; Owner: postgres
--


--
-- TOC entry 3072 (class 0 OID 37399)
-- Dependencies: 222
-- Data for Name: endereco; Type: TABLE DATA; Schema: public; Owner: postgres
--


--
-- TOC entry 3073 (class 0 OID 37407)
-- Dependencies: 223
-- Data for Name: forma_pagamento; Type: TABLE DATA; Schema: public; Owner: postgres
--


--
-- TOC entry 3074 (class 0 OID 37412)
-- Dependencies: 224
-- Data for Name: imagem_produto; Type: TABLE DATA; Schema: public; Owner: postgres
--


--
-- TOC entry 3075 (class 0 OID 37420)
-- Dependencies: 225
-- Data for Name: item_venda_loja; Type: TABLE DATA; Schema: public; Owner: postgres
--


--
-- TOC entry 3076 (class 0 OID 37425)
-- Dependencies: 226
-- Data for Name: marca_produto; Type: TABLE DATA; Schema: public; Owner: postgres
--


--
-- TOC entry 3077 (class 0 OID 37430)
-- Dependencies: 227
-- Data for Name: nota_fiscal_compra; Type: TABLE DATA; Schema: public; Owner: postgres
--


--
-- TOC entry 3078 (class 0 OID 37438)
-- Dependencies: 228
-- Data for Name: nota_fiscal_venda; Type: TABLE DATA; Schema: public; Owner: postgres
--


--
-- TOC entry 3079 (class 0 OID 37446)
-- Dependencies: 229
-- Data for Name: nota_item_produto; Type: TABLE DATA; Schema: public; Owner: postgres
--


--
-- TOC entry 3080 (class 0 OID 37451)
-- Dependencies: 230
-- Data for Name: pessoa_fisica; Type: TABLE DATA; Schema: public; Owner: postgres
--


--
-- TOC entry 3081 (class 0 OID 37459)
-- Dependencies: 231
-- Data for Name: pessoa_juridica; Type: TABLE DATA; Schema: public; Owner: postgres
--


--
-- TOC entry 3082 (class 0 OID 37467)
-- Dependencies: 232
-- Data for Name: produto; Type: TABLE DATA; Schema: public; Owner: postgres
--


--
-- TOC entry 3083 (class 0 OID 37475)
-- Dependencies: 233
-- Data for Name: status_rastreio; Type: TABLE DATA; Schema: public; Owner: postgres
--


--
-- TOC entry 3084 (class 0 OID 37480)
-- Dependencies: 234
-- Data for Name: usuario; Type: TABLE DATA; Schema: public; Owner: postgres
--


--
-- TOC entry 3085 (class 0 OID 37485)
-- Dependencies: 235
-- Data for Name: usuarios_acesso; Type: TABLE DATA; Schema: public; Owner: postgres
--


--
-- TOC entry 3086 (class 0 OID 37488)
-- Dependencies: 236
-- Data for Name: vd_cp_loja_virt; Type: TABLE DATA; Schema: public; Owner: postgres
--


--
-- TOC entry 3112 (class 0 OID 0)
-- Dependencies: 196
-- Name: seq_access; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval(''public.seq_access'', 10, true);


--
-- TOC entry 3113 (class 0 OID 0)
-- Dependencies: 197
-- Name: seq_account_pay; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval(''public.seq_account_pay'', 1, false);


--
-- TOC entry 3114 (class 0 OID 0)
-- Dependencies: 198
-- Name: seq_account_receiver; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval(''public.seq_account_receiver'', 1, false);


--
-- TOC entry 3115 (class 0 OID 0)
-- Dependencies: 237
-- Name: seq_acesso; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval(''public.seq_acesso'', 1, false);


--
-- TOC entry 3116 (class 0 OID 0)
-- Dependencies: 199
-- Name: seq_address; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval(''public.seq_address'', 1, false);


--
-- TOC entry 3117 (class 0 OID 0)
-- Dependencies: 238
-- Name: seq_avaliacao_produto; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval(''public.seq_avaliacao_produto'', 1, false);


--
-- TOC entry 3118 (class 0 OID 0)
-- Dependencies: 200
-- Name: seq_brand_product; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval(''public.seq_brand_product'', 1, false);


--
-- TOC entry 3119 (class 0 OID 0)
-- Dependencies: 239
-- Name: seq_categoria_produto; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval(''public.seq_categoria_produto'', 1, false);


--
-- TOC entry 3120 (class 0 OID 0)
-- Dependencies: 201
-- Name: seq_category_product; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval(''public.seq_category_product'', 1, false);


--
-- TOC entry 3121 (class 0 OID 0)
-- Dependencies: 240
-- Name: seq_conta_pagar; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval(''public.seq_conta_pagar'', 1, false);


--
-- TOC entry 3122 (class 0 OID 0)
-- Dependencies: 241
-- Name: seq_conta_receber; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval(''public.seq_conta_receber'', 1, false);


--
-- TOC entry 3123 (class 0 OID 0)
-- Dependencies: 242
-- Name: seq_cup_desc; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval(''public.seq_cup_desc'', 1, false);


--
-- TOC entry 3124 (class 0 OID 0)
-- Dependencies: 202
-- Name: seq_discount_coupon; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval(''public.seq_discount_coupon'', 1, false);


--
-- TOC entry 3125 (class 0 OID 0)
-- Dependencies: 243
-- Name: seq_endereco; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval(''public.seq_endereco'', 1, false);


--
-- TOC entry 3126 (class 0 OID 0)
-- Dependencies: 203
-- Name: seq_form_payment; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval(''public.seq_form_payment'', 1, false);


--
-- TOC entry 3127 (class 0 OID 0)
-- Dependencies: 244
-- Name: seq_forma_pagamento; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval(''public.seq_forma_pagamento'', 1, false);


--
-- TOC entry 3128 (class 0 OID 0)
-- Dependencies: 204
-- Name: seq_image_product; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval(''public.seq_image_product'', 1, false);


--
-- TOC entry 3129 (class 0 OID 0)
-- Dependencies: 245
-- Name: seq_imagem_produto; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval(''public.seq_imagem_produto'', 1, false);


--
-- TOC entry 3130 (class 0 OID 0)
-- Dependencies: 205
-- Name: seq_invoice_product; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval(''public.seq_invoice_product'', 1, false);


--
-- TOC entry 3131 (class 0 OID 0)
-- Dependencies: 206
-- Name: seq_item_sales_store; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval(''public.seq_item_sales_store'', 1, false);


--
-- TOC entry 3132 (class 0 OID 0)
-- Dependencies: 246
-- Name: seq_item_venda_loja; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval(''public.seq_item_venda_loja'', 1, false);


--
-- TOC entry 3133 (class 0 OID 0)
-- Dependencies: 247
-- Name: seq_marca_produto; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval(''public.seq_marca_produto'', 1, false);


--
-- TOC entry 3134 (class 0 OID 0)
-- Dependencies: 248
-- Name: seq_nota_fiscal_compra; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval(''public.seq_nota_fiscal_compra'', 1, false);


--
-- TOC entry 3135 (class 0 OID 0)
-- Dependencies: 249
-- Name: seq_nota_fiscal_venda; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval(''public.seq_nota_fiscal_venda'', 1, false);


--
-- TOC entry 3136 (class 0 OID 0)
-- Dependencies: 250
-- Name: seq_nota_item_produto; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval(''public.seq_nota_item_produto'', 1, false);


--
-- TOC entry 3137 (class 0 OID 0)
-- Dependencies: 207
-- Name: seq_person; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval(''public.seq_person'', 1, false);


--
-- TOC entry 3138 (class 0 OID 0)
-- Dependencies: 251
-- Name: seq_pessoa; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval(''public.seq_pessoa'', 1, false);


--
-- TOC entry 3139 (class 0 OID 0)
-- Dependencies: 208
-- Name: seq_phone_number; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval(''public.seq_phone_number'', 1, false);


--
-- TOC entry 3140 (class 0 OID 0)
-- Dependencies: 209
-- Name: seq_product; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval(''public.seq_product'', 1, false);


--
-- TOC entry 3141 (class 0 OID 0)
-- Dependencies: 210
-- Name: seq_product_review; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval(''public.seq_product_review'', 1, false);


--
-- TOC entry 3142 (class 0 OID 0)
-- Dependencies: 252
-- Name: seq_produto; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval(''public.seq_produto'', 1, false);


--
-- TOC entry 3143 (class 0 OID 0)
-- Dependencies: 211
-- Name: seq_purchase_invoice; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval(''public.seq_purchase_invoice'', 1, false);


--
-- TOC entry 3144 (class 0 OID 0)
-- Dependencies: 212
-- Name: seq_sale_purchase_virtual_store; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval(''public.seq_sale_purchase_virtual_store'', 1, false);


--
-- TOC entry 3145 (class 0 OID 0)
-- Dependencies: 213
-- Name: seq_sales_invoice; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval(''public.seq_sales_invoice'', 1, false);


--
-- TOC entry 3146 (class 0 OID 0)
-- Dependencies: 253
-- Name: seq_status_rastreio; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval(''public.seq_status_rastreio'', 1, false);


--
-- TOC entry 3147 (class 0 OID 0)
-- Dependencies: 214
-- Name: seq_status_tracking; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval(''public.seq_status_tracking'', 1, false);


--
-- TOC entry 3148 (class 0 OID 0)
-- Dependencies: 215
-- Name: seq_user; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval(''public.seq_user'', 1, false);


--
-- TOC entry 3149 (class 0 OID 0)
-- Dependencies: 254
-- Name: seq_usuario; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval(''public.seq_usuario'', 1, false);


--
-- TOC entry 3150 (class 0 OID 0)
-- Dependencies: 255
-- Name: seq_vd_cp_loja_virt; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval(''public.seq_vd_cp_loja_virt'', 1, false);


--
-- TOC entry 2852 (class 2606 OID 37367)
-- Name: acesso acesso_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.acesso
    ADD CONSTRAINT acesso_pkey PRIMARY KEY (id);


--
-- TOC entry 2854 (class 2606 OID 37372)
-- Name: avaliacao_produto avaliacao_produto_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.avaliacao_produto
    ADD CONSTRAINT avaliacao_produto_pkey PRIMARY KEY (id);


--
-- TOC entry 2856 (class 2606 OID 37377)
-- Name: categoria_produto categoria_produto_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categoria_produto
    ADD CONSTRAINT categoria_produto_pkey PRIMARY KEY (id);


--
-- TOC entry 2858 (class 2606 OID 37385)
-- Name: conta_pagar conta_pagar_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.conta_pagar
    ADD CONSTRAINT conta_pagar_pkey PRIMARY KEY (id);


--
-- TOC entry 2860 (class 2606 OID 37393)
-- Name: conta_receber conta_receber_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.conta_receber
    ADD CONSTRAINT conta_receber_pkey PRIMARY KEY (id);


--
-- TOC entry 2862 (class 2606 OID 37398)
-- Name: cup_desc cup_desc_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cup_desc
    ADD CONSTRAINT cup_desc_pkey PRIMARY KEY (id);


--
-- TOC entry 2864 (class 2606 OID 37406)
-- Name: endereco endereco_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.endereco
    ADD CONSTRAINT endereco_pkey PRIMARY KEY (id);


--
-- TOC entry 2866 (class 2606 OID 37411)
-- Name: forma_pagamento forma_pagamento_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.forma_pagamento
    ADD CONSTRAINT forma_pagamento_pkey PRIMARY KEY (id);


--
-- TOC entry 2868 (class 2606 OID 37419)
-- Name: imagem_produto imagem_produto_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.imagem_produto
    ADD CONSTRAINT imagem_produto_pkey PRIMARY KEY (id);


--
-- TOC entry 2870 (class 2606 OID 37424)
-- Name: item_venda_loja item_venda_loja_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.item_venda_loja
    ADD CONSTRAINT item_venda_loja_pkey PRIMARY KEY (id);


--
-- TOC entry 2872 (class 2606 OID 37429)
-- Name: marca_produto marca_produto_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.marca_produto
    ADD CONSTRAINT marca_produto_pkey PRIMARY KEY (id);


--
-- TOC entry 2874 (class 2606 OID 37437)
-- Name: nota_fiscal_compra nota_fiscal_compra_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nota_fiscal_compra
    ADD CONSTRAINT nota_fiscal_compra_pkey PRIMARY KEY (id);


--
-- TOC entry 2876 (class 2606 OID 37445)
-- Name: nota_fiscal_venda nota_fiscal_venda_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nota_fiscal_venda
    ADD CONSTRAINT nota_fiscal_venda_pkey PRIMARY KEY (id);


--
-- TOC entry 2878 (class 2606 OID 37450)
-- Name: nota_item_produto nota_item_produto_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nota_item_produto
    ADD CONSTRAINT nota_item_produto_pkey PRIMARY KEY (id);


--
-- TOC entry 2880 (class 2606 OID 37458)
-- Name: pessoa_fisica pessoa_fisica_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pessoa_fisica
    ADD CONSTRAINT pessoa_fisica_pkey PRIMARY KEY (id);


--
-- TOC entry 2882 (class 2606 OID 37466)
-- Name: pessoa_juridica pessoa_juridica_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pessoa_juridica
    ADD CONSTRAINT pessoa_juridica_pkey PRIMARY KEY (id);


--
-- TOC entry 2884 (class 2606 OID 37474)
-- Name: produto produto_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.produto
    ADD CONSTRAINT produto_pkey PRIMARY KEY (id);


--
-- TOC entry 2886 (class 2606 OID 37479)
-- Name: status_rastreio status_rastreio_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.status_rastreio
    ADD CONSTRAINT status_rastreio_pkey PRIMARY KEY (id);


--
-- TOC entry 2890 (class 2606 OID 37494)
-- Name: usuarios_acesso uk_8bak9jswon2id2jbunuqlfl9e; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios_acesso
    ADD CONSTRAINT uk_8bak9jswon2id2jbunuqlfl9e UNIQUE (acesso_id);


--
-- TOC entry 2892 (class 2606 OID 37496)
-- Name: usuarios_acesso unique_acesso_user; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios_acesso
    ADD CONSTRAINT unique_acesso_user UNIQUE (usuario_id, acesso_id);


--
-- TOC entry 2888 (class 2606 OID 37484)
-- Name: usuario usuario_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_pkey PRIMARY KEY (id);


--
-- TOC entry 2894 (class 2606 OID 37492)
-- Name: vd_cp_loja_virt vd_cp_loja_virt_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vd_cp_loja_virt
    ADD CONSTRAINT vd_cp_loja_virt_pkey PRIMARY KEY (id);


--
-- TOC entry 2912 (class 2620 OID 37617)
-- Name: avaliacao_produto validatepersonkeyin; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER validatepersonkeyin
    BEFORE INSERT
    ON public.avaliacao_produto
    FOR EACH ROW
EXECUTE PROCEDURE public.validatepersonkey();


--
-- TOC entry 2914 (class 2620 OID 37619)
-- Name: conta_pagar validatepersonkeyin; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER validatepersonkeyin
    BEFORE INSERT
    ON public.conta_pagar
    FOR EACH ROW
EXECUTE PROCEDURE public.validatepersonkey();


--
-- TOC entry 2916 (class 2620 OID 37621)
-- Name: conta_receber validatepersonkeyin; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER validatepersonkeyin
    BEFORE INSERT
    ON public.conta_receber
    FOR EACH ROW
EXECUTE PROCEDURE public.validatepersonkey();


--
-- TOC entry 2918 (class 2620 OID 37623)
-- Name: endereco validatepersonkeyin; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER validatepersonkeyin
    BEFORE INSERT
    ON public.endereco
    FOR EACH ROW
EXECUTE PROCEDURE public.validatepersonkey();


--
-- TOC entry 2920 (class 2620 OID 37625)
-- Name: nota_fiscal_compra validatepersonkeyin; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER validatepersonkeyin
    BEFORE INSERT
    ON public.nota_fiscal_compra
    FOR EACH ROW
EXECUTE PROCEDURE public.validatepersonkey();


--
-- TOC entry 2922 (class 2620 OID 37627)
-- Name: nota_fiscal_venda validatepersonkeyin; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER validatepersonkeyin
    BEFORE INSERT
    ON public.nota_fiscal_venda
    FOR EACH ROW
EXECUTE PROCEDURE public.validatepersonkey();


--
-- TOC entry 2924 (class 2620 OID 37629)
-- Name: usuario validatepersonkeyin; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER validatepersonkeyin
    BEFORE INSERT
    ON public.usuario
    FOR EACH ROW
EXECUTE PROCEDURE public.validatepersonkey();


--
-- TOC entry 2911 (class 2620 OID 37616)
-- Name: avaliacao_produto validatepersonkeyup; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER validatepersonkeyup
    BEFORE UPDATE
    ON public.avaliacao_produto
    FOR EACH ROW
EXECUTE PROCEDURE public.validatepersonkey();


--
-- TOC entry 2913 (class 2620 OID 37618)
-- Name: conta_pagar validatepersonkeyup; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER validatepersonkeyup
    BEFORE UPDATE
    ON public.conta_pagar
    FOR EACH ROW
EXECUTE PROCEDURE public.validatepersonkey();


--
-- TOC entry 2915 (class 2620 OID 37620)
-- Name: conta_receber validatepersonkeyup; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER validatepersonkeyup
    BEFORE UPDATE
    ON public.conta_receber
    FOR EACH ROW
EXECUTE PROCEDURE public.validatepersonkey();


--
-- TOC entry 2917 (class 2620 OID 37622)
-- Name: endereco validatepersonkeyup; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER validatepersonkeyup
    BEFORE UPDATE
    ON public.endereco
    FOR EACH ROW
EXECUTE PROCEDURE public.validatepersonkey();


--
-- TOC entry 2919 (class 2620 OID 37624)
-- Name: nota_fiscal_compra validatepersonkeyup; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER validatepersonkeyup
    BEFORE UPDATE
    ON public.nota_fiscal_compra
    FOR EACH ROW
EXECUTE PROCEDURE public.validatepersonkey();


--
-- TOC entry 2921 (class 2620 OID 37626)
-- Name: nota_fiscal_venda validatepersonkeyup; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER validatepersonkeyup
    BEFORE UPDATE
    ON public.nota_fiscal_venda
    FOR EACH ROW
EXECUTE PROCEDURE public.validatepersonkey();


--
-- TOC entry 2923 (class 2620 OID 37628)
-- Name: usuario validatepersonkeyup; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER validatepersonkeyup
    BEFORE UPDATE
    ON public.usuario
    FOR EACH ROW
EXECUTE PROCEDURE public.validatepersonkey();


--
-- TOC entry 2904 (class 2606 OID 37580)
-- Name: usuarios_acesso aesso_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios_acesso
    ADD CONSTRAINT aesso_fk FOREIGN KEY (acesso_id) REFERENCES public.acesso (id);


--
-- TOC entry 2899 (class 2606 OID 37555)
-- Name: nota_fiscal_compra conta_pagar_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nota_fiscal_compra
    ADD CONSTRAINT conta_pagar_fk FOREIGN KEY (conta_pagar_id) REFERENCES public.conta_pagar (id);


--
-- TOC entry 2906 (class 2606 OID 37590)
-- Name: vd_cp_loja_virt cupom_desc_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vd_cp_loja_virt
    ADD CONSTRAINT cupom_desc_fk FOREIGN KEY (cupom_desc_id) REFERENCES public.cup_desc (id);


--
-- TOC entry 2907 (class 2606 OID 37595)
-- Name: vd_cp_loja_virt endereco_cobranca_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vd_cp_loja_virt
    ADD CONSTRAINT endereco_cobranca_fk FOREIGN KEY (endereco_cobranca_id) REFERENCES public.endereco (id);


--
-- TOC entry 2908 (class 2606 OID 37600)
-- Name: vd_cp_loja_virt endereco_entrega_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vd_cp_loja_virt
    ADD CONSTRAINT endereco_entrega_fk FOREIGN KEY (endereco_entrega_id) REFERENCES public.endereco (id);


--
-- TOC entry 2909 (class 2606 OID 37605)
-- Name: vd_cp_loja_virt forma_pagamento_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vd_cp_loja_virt
    ADD CONSTRAINT forma_pagamento_fk FOREIGN KEY (forma_pagamento_id) REFERENCES public.forma_pagamento (id);


--
-- TOC entry 2901 (class 2606 OID 37565)
-- Name: nota_item_produto nota_fiscal_compra_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nota_item_produto
    ADD CONSTRAINT nota_fiscal_compra_fk FOREIGN KEY (nota_fiscal_compra_id) REFERENCES public.nota_fiscal_compra (id);


--
-- TOC entry 2910 (class 2606 OID 37610)
-- Name: vd_cp_loja_virt nota_fiscal_venda_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vd_cp_loja_virt
    ADD CONSTRAINT nota_fiscal_venda_fk FOREIGN KEY (nota_fiscal_venda_id) REFERENCES public.nota_fiscal_venda (id);


--
-- TOC entry 2895 (class 2606 OID 37535)
-- Name: avaliacao_produto produto_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.avaliacao_produto
    ADD CONSTRAINT produto_fk FOREIGN KEY (produto_id) REFERENCES public.produto (id);


--
-- TOC entry 2896 (class 2606 OID 37540)
-- Name: imagem_produto produto_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.imagem_produto
    ADD CONSTRAINT produto_fk FOREIGN KEY (produto_id) REFERENCES public.produto (id);


--
-- TOC entry 2897 (class 2606 OID 37545)
-- Name: item_venda_loja produto_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.item_venda_loja
    ADD CONSTRAINT produto_fk FOREIGN KEY (produto_id) REFERENCES public.produto (id);


--
-- TOC entry 2902 (class 2606 OID 37570)
-- Name: nota_item_produto produto_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nota_item_produto
    ADD CONSTRAINT produto_fk FOREIGN KEY (produto_id) REFERENCES public.produto (id);


--
-- TOC entry 2905 (class 2606 OID 37585)
-- Name: usuarios_acesso usuario_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios_acesso
    ADD CONSTRAINT usuario_fk FOREIGN KEY (usuario_id) REFERENCES public.usuario (id);


--
-- TOC entry 2900 (class 2606 OID 37560)
-- Name: nota_fiscal_venda venda_compra_loja_virt_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nota_fiscal_venda
    ADD CONSTRAINT venda_compra_loja_virt_fk FOREIGN KEY (venda_compra_loja_virt_id) REFERENCES public.vd_cp_loja_virt (id);


--
-- TOC entry 2903 (class 2606 OID 37575)
-- Name: status_rastreio venda_compra_loja_virt_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.status_rastreio
    ADD CONSTRAINT venda_compra_loja_virt_fk FOREIGN KEY (venda_compra_loja_virt_id) REFERENCES public.vd_cp_loja_virt (id);


--
-- TOC entry 2898 (class 2606 OID 37550)
-- Name: item_venda_loja venda_compraloja_virtu_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.item_venda_loja
    ADD CONSTRAINT venda_compraloja_virtu_fk FOREIGN KEY (venda_compra_loja_virtu_id) REFERENCES public.vd_cp_loja_virt (id);


-- Completed on 2022-10-12 22:49:53

--
-- PostgreSQL database dump complete
--

