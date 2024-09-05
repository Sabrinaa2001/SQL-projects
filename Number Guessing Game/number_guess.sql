--
-- PostgreSQL database dump
--

-- Dumped from database version 12.17 (Ubuntu 12.17-1.pgdg22.04+1)
-- Dumped by pg_dump version 12.17 (Ubuntu 12.17-1.pgdg22.04+1)

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

DROP DATABASE number_guess;
--
-- Name: number_guess; Type: DATABASE; Schema: -; Owner: freecodecamp
--

CREATE DATABASE number_guess WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';


ALTER DATABASE number_guess OWNER TO freecodecamp;

\connect number_guess

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
-- Name: user_data; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.user_data (
    username character varying(22),
    number_of_games integer,
    best_score integer
);


ALTER TABLE public.user_data OWNER TO freecodecamp;

--
-- Data for Name: user_data; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.user_data VALUES ('Sab', 1, 8);
INSERT INTO public.user_data VALUES ('user_1725572547844', 2, 31);
INSERT INTO public.user_data VALUES ('user_1725572547845', 5, 126);
INSERT INTO public.user_data VALUES ('user_1725572583533', 2, 324);
INSERT INTO public.user_data VALUES ('user_1725572583534', 5, 204);


--
-- Name: user_data user_data_username_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.user_data
    ADD CONSTRAINT user_data_username_key UNIQUE (username);


--
-- PostgreSQL database dump complete
--

