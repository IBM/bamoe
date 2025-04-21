
CREATE TABLE audit_query (
    identifier VARCHAR2(255) NOT NULL,
    graph_ql_definition CLOB,
    query CLOB,
    CONSTRAINT audit_query_pkey PRIMARY KEY (identifier)
);

CREATE SEQUENCE job_execution_history_id_seq
    START WITH 1
    INCREMENT BY 50
    CACHE 50;

CREATE TABLE job_execution_log (
    id NUMBER(19) NOT NULL,
    event_date timestamp(6),
    execution_counter integer,
    expiration_time timestamp(6),
    job_id VARCHAR2(255),
    node_instance_id VARCHAR2(255),
    priority integer,
    process_instance_id VARCHAR2(255),
    repeat_interval NUMBER(19),
    repeat_limit integer,
    retries integer,
    scheduled_id VARCHAR2(255),
    status VARCHAR2(255),
    CONSTRAINT job_execution_log_pkey PRIMARY KEY (id)
);

CREATE TABLE process_instance_error_log (
    id NUMBER(19) NOT NULL,
    business_key VARCHAR2(255),
    event_date timestamp(6),
    event_id VARCHAR2(255),
    parent_process_instance_id VARCHAR2(255),
    process_id VARCHAR2(255),
    process_instance_id VARCHAR2(255),
    process_type VARCHAR2(255),
    process_version VARCHAR2(255),
    root_process_id VARCHAR2(255),
    root_process_instance_id VARCHAR2(255),
    error_message VARCHAR2(255),
    node_definition_id VARCHAR2(255),
    node_instance_id VARCHAR2(255),
    CONSTRAINT process_instance_error_log_pkey PRIMARY KEY (id)
);

CREATE SEQUENCE process_instance_error_log_seq_id
    START WITH 1
    INCREMENT BY 50
    CACHE 50;

CREATE TABLE process_instance_node_log (
    id NUMBER(19) NOT NULL,
    business_key VARCHAR2(255),
    event_date timestamp(6),
    event_id VARCHAR2(255),
    parent_process_instance_id VARCHAR2(255),
    process_id VARCHAR2(255),
    process_instance_id VARCHAR2(255),
    process_type VARCHAR2(255),
    process_version VARCHAR2(255),
    root_process_id VARCHAR2(255),
    root_process_instance_id VARCHAR2(255),
    connection VARCHAR2(255),
    event_data VARCHAR2(255),
    event_type VARCHAR2(255),
    node_definition_id VARCHAR2(255),
    node_instance_id VARCHAR2(255),
    node_name VARCHAR2(255),
    node_type VARCHAR2(255),
    sla_due_date timestamp(6),
    work_item_id VARCHAR2(255),
    CONSTRAINT process_instance_node_log_event_type_check CHECK (event_type IN ('ENTER', 'EXIT', 'ABORTED', 'ASYNC_ENTER', 'OBSOLETE', 'SKIPPED', 'ERROR', 'SLA_VIOLATION')),
    CONSTRAINT process_instance_node_log_pkey PRIMARY KEY (id)
);

CREATE SEQUENCE process_instance_node_log_id_seq
    START WITH 1
    INCREMENT BY 50
    CACHE 50;

CREATE TABLE process_instance_state_log (
    id NUMBER(19) NOT NULL,
    business_key VARCHAR2(255),
    event_date timestamp(6),
    event_id VARCHAR2(255),
    parent_process_instance_id VARCHAR2(255),
    process_id VARCHAR2(255),
    process_instance_id VARCHAR2(255),
    process_type VARCHAR2(255),
    process_version VARCHAR2(255),
    root_process_id VARCHAR2(255),
    root_process_instance_id VARCHAR2(255),
    event_type VARCHAR2(255) NOT NULL,
    outcome VARCHAR2(255),
    sla_due_date timestamp(6),
    state VARCHAR2(255),
    CONSTRAINT process_instance_state_log_event_type_check CHECK (event_type IN ('ACTIVE', 'COMPLETED', 'SLA_VIOLATION', 'MIGRATED')),
    CONSTRAINT process_instance_state_log_pkey PRIMARY KEY (id)
);

CREATE SEQUENCE process_instance_state_log_id_seq
    START WITH 1
    INCREMENT BY 50
    CACHE 50;

CREATE TABLE process_instance_state_roles_log (
    process_instance_state_log_id NUMBER(19) NOT NULL,
    role VARCHAR2(255),
    CONSTRAINT fk_process_instance_state_pid FOREIGN KEY (process_instance_state_log_id) REFERENCES process_instance_state_log(id)
);

