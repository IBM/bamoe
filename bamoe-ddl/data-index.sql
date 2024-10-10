--
-- PostgreSQL database dump
--

-- Dumped from database version 16.1
-- Dumped by pg_dump version 16.1


--
-- Name: attachments; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE attachments (
    id character varying(255) NOT NULL,
    content character varying(255),
    name character varying(255),
    updated_at timestamp without time zone,
    updated_by character varying(255),
    task_id character varying(255) NOT NULL
);


--
-- Name: comments; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE comments (
    id character varying(255) NOT NULL,
    content character varying(255),
    updated_at timestamp without time zone,
    updated_by character varying(255),
    task_id character varying(255) NOT NULL
);


--
-- Name: definitions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE definitions (
    id character varying(255) NOT NULL,
    version character varying(255) NOT NULL,
    name character varying(255),
    type character varying(255),
    source bytea,
    endpoint character varying(255),
    description character varying(255)
);


--
-- Name: definitions_addons; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE definitions_addons (
    process_id character varying(255) NOT NULL,
    process_version character varying(255) NOT NULL,
    addon character varying(255) NOT NULL
);


--
-- Name: definitions_annotations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE definitions_annotations (
    value character varying(255) NOT NULL,
    process_id character varying(255) NOT NULL,
    process_version character varying(255) NOT NULL
);


--
-- Name: definitions_metadata; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE definitions_metadata (
    process_id character varying(255) NOT NULL,
    process_version character varying(255) NOT NULL,
    value character varying(255),
    key character varying(255) NOT NULL
);


--
-- Name: definitions_nodes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE definitions_nodes (
    id character varying(255) NOT NULL,
    name character varying(255),
    unique_id character varying(255),
    type character varying(255),
    process_id character varying(255) NOT NULL,
    process_version character varying(255) NOT NULL
);


--
-- Name: definitions_nodes_metadata; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE definitions_nodes_metadata (
    node_id character varying(255) NOT NULL,
    process_id character varying(255) NOT NULL,
    process_version character varying(255) NOT NULL,
    value character varying(255),
    key character varying(255) NOT NULL
);


--
-- Name: definitions_roles; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE definitions_roles (
    process_id character varying(255) NOT NULL,
    process_version character varying(255) NOT NULL,
    role character varying(255) NOT NULL
);


--
-- Name: jobs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE jobs (
    id character varying(255) NOT NULL,
    callback_endpoint character varying(255),
    endpoint character varying(255),
    execution_counter integer,
    expiration_time timestamp without time zone,
    last_update timestamp without time zone,
    node_instance_id character varying(255),
    priority integer,
    process_id character varying(255),
    process_instance_id character varying(255),
    repeat_interval bigint,
    repeat_limit integer,
    retries integer,
    root_process_id character varying(255),
    root_process_instance_id character varying(255),
    scheduled_id character varying(255),
    status character varying(255)
);


--
-- Name: kogito_data_cache; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE kogito_data_cache (
    key character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    json_value jsonb
);


--
-- Name: milestones; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE milestones (
    id character varying(255) NOT NULL,
    process_instance_id character varying(255) NOT NULL,
    name character varying(255),
    status character varying(255)
);


--
-- Name: nodes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE nodes (
    id character varying(255) NOT NULL,
    definition_id character varying(255),
    enter timestamp without time zone,
    exit timestamp without time zone,
    name character varying(255),
    node_id character varying(255),
    type character varying(255),
    process_instance_id character varying(255) NOT NULL
);


--
-- Name: processes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE processes (
    id character varying(255) NOT NULL,
    business_key character varying(255),
    end_time timestamp without time zone,
    endpoint character varying(255),
    message character varying(65535),
    node_definition_id character varying(255),
    last_update_time timestamp without time zone,
    parent_process_instance_id character varying(255),
    process_id character varying(255),
    process_name character varying(255),
    root_process_id character varying(255),
    root_process_instance_id character varying(255),
    start_time timestamp without time zone,
    state integer,
    variables jsonb,
    version character varying(255),
    created_by character varying,
    updated_by character varying
);


