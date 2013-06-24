--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: awards; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE awards (
    id integer NOT NULL,
    name character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: awards_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE awards_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: awards_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE awards_id_seq OWNED BY awards.id;


--
-- Name: home; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE home (
    id integer NOT NULL,
    ica_presents_begins timestamp without time zone,
    program text,
    about text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: home_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE home_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: home_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE home_id_seq OWNED BY home.id;


--
-- Name: messages; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE messages (
    id integer NOT NULL,
    teacher_id integer,
    content character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: messages_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE messages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: messages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE messages_id_seq OWNED BY messages.id;


--
-- Name: projects; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE projects (
    id integer NOT NULL,
    author_id integer,
    author_type character varying(255),
    title character varying(255),
    students character varying(255),
    semester character varying(255),
    location character varying(255),
    "time" character varying(255),
    description text,
    picture character varying(255),
    approved boolean,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: projects_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE projects_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: projects_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE projects_id_seq OWNED BY projects.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying(255) NOT NULL
);


--
-- Name: students; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE students (
    id integer NOT NULL,
    facebook_id character varying(255),
    name character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: students_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE students_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: students_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE students_id_seq OWNED BY students.id;


--
-- Name: teachers; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE teachers (
    id integer NOT NULL,
    name character varying(255),
    email character varying(255),
    password_digest character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: teachers_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE teachers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: teachers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE teachers_id_seq OWNED BY teachers.id;


--
-- Name: votes; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE votes (
    id integer NOT NULL,
    student_id integer,
    award_id integer,
    project_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: votes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE votes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: votes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE votes_id_seq OWNED BY votes.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY awards ALTER COLUMN id SET DEFAULT nextval('awards_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY home ALTER COLUMN id SET DEFAULT nextval('home_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY messages ALTER COLUMN id SET DEFAULT nextval('messages_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY projects ALTER COLUMN id SET DEFAULT nextval('projects_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY students ALTER COLUMN id SET DEFAULT nextval('students_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY teachers ALTER COLUMN id SET DEFAULT nextval('teachers_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY votes ALTER COLUMN id SET DEFAULT nextval('votes_id_seq'::regclass);


--
-- Name: awards_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY awards
    ADD CONSTRAINT awards_pkey PRIMARY KEY (id);


--
-- Name: home_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY home
    ADD CONSTRAINT home_pkey PRIMARY KEY (id);


--
-- Name: messages_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY messages
    ADD CONSTRAINT messages_pkey PRIMARY KEY (id);


--
-- Name: projects_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY projects
    ADD CONSTRAINT projects_pkey PRIMARY KEY (id);


--
-- Name: students_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY students
    ADD CONSTRAINT students_pkey PRIMARY KEY (id);


--
-- Name: teachers_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY teachers
    ADD CONSTRAINT teachers_pkey PRIMARY KEY (id);


--
-- Name: votes_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY votes
    ADD CONSTRAINT votes_pkey PRIMARY KEY (id);


--
-- Name: index_messages_on_teacher_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_messages_on_teacher_id ON messages USING btree (teacher_id);


--
-- Name: index_projects_on_author_id_and_author_type; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_projects_on_author_id_and_author_type ON projects USING btree (author_id, author_type);


--
-- Name: index_students_on_facebook_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_students_on_facebook_id ON students USING btree (facebook_id);


--
-- Name: index_teachers_on_email; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_teachers_on_email ON teachers USING btree (email);


--
-- Name: index_votes_on_award_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_votes_on_award_id ON votes USING btree (award_id);


--
-- Name: index_votes_on_project_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_votes_on_project_id ON votes USING btree (project_id);


--
-- Name: index_votes_on_student_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_votes_on_student_id ON votes USING btree (student_id);


--
-- Name: index_votes_on_student_id_and_award_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_votes_on_student_id_and_award_id ON votes USING btree (student_id, award_id);


--
-- Name: search; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX search ON projects USING btree (title, students, semester, description);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user",public;

INSERT INTO schema_migrations (version) VALUES ('20130619221254');

INSERT INTO schema_migrations (version) VALUES ('20130619221308');

INSERT INTO schema_migrations (version) VALUES ('20130619221522');

INSERT INTO schema_migrations (version) VALUES ('20130619222005');

INSERT INTO schema_migrations (version) VALUES ('20130619222308');

INSERT INTO schema_migrations (version) VALUES ('20130619222442');

INSERT INTO schema_migrations (version) VALUES ('20130619224543');
