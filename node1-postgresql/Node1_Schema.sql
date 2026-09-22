-- ==========================================
-- NODE 1: POSTGRESQL SCHEMA (DDL)
-- ==========================================

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

CREATE TYPE public.game_status AS ENUM ('released', 'early_access', 'beta', 'alpha', 'discontinued');
CREATE TYPE public.user_role AS ENUM ('player', 'developer', 'admin');

CREATE TABLE public.developers (
    dev_id integer NOT NULL,
    name character varying(100) NOT NULL,
    website character varying(255)
);
CREATE SEQUENCE public.developers_dev_id_seq AS integer START WITH 1 INCREMENT BY 1 NO MINVALUE NO MAXVALUE CACHE 1;
ALTER SEQUENCE public.developers_dev_id_seq OWNED BY public.developers.dev_id;

CREATE TABLE public.users (
    user_id integer NOT NULL,
    username character varying(50) NOT NULL,
    email character varying(100) NOT NULL,
    password character varying(255) NOT NULL,
    country character varying(50),
    role public.user_role DEFAULT 'player'::public.user_role,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);
CREATE SEQUENCE public.users_user_id_seq AS integer START WITH 1 INCREMENT BY 1 NO MINVALUE NO MAXVALUE CACHE 1;
ALTER SEQUENCE public.users_user_id_seq OWNED BY public.users.user_id;

CREATE TABLE public.games (
    game_id integer NOT NULL,
    title character varying(150) NOT NULL,
    description text,
    release_date date,
    status public.game_status DEFAULT 'early_access'::public.game_status,
    price numeric(10,2) DEFAULT 0.00
);
CREATE SEQUENCE public.games_game_id_seq AS integer START WITH 1 INCREMENT BY 1 NO MINVALUE NO MAXVALUE CACHE 1;
ALTER SEQUENCE public.games_game_id_seq OWNED BY public.games.game_id;

CREATE TABLE public.developer_members (
    user_id integer NOT NULL,
    dev_id integer NOT NULL,
    joined_at date DEFAULT CURRENT_DATE
);

CREATE TABLE public.game_developers (
    game_id integer NOT NULL,
    dev_id integer NOT NULL
);

CREATE TABLE public.game_tags (
    game_id integer NOT NULL,
    tag_name character varying(30) NOT NULL
);

CREATE TABLE public.games_v1 (
    game_id integer NOT NULL,
    title character varying(150),
    price numeric(10,2),
    status public.game_status
);

ALTER TABLE ONLY public.developers ALTER COLUMN dev_id SET DEFAULT nextval('public.developers_dev_id_seq'::regclass);
ALTER TABLE ONLY public.games ALTER COLUMN game_id SET DEFAULT nextval('public.games_game_id_seq'::regclass);
ALTER TABLE ONLY public.users ALTER COLUMN user_id SET DEFAULT nextval('public.users_user_id_seq'::regclass);

ALTER TABLE ONLY public.developer_members ADD CONSTRAINT developer_members_pkey PRIMARY KEY (user_id, dev_id);
ALTER TABLE ONLY public.developers ADD CONSTRAINT developers_pkey PRIMARY KEY (dev_id);
ALTER TABLE ONLY public.game_developers ADD CONSTRAINT game_developers_pkey PRIMARY KEY (game_id, dev_id);
ALTER TABLE ONLY public.game_tags ADD CONSTRAINT game_tags_pkey PRIMARY KEY (game_id, tag_name);
ALTER TABLE ONLY public.games ADD CONSTRAINT games_pkey PRIMARY KEY (game_id);
ALTER TABLE ONLY public.games_v1 ADD CONSTRAINT games_v1_pkey PRIMARY KEY (game_id);
ALTER TABLE ONLY public.users ADD CONSTRAINT users_email_key UNIQUE (email);
ALTER TABLE ONLY public.users ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);
ALTER TABLE ONLY public.users ADD CONSTRAINT users_username_key UNIQUE (username);

ALTER TABLE ONLY public.developer_members ADD CONSTRAINT developer_members_dev_id_fkey FOREIGN KEY (dev_id) REFERENCES public.developers(dev_id) ON DELETE CASCADE;
ALTER TABLE ONLY public.developer_members ADD CONSTRAINT developer_members_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE CASCADE;
ALTER TABLE ONLY public.game_developers ADD CONSTRAINT game_developers_dev_id_fkey FOREIGN KEY (dev_id) REFERENCES public.developers(dev_id) ON DELETE CASCADE;
ALTER TABLE ONLY public.game_developers ADD CONSTRAINT game_developers_game_id_fkey FOREIGN KEY (game_id) REFERENCES public.games(game_id) ON DELETE CASCADE;
ALTER TABLE ONLY public.game_tags ADD CONSTRAINT game_tags_game_id_fkey FOREIGN KEY (game_id) REFERENCES public.games(game_id) ON DELETE CASCADE;