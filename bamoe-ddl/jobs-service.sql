--
-- Name: job_status; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE job_status AS ENUM (
    'ERROR',
    'EXECUTED',
    'SCHEDULED',
    'RETRY',
    'CANCELED'
);


--
-- Name: job_type; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE job_type AS ENUM (
    'HTTP'
);


--
-- Name: job_details; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE job_details (
    id character varying(50) NOT NULL,
    correlation_id character varying(50),
    status character varying(40),
    last_update timestamp with time zone,
    retries integer,
    execution_counter integer,
    scheduled_id character varying(40),
    priority integer,
    recipient jsonb,
    trigger jsonb,
    fire_time timestamp with time zone,
    execution_timeout bigint,
    execution_timeout_unit character varying(40),
    created timestamp with time zone
);


--
-- Name: job_details_v1; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE job_details_v1 (
    id character varying(50) NOT NULL,
    correlation_id character varying(50),
    status job_status,
    last_update timestamp with time zone,
    retries integer,
    execution_counter integer,
    scheduled_id character varying(40),
    payload jsonb,
    type job_type,
    priority integer,
    recipient jsonb,
    trigger jsonb,
    fire_time timestamp with time zone
);


--
-- Name: job_service_management; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE job_service_management (
    id character varying(40) NOT NULL,
    last_heartbeat timestamp with time zone,
    token character varying(40)
);


--
-- Name: job_details_v1 job_details_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY job_details_v1
    ADD CONSTRAINT job_details_pkey PRIMARY KEY (id);


--
-- Name: job_details job_details_pkey1; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY job_details
    ADD CONSTRAINT job_details_pkey1 PRIMARY KEY (id);


--
-- Name: job_service_management job_service_management_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY job_service_management
    ADD CONSTRAINT job_service_management_pkey PRIMARY KEY (id);


--
-- Name: job_service_management job_service_management_token_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY job_service_management
    ADD CONSTRAINT job_service_management_token_key UNIQUE (token);


--
-- Name: job_details_created_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX job_details_created_idx ON job_details USING btree (created);


--
-- Name: job_details_fire_time_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX job_details_fire_time_idx ON job_details USING btree (fire_time);