--
-- Name: processes_addons; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE processes_addons (
    process_id character varying(255) NOT NULL,
    addon character varying(255) NOT NULL
);


--
-- Name: processes_roles; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE processes_roles (
    process_id character varying(255) NOT NULL,
    role character varying(255) NOT NULL
);


--
-- Name: tasks; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE tasks (
    id character varying(255) NOT NULL,
    actual_owner character varying(255),
    completed timestamp without time zone,
    description character varying(255),
    endpoint character varying(255),
    inputs jsonb,
    last_update timestamp without time zone,
    name character varying(255),
    outputs jsonb,
    priority character varying(255),
    process_id character varying(255),
    process_instance_id character varying(255),
    reference_name character varying(255),
    root_process_id character varying(255),
    root_process_instance_id character varying(255),
    started timestamp without time zone,
    state character varying(255)
);


--
-- Name: tasks_admin_groups; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE tasks_admin_groups (
    task_id character varying(255) NOT NULL,
    group_id character varying(255) NOT NULL
);


--
-- Name: tasks_admin_users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE tasks_admin_users (
    task_id character varying(255) NOT NULL,
    user_id character varying(255) NOT NULL
);


--
-- Name: tasks_excluded_users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE tasks_excluded_users (
    task_id character varying(255) NOT NULL,
    user_id character varying(255) NOT NULL
);


--
-- Name: tasks_potential_groups; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE tasks_potential_groups (
    task_id character varying(255) NOT NULL,
    group_id character varying(255) NOT NULL
);


--
-- Name: tasks_potential_users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE tasks_potential_users (
    task_id character varying(255) NOT NULL,
    user_id character varying(255) NOT NULL
);


--
-- Name: attachments attachments_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY attachments
    ADD CONSTRAINT attachments_pkey PRIMARY KEY (id);


--
-- Name: comments comments_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY comments
    ADD CONSTRAINT comments_pkey PRIMARY KEY (id);


--
-- Name: definitions_addons definitions_addons_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY definitions_addons
    ADD CONSTRAINT definitions_addons_pkey PRIMARY KEY (process_id, process_version, addon);


--
-- Name: definitions_annotations definitions_annotations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY definitions_annotations
    ADD CONSTRAINT definitions_annotations_pkey PRIMARY KEY (value, process_id, process_version);


--
-- Name: definitions_metadata definitions_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY definitions_metadata
    ADD CONSTRAINT definitions_metadata_pkey PRIMARY KEY (process_id, process_version, key);


--
-- Name: definitions_nodes_metadata definitions_nodes_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY definitions_nodes_metadata
    ADD CONSTRAINT definitions_nodes_metadata_pkey PRIMARY KEY (node_id, process_id, process_version, key);


--
-- Name: definitions_nodes definitions_nodes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY definitions_nodes
    ADD CONSTRAINT definitions_nodes_pkey PRIMARY KEY (id, process_id, process_version);


--
-- Name: definitions definitions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY definitions
    ADD CONSTRAINT definitions_pkey PRIMARY KEY (id, version);


--
-- Name: definitions_roles definitions_roles_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY definitions_roles
    ADD CONSTRAINT definitions_roles_pkey PRIMARY KEY (process_id, process_version, role);


--
-- Name: jobs jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY jobs
    ADD CONSTRAINT jobs_pkey PRIMARY KEY (id);


--
-- Name: kogito_data_cache kogito_data_cache_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY kogito_data_cache
    ADD CONSTRAINT kogito_data_cache_pkey PRIMARY KEY (key, name);


--
-- Name: milestones milestones_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY milestones
    ADD CONSTRAINT milestones_pkey PRIMARY KEY (id, process_instance_id);


--
-- Name: nodes nodes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY nodes
    ADD CONSTRAINT nodes_pkey PRIMARY KEY (id);


--
-- Name: processes_addons processes_addons_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY processes_addons
    ADD CONSTRAINT processes_addons_pkey PRIMARY KEY (process_id, addon);


