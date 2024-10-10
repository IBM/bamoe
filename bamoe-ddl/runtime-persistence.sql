--
-- Name: business_key_mapping; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE business_key_mapping (
    business_key character(255) NOT NULL,
    process_instance_id character(36) NOT NULL
);


--
-- Name: correlation_instances; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE correlation_instances (
    id character(36) NOT NULL,
    encoded_correlation_id character varying(36) NOT NULL,
    correlated_id character varying(36) NOT NULL,
    correlation character varying NOT NULL,
    version bigint
);


--
-- Name: process_instances; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE process_instances (
    id character(36) NOT NULL,
    payload bytea NOT NULL,
    process_id character varying NOT NULL,
    version bigint,
    process_version character varying
);


--
-- Name: business_key_mapping business_key_mapping_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY business_key_mapping
    ADD CONSTRAINT business_key_mapping_pkey PRIMARY KEY (business_key);


--
-- Name: correlation_instances correlation_instances_encoded_correlation_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY correlation_instances
    ADD CONSTRAINT correlation_instances_encoded_correlation_id_key UNIQUE (encoded_correlation_id);


--
-- Name: correlation_instances correlation_instances_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY correlation_instances
    ADD CONSTRAINT correlation_instances_pkey PRIMARY KEY (id);


--
-- Name: process_instances process_instances_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY process_instances
    ADD CONSTRAINT process_instances_pkey PRIMARY KEY (id);


--
-- Name: idx_business_key_process_instance_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_business_key_process_instance_id ON business_key_mapping USING btree (process_instance_id);


--
-- Name: idx_correlation_instances_correlated_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_correlation_instances_correlated_id ON correlation_instances USING btree (correlated_id);


--
-- Name: idx_correlation_instances_encoded_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_correlation_instances_encoded_id ON correlation_instances USING btree (encoded_correlation_id);


--
-- Name: idx_process_instances_process_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_process_instances_process_id ON process_instances USING btree (process_id, id, process_version);


--
-- Name: business_key_mapping fk_process_instances; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY business_key_mapping
    ADD CONSTRAINT fk_process_instances FOREIGN KEY (process_instance_id) REFERENCES process_instances(id) ON DELETE CASCADE;

