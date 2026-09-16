--
-- PostgreSQL database dump
--

-- Dumped from database version 12.22 (Ubuntu 12.22-0ubuntu0.20.04.4)
-- Dumped by pg_dump version 12.22 (Ubuntu 12.22-0ubuntu0.20.04.4)

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

DROP DATABASE number_guessing_game;
--
-- Name: number_guessing_game; Type: DATABASE; Schema: -; Owner: freecodecamp
--

CREATE DATABASE number_guessing_game WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';


ALTER DATABASE number_guessing_game OWNER TO freecodecamp;

\connect number_guessing_game

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
-- Name: usernames; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.usernames (
    id integer NOT NULL,
    username character varying(25) NOT NULL,
    best_game integer,
    games_played integer
);


ALTER TABLE public.usernames OWNER TO freecodecamp;

--
-- Name: usernames_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.usernames_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.usernames_id_seq OWNER TO freecodecamp;

--
-- Name: usernames_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.usernames_id_seq OWNED BY public.usernames.id;


--
-- Name: usernames id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.usernames ALTER COLUMN id SET DEFAULT nextval('public.usernames_id_seq'::regclass);


--
-- Data for Name: usernames; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.usernames VALUES (146, 'a', 9, 2);
INSERT INTO public.usernames VALUES (148, 'user_1789570966514', 130, 2);
INSERT INTO public.usernames VALUES (147, 'user_1789570966515', 159, 5);
INSERT INTO public.usernames VALUES (150, 'user_1789570976564', 399, 2);
INSERT INTO public.usernames VALUES (149, 'user_1789570976565', 13, 5);
INSERT INTO public.usernames VALUES (152, 'user_1789570979390', 232, 2);
INSERT INTO public.usernames VALUES (151, 'user_1789570979391', 128, 5);
INSERT INTO public.usernames VALUES (154, 'user_1789571012079', 62, 2);
INSERT INTO public.usernames VALUES (153, 'user_1789571012080', 7, 5);
INSERT INTO public.usernames VALUES (156, 'user_1789571014009', 639, 2);
INSERT INTO public.usernames VALUES (155, 'user_1789571014010', 53, 5);


--
-- Name: usernames_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.usernames_id_seq', 156, true);


--
-- Name: usernames usernames_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.usernames
    ADD CONSTRAINT usernames_pkey PRIMARY KEY (id);


--
-- PostgreSQL database dump complete
--