--
-- Name: processes processes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY processes
    ADD CONSTRAINT processes_pkey PRIMARY KEY (id);


--
-- Name: processes_roles processes_roles_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY processes_roles
    ADD CONSTRAINT processes_roles_pkey PRIMARY KEY (process_id, role);


--
-- Name: tasks_admin_groups tasks_admin_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY tasks_admin_groups
    ADD CONSTRAINT tasks_admin_groups_pkey PRIMARY KEY (task_id, group_id);


--
-- Name: tasks_admin_users tasks_admin_users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY tasks_admin_users
    ADD CONSTRAINT tasks_admin_users_pkey PRIMARY KEY (task_id, user_id);


--
-- Name: tasks_excluded_users tasks_excluded_users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY tasks_excluded_users
    ADD CONSTRAINT tasks_excluded_users_pkey PRIMARY KEY (task_id, user_id);


--
-- Name: tasks tasks_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY tasks
    ADD CONSTRAINT tasks_pkey PRIMARY KEY (id);


--
-- Name: tasks_potential_groups tasks_potential_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY tasks_potential_groups
    ADD CONSTRAINT tasks_potential_groups_pkey PRIMARY KEY (task_id, group_id);


--
-- Name: tasks_potential_users tasks_potential_users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY tasks_potential_users
    ADD CONSTRAINT tasks_potential_users_pkey PRIMARY KEY (task_id, user_id);


--
-- Name: idx_attachments_tid; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_attachments_tid ON attachments USING btree (task_id);


--
-- Name: idx_comments_tid; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_comments_tid ON comments USING btree (task_id);


--
-- Name: idx_definitions_addons_pid_pv; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_definitions_addons_pid_pv ON definitions_addons USING btree (process_id, process_version);


--
-- Name: idx_definitions_annotations_pid_pv; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_definitions_annotations_pid_pv ON definitions_annotations USING btree (process_id, process_version);


--
-- Name: idx_definitions_metadata_pid_pv; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_definitions_metadata_pid_pv ON definitions_metadata USING btree (process_id, process_version);


--
-- Name: idx_definitions_nodes_metadata_pid_pv; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_definitions_nodes_metadata_pid_pv ON definitions_nodes_metadata USING btree (process_id, process_version);


--
-- Name: idx_definitions_nodes_pid_pv; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_definitions_nodes_pid_pv ON definitions_nodes USING btree (process_id, process_version);


--
-- Name: idx_definitions_roles_pid_pv; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_definitions_roles_pid_pv ON definitions_roles USING btree (process_id, process_version);


--
-- Name: idx_milestones_piid; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_milestones_piid ON milestones USING btree (process_instance_id);


--
-- Name: idx_nodes_piid; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_nodes_piid ON nodes USING btree (process_instance_id);


--
-- Name: idx_processes_addons_pid; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_processes_addons_pid ON processes_addons USING btree (process_id);


--
-- Name: idx_processes_roles_pid; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_processes_roles_pid ON processes_roles USING btree (process_id);


--
-- Name: idx_tasks_admin_groups_tid; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_tasks_admin_groups_tid ON tasks_admin_groups USING btree (task_id);


--
-- Name: idx_tasks_admin_users_tid; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_tasks_admin_users_tid ON tasks_admin_users USING btree (task_id);


--
-- Name: idx_tasks_excluded_users_tid; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_tasks_excluded_users_tid ON tasks_excluded_users USING btree (task_id);


--
-- Name: idx_tasks_potential_groups_tid; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_tasks_potential_groups_tid ON tasks_potential_groups USING btree (task_id);


--
-- Name: idx_tasks_potential_users_tid; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_tasks_potential_users_tid ON tasks_potential_users USING btree (task_id);


--
-- Name: attachments fk_attachments_tasks; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY attachments
    ADD CONSTRAINT fk_attachments_tasks FOREIGN KEY (task_id) REFERENCES tasks(id) ON DELETE CASCADE;


--
-- Name: comments fk_comments_tasks; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY comments
    ADD CONSTRAINT fk_comments_tasks FOREIGN KEY (task_id) REFERENCES tasks(id) ON DELETE CASCADE;


