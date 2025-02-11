USE bamoe;

--
-- Data audit uses below tables
--

-- TABLE audit_query: store custom queries against data audit tables
CREATE TABLE audit_query (
    identifier character varying(255) NOT NULL,
    graph_ql_definition character varying(5000),
    query character varying(5000)
);

CREATE SEQUENCE job_execution_history_id_seq
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 50;

-- TABLE job_execution_log: historical records of events of job execution
CREATE TABLE job_execution_log (
    id bigint NOT NULL,
    event_date datetime2(6),
    execution_counter integer,
    expiration_time datetime2(6),
    job_id character varying(255),
    node_instance_id character varying(255),
    priority integer,
    process_instance_id character varying(255),
    repeat_interval bigint,
    repeat_limit integer,
    retries integer,
    scheduled_id character varying(255),
    status character varying(255)
);

-- TABLE process_instance_error_log: historical record of process instance errors
CREATE TABLE process_instance_error_log (
    id bigint NOT NULL,
    business_key character varying(255),
    event_date datetime2(6),
    event_id character varying(255),
    parent_process_instance_id character varying(255),
    process_id character varying(255),
    process_instance_id character varying(255),
    process_type character varying(255),
    process_version character varying(255),
    root_process_id character varying(255),
    root_process_instance_id character varying(255),
    error_message character varying(255),
    node_definition_id character varying(255),
    node_instance_id character varying(255)
);

CREATE SEQUENCE process_instance_error_log_seq_id
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 50;

-- TABLE process_instance_node_log: historical record of node instance executions
CREATE TABLE process_instance_node_log (
    id bigint NOT NULL,
    business_key character varying(255),
    event_date datetime2(6),
    event_id character varying(255),
    parent_process_instance_id character varying(255),
    process_id character varying(255),
    process_instance_id character varying(255),
    process_type character varying(255),
    process_version character varying(255),
    root_process_id character varying(255),
    root_process_instance_id character varying(255),
    connection character varying(255),
    event_data character varying(255),
    event_type character varying(255),
    node_definition_id character varying(255),
    node_instance_id character varying(255),
    node_name character varying(255),
    node_type character varying(255),
    sla_due_date datetime2(6),
    work_item_id character varying(255),
    CONSTRAINT process_instance_node_log_event_type_check CHECK (event_type IN ('ENTER', 'EXIT', 'ABORTED', 'ASYNC_ENTER', 'OBSOLETE', 'SKIPPED', 'ERROR', 'SLA_VIOLATION'))
);

CREATE SEQUENCE process_instance_node_log_id_seq
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 50;

-- TABLE process_instance_state_log: historical record of node state change during executions
CREATE TABLE process_instance_state_log (
    id bigint NOT NULL,
    business_key character varying(255),
    event_date datetime2(6),
    event_id character varying(255),
    parent_process_instance_id character varying(255),
    process_id character varying(255),
    process_instance_id character varying(255),
    process_type character varying(255),
    process_version character varying(255),
    root_process_id character varying(255),
    root_process_instance_id character varying(255),
    event_type character varying(255) NOT NULL,
    outcome character varying(255),
    sla_due_date datetime2(6),
    state character varying(255),
    CONSTRAINT process_instance_state_log_event_type_check CHECK (event_type IN ('ACTIVE', 'COMPLETED', 'SLA_VIOLATION', 'MIGRATED'))
);

CREATE SEQUENCE process_instance_state_log_id_seq
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 50;

-- TABLE process_instance_state_roles_log: historical record of process instance state changed during execution
CREATE TABLE process_instance_state_roles_log (
    process_instance_state_log_id bigint NOT NULL,
    role character varying(255)
);

-- TABLE process_instance_variable_log: historical record of variable changes during process instance execution
CREATE TABLE process_instance_variable_log (
    id bigint NOT NULL,
    business_key character varying(255),
    event_date datetime2(6),
    event_id character varying(255),
    parent_process_instance_id character varying(255),
    process_id character varying(255),
    process_instance_id character varying(255),
    process_type character varying(255),
    process_version character varying(255),
    root_process_id character varying(255),
    root_process_instance_id character varying(255),
    variable_id character varying(255),
    variable_name character varying(255),
    variable_value character varying(255)
);

CREATE SEQUENCE process_instance_variable_log_id_seq
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 50;

-- TABLE  task_instance_assignment_log: historical record of assignments in user task instance
CREATE TABLE task_instance_assignment_log (
    id bigint NOT NULL,
    business_key character varying(255),
    event_date datetime2(6),
    event_id character varying(255),
    event_user character varying(255),
    process_instance_id character varying(255),
    user_task_definition_id character varying(255),
    user_task_instance_id character varying(255),
    assignment_type character varying(255),
    task_name character varying(255)
);

CREATE SEQUENCE task_instance_assignment_log_id_seq
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 50;