CREATE TABLE process_instance_variable_log (
    id NUMBER(19) NOT NULL,
    business_key VARCHAR2(255),
    event_date timestamp(6),
    event_id VARCHAR2(255),
    parent_process_instance_id VARCHAR2(255),
    process_id VARCHAR2(255),
    process_instance_id VARCHAR2(255),
    process_type VARCHAR2(255),
    process_version VARCHAR2(255),
    root_process_id VARCHAR2(255),
    root_process_instance_id VARCHAR2(255),
    variable_id VARCHAR2(255),
    variable_name VARCHAR2(255),
    variable_value CLOB,
    CONSTRAINT process_instance_variable_log_pkey PRIMARY KEY (id)
);

CREATE SEQUENCE process_instance_variable_log_id_seq
    START WITH 1
    INCREMENT BY 50
    CACHE 50;

CREATE TABLE task_instance_assignment_log (
    id NUMBER(19) NOT NULL,
    business_key VARCHAR2(255),
    event_date timestamp(6),
    event_id VARCHAR2(255),
    event_user VARCHAR2(255),
    process_instance_id VARCHAR2(255),
    user_task_definition_id VARCHAR2(255),
    user_task_instance_id VARCHAR2(255),
    assignment_type VARCHAR2(255),
    task_name VARCHAR2(255),
    CONSTRAINT task_instance_assignment_log_pkey PRIMARY KEY (id)
);

CREATE SEQUENCE task_instance_assignment_log_id_seq
    START WITH 1
    INCREMENT BY 50
    CACHE 50;

CREATE TABLE task_instance_assignment_users_log (
    task_instance_assignment_log_id NUMBER(19) NOT NULL,
    user_id VARCHAR2(255),
    CONSTRAINT fk_task_instance_assignment_log_tid FOREIGN KEY (task_instance_assignment_log_id) REFERENCES task_instance_assignment_log(id)
);

CREATE TABLE task_instance_attachment_log (
    id NUMBER(19) NOT NULL,
    business_key VARCHAR2(255),
    event_date timestamp(6),
    event_id VARCHAR2(255),
    event_user VARCHAR2(255),
    process_instance_id VARCHAR2(255),
    user_task_definition_id VARCHAR2(255),
    user_task_instance_id VARCHAR2(255),
    attachment_id VARCHAR2(255),
    attachment_name VARCHAR2(255),
    attachment_uri VARCHAR2(255),
    event_type integer,
    CONSTRAINT task_instance_attachment_log_pkey PRIMARY KEY (id)
);

CREATE SEQUENCE task_instance_attachment_log_id_seq
    START WITH 1
    INCREMENT BY 50
    CACHE 50;

CREATE TABLE task_instance_comment_log (
    id NUMBER(19) NOT NULL,
    business_key VARCHAR2(255),
    event_date timestamp(6),
    event_id VARCHAR2(255),
    event_user VARCHAR2(255),
    process_instance_id VARCHAR2(255),
    user_task_definition_id VARCHAR2(255),
    user_task_instance_id VARCHAR2(255),
    comment_content VARCHAR2(1000),
    comment_id VARCHAR2(255),
    event_type integer,
    CONSTRAINT task_instance_comment_log_pkey PRIMARY KEY (id)
);

CREATE SEQUENCE task_instance_comment_log_id_seq
    START WITH 1
    INCREMENT BY 50
    CACHE 50;

CREATE TABLE task_instance_deadline_log (
    id NUMBER(19) NOT NULL,
    business_key VARCHAR2(255),
    event_date timestamp(6),
    event_id VARCHAR2(255),
    event_user VARCHAR2(255),
    process_instance_id VARCHAR2(255),
    user_task_definition_id VARCHAR2(255),
    user_task_instance_id VARCHAR2(255),
    event_type VARCHAR2(255),
    CONSTRAINT task_instance_deadline_log_pkey PRIMARY KEY (id)
);

CREATE SEQUENCE task_instance_deadline_log_id_seq
    START WITH 1
    INCREMENT BY 50
    CACHE 50;

CREATE TABLE task_instance_deadline_notification_log (
    task_instance_deadline_log_id NUMBER(19) NOT NULL,
    property_value VARCHAR2(255),
    property_name VARCHAR2(255) NOT NULL,
    CONSTRAINT task_instance_deadline_notification_log_pkey PRIMARY KEY (task_instance_deadline_log_id, property_name),
    CONSTRAINT fk_task_instance_deadline_tid FOREIGN KEY (task_instance_deadline_log_id) REFERENCES task_instance_deadline_log(id)
);

CREATE TABLE task_instance_state_log (
    id NUMBER(19) NOT NULL,
    business_key VARCHAR2(255),
    event_date timestamp(6),
    event_id VARCHAR2(255),
    event_user VARCHAR2(255),
    process_instance_id VARCHAR2(255),
    user_task_definition_id VARCHAR2(255),
    user_task_instance_id VARCHAR2(255),
    actual_user VARCHAR2(255),
    description VARCHAR2(255),
    event_type VARCHAR2(255),
    name VARCHAR2(255),
    state VARCHAR2(255),
    CONSTRAINT task_instance_state_log_pkey PRIMARY KEY (id)
);