--
-- Name: definitions_addons fk_definitions_addons_definitions; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY definitions_addons
    ADD CONSTRAINT fk_definitions_addons_definitions FOREIGN KEY (process_id, process_version) REFERENCES definitions(id, version) ON DELETE CASCADE;


--
-- Name: definitions_annotations fk_definitions_annotations; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY definitions_annotations
    ADD CONSTRAINT fk_definitions_annotations FOREIGN KEY (process_id, process_version) REFERENCES definitions(id, version) ON DELETE CASCADE;


--
-- Name: definitions_metadata fk_definitions_metadata; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY definitions_metadata
    ADD CONSTRAINT fk_definitions_metadata FOREIGN KEY (process_id, process_version) REFERENCES definitions(id, version) ON DELETE CASCADE;


--
-- Name: definitions_nodes fk_definitions_nodes_definitions; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY definitions_nodes
    ADD CONSTRAINT fk_definitions_nodes_definitions FOREIGN KEY (process_id, process_version) REFERENCES definitions(id, version) ON DELETE CASCADE;


--
-- Name: definitions_nodes_metadata fk_definitions_nodes_metadata_definitions_nodes; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY definitions_nodes_metadata
    ADD CONSTRAINT fk_definitions_nodes_metadata_definitions_nodes FOREIGN KEY (node_id, process_id, process_version) REFERENCES definitions_nodes(id, process_id, process_version) ON DELETE CASCADE;


--
-- Name: definitions_roles fk_definitions_roles_definitions; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY definitions_roles
    ADD CONSTRAINT fk_definitions_roles_definitions FOREIGN KEY (process_id, process_version) REFERENCES definitions(id, version) ON DELETE CASCADE;


--
-- Name: milestones fk_milestones_process; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY milestones
    ADD CONSTRAINT fk_milestones_process FOREIGN KEY (process_instance_id) REFERENCES processes(id) ON DELETE CASCADE;


--
-- Name: nodes fk_nodes_process; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY nodes
    ADD CONSTRAINT fk_nodes_process FOREIGN KEY (process_instance_id) REFERENCES processes(id) ON DELETE CASCADE;


--
-- Name: processes_addons fk_processes_addons_processes; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY processes_addons
    ADD CONSTRAINT fk_processes_addons_processes FOREIGN KEY (process_id) REFERENCES processes(id) ON DELETE CASCADE;


--
-- Name: processes_roles fk_processes_roles_processes; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY processes_roles
    ADD CONSTRAINT fk_processes_roles_processes FOREIGN KEY (process_id) REFERENCES processes(id) ON DELETE CASCADE;


--
-- Name: tasks_admin_groups fk_tasks_admin_groups_tasks; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY tasks_admin_groups
    ADD CONSTRAINT fk_tasks_admin_groups_tasks FOREIGN KEY (task_id) REFERENCES tasks(id) ON DELETE CASCADE;


--
-- Name: tasks_admin_users fk_tasks_admin_users_tasks; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY tasks_admin_users
    ADD CONSTRAINT fk_tasks_admin_users_tasks FOREIGN KEY (task_id) REFERENCES tasks(id) ON DELETE CASCADE;


--
-- Name: tasks_excluded_users fk_tasks_excluded_users_tasks; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY tasks_excluded_users
    ADD CONSTRAINT fk_tasks_excluded_users_tasks FOREIGN KEY (task_id) REFERENCES tasks(id) ON DELETE CASCADE;


--
-- Name: tasks_potential_groups fk_tasks_potential_groups_tasks; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY tasks_potential_groups
    ADD CONSTRAINT fk_tasks_potential_groups_tasks FOREIGN KEY (task_id) REFERENCES tasks(id) ON DELETE CASCADE;


--
-- Name: tasks_potential_users fk_tasks_potential_users_tasks; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY tasks_potential_users
    ADD CONSTRAINT fk_tasks_potential_users_tasks FOREIGN KEY (task_id) REFERENCES tasks(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