-- TABLE task_instance_assignment_users_log: historical record of assignments in user task instance
CREATE TABLE task_instance_assignment_users_log (
    task_instance_assignment_log_id bigint NOT NULL,
    user_id character varying(255)
);

-- TABLE task_instance_attachment_log: historical record of user task instance attachments
CREATE TABLE task_instance_attachment_log (
    id bigint NOT NULL,
    business_key character varying(255),
    event_date datetime2(6),
    event_id character varying(255),
    event_user character varying(255),
    process_instance_id character varying(255),
    user_task_definition_id character varying(255),
    user_task_instance_id character varying(255),
    attachment_id character varying(255),
    attachment_name character varying(255),
    attachment_uri character varying(255),
    event_type integer
);

CREATE SEQUENCE task_instance_attachment_log_id_seq
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 50;

-- TABLE task_instance_comment_log: historical record of user task instance comments
CREATE TABLE task_instance_comment_log (
    id bigint NOT NULL,
    business_key character varying(255),
    event_date datetime2(6),
    event_id character varying(255),
    event_user character varying(255),
    process_instance_id character varying(255),
    user_task_definition_id character varying(255),
    user_task_instance_id character varying(255),
    comment_content character varying(1000),
    comment_id character varying(255),
    event_type integer
);

CREATE SEQUENCE task_instance_comment_log_id_seq
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 50;

-- TABLE task_instance_deadline_log: historical record of user task instance deadlines change
CREATE TABLE task_instance_deadline_log (
    id bigint NOT NULL,
    business_key character varying(255),
    event_date datetime2(6),
    event_id character varying(255),
    event_user character varying(255),
    process_instance_id character varying(255),
    user_task_definition_id character varying(255),
    user_task_instance_id character varying(255),
    event_type character varying(255)
);

CREATE SEQUENCE task_instance_deadline_log_id_seq
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 50;

-- TABLE task_instance_deadline_notification_log: historical record of user task instance deadlines notifications
CREATE TABLE task_instance_deadline_notification_log (
    task_instance_deadline_log_id bigint NOT NULL,
    property_value character varying(255),
    property_name character varying(255) NOT NULL
);

-- TABLE task_instance_state_log: historical record of user task instance state change
CREATE TABLE task_instance_state_log (
    id bigint NOT NULL,
    business_key character varying(255),
    event_date datetime2(6),
    event_id character varying(255),
    event_user character varying(255),
    process_instance_id character varying(255),
    user_task_definition_id character varying(255),
    user_task_instance_id character varying(255),
    actual_user character varying(255),
    description character varying(255),
    event_type character varying(255),
    name character varying(255),
    state character varying(255)
);

CREATE SEQUENCE task_instance_state_log_id_seq
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 50;

-- TABLE task_instance_variable_log: historical record of user task instance input/output variables change
CREATE TABLE task_instance_variable_log (
    id bigint NOT NULL,
    business_key character varying(255),
    event_date datetime2(6),
    event_id character varying(255),
    event_user character varying(255),
    process_instance_id character varying(255),
    user_task_definition_id character varying(255),
    user_task_instance_id character varying(255),
    variable_id character varying(255),
    variable_name character varying(255),
    variable_type character varying(255),
    variable_value character varying(255),
    CONSTRAINT task_instance_variable_log_variable_type_check CHECK (variable_type IN ('INPUT', 'OUTPUT'))
);

CREATE SEQUENCE task_instance_variable_log_id_seq
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 50;

ALTER TABLE audit_query
    ADD CONSTRAINT audit_query_pkey PRIMARY KEY (identifier);

ALTER TABLE job_execution_log
    ADD CONSTRAINT job_execution_log_pkey PRIMARY KEY (id);

ALTER TABLE process_instance_error_log
    ADD CONSTRAINT process_instance_error_log_pkey PRIMARY KEY (id);

ALTER TABLE process_instance_node_log
    ADD CONSTRAINT process_instance_node_log_pkey PRIMARY KEY (id);

ALTER TABLE process_instance_state_log
    ADD CONSTRAINT process_instance_state_log_pkey PRIMARY KEY (id);

ALTER TABLE process_instance_variable_log
    ADD CONSTRAINT process_instance_variable_log_pkey PRIMARY KEY (id);

ALTER TABLE task_instance_assignment_log
    ADD CONSTRAINT task_instance_assignment_log_pkey PRIMARY KEY (id);

ALTER TABLE task_instance_attachment_log
    ADD CONSTRAINT task_instance_attachment_log_pkey PRIMARY KEY (id);

ALTER TABLE task_instance_comment_log
    ADD CONSTRAINT task_instance_comment_log_pkey PRIMARY KEY (id);

ALTER TABLE task_instance_deadline_log
    ADD CONSTRAINT task_instance_deadline_log_pkey PRIMARY KEY (id);