CREATE SEQUENCE task_instance_state_log_id_seq
    START WITH 1
    INCREMENT BY 50
    CACHE 50;

CREATE TABLE task_instance_variable_log (
    id NUMBER(19) NOT NULL,
    business_key VARCHAR2(255),
    event_date timestamp(6),
    event_id VARCHAR2(255),
    event_user VARCHAR2(255),
    process_instance_id VARCHAR2(255),
    user_task_definition_id VARCHAR2(255),
    user_task_instance_id VARCHAR2(255),
    variable_id VARCHAR2(255),
    variable_name VARCHAR2(255),
    variable_type VARCHAR2(255),
    variable_value CLOB,
    CONSTRAINT task_instance_variable_log_variable_type_check CHECK (variable_type IN ('INPUT', 'OUTPUT')),
    CONSTRAINT task_instance_variable_log_pkey PRIMARY KEY (id)
);

CREATE SEQUENCE task_instance_variable_log_id_seq
    START WITH 1
    INCREMENT BY 50
    CACHE 50;

CREATE INDEX ix_jel_jid ON job_execution_log  (job_id);

CREATE INDEX ix_jel_pid ON job_execution_log  (process_instance_id);

CREATE INDEX ix_jel_status ON job_execution_log  (status);

CREATE INDEX ix_piel_event_date ON process_instance_error_log  (event_date);

CREATE INDEX ix_piel_key ON process_instance_error_log  (business_key);

CREATE INDEX ix_piel_pid ON process_instance_error_log  (process_instance_id);

CREATE INDEX ix_pinl_event_date ON process_instance_node_log  (event_date);

CREATE INDEX ix_pinl_key ON process_instance_node_log  (business_key);

CREATE INDEX ix_pinl_pid ON process_instance_node_log  (process_instance_id);

CREATE INDEX ix_pisl_event_date ON process_instance_state_log  (event_date);

CREATE INDEX ix_pisl_key ON process_instance_state_log  (business_key);

CREATE INDEX ix_pisl_pid ON process_instance_state_log  (process_instance_id);

CREATE INDEX ix_pisl_state ON process_instance_state_log  (state);

CREATE INDEX ix_pivl_event_date ON process_instance_variable_log  (event_date);

CREATE INDEX ix_pivl_key ON process_instance_variable_log  (business_key);

CREATE INDEX ix_pivl_pid ON process_instance_variable_log  (process_instance_id);

CREATE INDEX ix_pivl_var_id ON process_instance_variable_log  (variable_id);

CREATE INDEX ix_tavl_event_date ON task_instance_variable_log  (event_date);

CREATE INDEX ix_tavl_key ON task_instance_variable_log  (business_key);

CREATE INDEX ix_tavl_pid ON task_instance_variable_log  (process_instance_id);

CREATE INDEX ix_tavl_utid ON task_instance_variable_log  (user_task_instance_id);

CREATE INDEX ix_utasl_event_date ON task_instance_assignment_log  (event_date);

CREATE INDEX ix_utasl_key ON task_instance_assignment_log  (business_key);

CREATE INDEX ix_utasl_pid ON task_instance_assignment_log  (process_instance_id);

CREATE INDEX ix_utasl_utid ON task_instance_assignment_log  (user_task_instance_id);

CREATE INDEX ix_utatl_event_date ON task_instance_attachment_log  (event_date);

CREATE INDEX ix_utatl_key ON task_instance_attachment_log  (business_key);

CREATE INDEX ix_utatl_pid ON task_instance_attachment_log  (process_instance_id);

CREATE INDEX ix_utatl_utid ON task_instance_attachment_log  (user_task_instance_id);

CREATE INDEX ix_utcl_event_date ON task_instance_comment_log  (event_date);

CREATE INDEX ix_utcl_key ON task_instance_comment_log  (business_key);

CREATE INDEX ix_utcl_pid ON task_instance_comment_log  (process_instance_id);

CREATE INDEX ix_utcl_utid ON task_instance_comment_log  (user_task_instance_id);

CREATE INDEX ix_utdl_event_date ON task_instance_deadline_log  (event_date);

CREATE INDEX ix_utdl_key ON task_instance_deadline_log  (business_key);

CREATE INDEX ix_utdl_pid ON task_instance_deadline_log  (process_instance_id);

CREATE INDEX ix_utdl_utid ON task_instance_deadline_log  (user_task_instance_id);

CREATE INDEX ix_utsl_event_date ON task_instance_state_log  (event_date);

CREATE INDEX ix_utsl_key ON task_instance_state_log  (business_key);

CREATE INDEX ix_utsl_pid ON task_instance_state_log  (process_instance_id);

CREATE INDEX ix_utsl_state ON task_instance_state_log  (state);

CREATE INDEX ix_utsl_utid ON task_instance_state_log  (user_task_instance_id);