ALTER TABLE task_instance_deadline_notification_log
    ADD CONSTRAINT task_instance_deadline_notification_log_pkey PRIMARY KEY (task_instance_deadline_log_id, property_name);

ALTER TABLE task_instance_state_log
    ADD CONSTRAINT task_instance_state_log_pkey PRIMARY KEY (id);

ALTER TABLE task_instance_variable_log
    ADD CONSTRAINT task_instance_variable_log_pkey PRIMARY KEY (id);

CREATE INDEX ix_jel_jid ON job_execution_log (job_id);

CREATE INDEX ix_jel_pid ON job_execution_log (process_instance_id);

CREATE INDEX ix_jel_status ON job_execution_log (status);

CREATE INDEX ix_piel_event_date ON process_instance_error_log (event_date);

CREATE INDEX ix_piel_key ON process_instance_error_log (business_key);

CREATE INDEX ix_piel_pid ON process_instance_error_log (process_instance_id);

CREATE INDEX ix_pinl_event_date ON process_instance_node_log (event_date);

CREATE INDEX ix_pinl_key ON process_instance_node_log (business_key);

CREATE INDEX ix_pinl_pid ON process_instance_node_log (process_instance_id);

CREATE INDEX ix_pisl_event_date ON process_instance_state_log (event_date);

CREATE INDEX ix_pisl_key ON process_instance_state_log (business_key);

CREATE INDEX ix_pisl_pid ON process_instance_state_log (process_instance_id);

CREATE INDEX ix_pisl_state ON process_instance_state_log (state);

CREATE INDEX ix_pivl_event_date ON process_instance_variable_log (event_date);

CREATE INDEX ix_pivl_key ON process_instance_variable_log (business_key);

CREATE INDEX ix_pivl_pid ON process_instance_variable_log (process_instance_id);

CREATE INDEX ix_pivl_var_id ON process_instance_variable_log (variable_id);

CREATE INDEX ix_tavl_event_date ON task_instance_variable_log (event_date);

CREATE INDEX ix_tavl_key ON task_instance_variable_log (business_key);

CREATE INDEX ix_tavl_pid ON task_instance_variable_log (process_instance_id);

CREATE INDEX ix_tavl_utid ON task_instance_variable_log (user_task_instance_id);

CREATE INDEX ix_utasl_event_date ON task_instance_assignment_log (event_date);

CREATE INDEX ix_utasl_key ON task_instance_assignment_log (business_key);

CREATE INDEX ix_utasl_pid ON task_instance_assignment_log (process_instance_id);

CREATE INDEX ix_utasl_utid ON task_instance_assignment_log (user_task_instance_id);

CREATE INDEX ix_utatl_event_date ON task_instance_attachment_log (event_date);

CREATE INDEX ix_utatl_key ON task_instance_attachment_log (business_key);

CREATE INDEX ix_utatl_pid ON task_instance_attachment_log (process_instance_id);

CREATE INDEX ix_utatl_utid ON task_instance_attachment_log (user_task_instance_id);

CREATE INDEX ix_utcl_event_date ON task_instance_comment_log (event_date);

CREATE INDEX ix_utcl_key ON task_instance_comment_log (business_key);

CREATE INDEX ix_utcl_pid ON task_instance_comment_log (process_instance_id);

CREATE INDEX ix_utcl_utid ON task_instance_comment_log (user_task_instance_id);

CREATE INDEX ix_utdl_event_date ON task_instance_deadline_log (event_date);

CREATE INDEX ix_utdl_key ON task_instance_deadline_log (business_key);

CREATE INDEX ix_utdl_pid ON task_instance_deadline_log (process_instance_id);

CREATE INDEX ix_utdl_utid ON task_instance_deadline_log (user_task_instance_id);

CREATE INDEX ix_utsl_event_date ON task_instance_state_log (event_date);

CREATE INDEX ix_utsl_key ON task_instance_state_log (business_key);

CREATE INDEX ix_utsl_pid ON task_instance_state_log (process_instance_id);

CREATE INDEX ix_utsl_state ON task_instance_state_log (state);

CREATE INDEX ix_utsl_utid ON task_instance_state_log (user_task_instance_id);

ALTER TABLE process_instance_state_roles_log
    ADD CONSTRAINT fk_process_instance_state_pid FOREIGN KEY (process_instance_state_log_id) REFERENCES process_instance_state_log(id);

ALTER TABLE task_instance_assignment_users_log
    ADD CONSTRAINT fk_task_instance_assignment_log_tid FOREIGN KEY (task_instance_assignment_log_id) REFERENCES task_instance_assignment_log(id);

ALTER TABLE task_instance_deadline_notification_log
    ADD CONSTRAINT fk_task_instance_deadline_tid FOREIGN KEY (task_instance_deadline_log_id) REFERENCES task_instance_deadline_log(id);
