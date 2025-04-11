CREATE TABLE jbpm_user_tasks (
    id VARCHAR2(50) NOT NULL,
    user_task_id VARCHAR2(255),
    task_priority VARCHAR2(50),
    actual_owner VARCHAR2(255),
    task_description VARCHAR2(255),
    status VARCHAR2(255),
    termination_type VARCHAR2(255),
    external_reference_id VARCHAR2(255),
    task_name VARCHAR2(255)
);

CREATE TABLE jbpm_user_tasks_potential_users (
    task_id VARCHAR2(50) NOT NULL,
    user_id VARCHAR2(255) NOT NULL
);

CREATE TABLE jbpm_user_tasks_potential_groups (
    task_id VARCHAR2(50) NOT NULL,
    group_id VARCHAR2(255) NOT NULL
);

CREATE TABLE jbpm_user_tasks_admin_users (
    task_id VARCHAR2(50) NOT NULL,
    user_id VARCHAR2(255) NOT NULL
);

CREATE TABLE jbpm_user_tasks_admin_groups (
    task_id VARCHAR2(50) NOT NULL,
    group_id VARCHAR2(255) NOT NULL
);

CREATE TABLE jbpm_user_tasks_excluded_users (
    task_id VARCHAR2(50) NOT NULL,
    user_id VARCHAR2(255) NOT NULL
);

CREATE TABLE jbpm_user_tasks_attachments (
    id VARCHAR2(50) NOT NULL,
    name VARCHAR2(255),
    updated_by VARCHAR2(255),
    updated_at timestamp(6),
    url VARCHAR2(255),
    task_id VARCHAR2(50) NOT NULL
);

CREATE TABLE jbpm_user_tasks_comments (
    id VARCHAR2(50) NOT NULL,
    updated_by VARCHAR2(255),
    updated_at timestamp(6),
    task_comment VARCHAR2(1000),
    task_id VARCHAR2(50) NOT NULL
);

CREATE TABLE jbpm_user_tasks_inputs (
    task_id VARCHAR2(50) NOT NULL,
    input_name VARCHAR2(255) NOT NULL,
    input_value BLOB,
    java_type VARCHAR2(255)
);

CREATE TABLE jbpm_user_tasks_outputs (
    task_id VARCHAR2(50) NOT NULL,
    output_name VARCHAR2(255) NOT NULL,
    output_value BLOB,
    java_type VARCHAR2(255)
);

CREATE TABLE jbpm_user_tasks_metadata (
    task_id VARCHAR2(50),
    metadata_name VARCHAR2(255) NOT NULL,
    metadata_value VARCHAR2(512),
    java_type VARCHAR2(255)
);

CREATE TABLE jbpm_user_tasks_deadline (
    id NUMBER(10),
    task_id VARCHAR2(50) NOT NULL,
    notification_type VARCHAR2(255) NOT NULL,
    notification_value BLOB,
    java_type VARCHAR2(255)
);

CREATE TABLE jbpm_user_tasks_reassignment (
    id NUMBER(10),
    task_id VARCHAR2(50) NOT NULL,
    reassignment_type VARCHAR2(255) NOT NULL,
    reassignment_value BLOB,
    java_type VARCHAR2(255)
);

CREATE TABLE jbpm_user_tasks_deadline_timer (
    task_id VARCHAR2(50) NOT NULL,
    notification_job_id VARCHAR2(255) NOT NULL,
    notification_type VARCHAR2(255) NOT NULL,
    notification_value BLOB,
    java_type VARCHAR2(255)
);

CREATE TABLE jbpm_user_tasks_reassignment_timer (
    task_id VARCHAR2(50) NOT NULL,
    reassignment_job_id VARCHAR2(255) NOT NULL,
    reassignment_type VARCHAR2(255) NOT NULL,
    reassignment_value BLOB,
    java_type VARCHAR2(255)
);

ALTER TABLE jbpm_user_tasks
    ADD CONSTRAINT jbpm_user_tasks_pkey PRIMARY KEY (id);

ALTER TABLE jbpm_user_tasks_potential_users
    ADD CONSTRAINT jbpm_user_tasks_potential_users_pkey PRIMARY KEY (task_id, user_id);

ALTER TABLE jbpm_user_tasks_potential_groups
    ADD CONSTRAINT jbpm_user_tasks_potential_groups_pkey PRIMARY KEY (task_id, group_id);

ALTER TABLE jbpm_user_tasks_admin_users
    ADD CONSTRAINT jbpm_user_tasks_admin_users_pkey PRIMARY KEY (task_id, user_id);

ALTER TABLE jbpm_user_tasks_admin_groups
    ADD CONSTRAINT jbpm_user_tasks_admin_groups_pkey PRIMARY KEY (task_id, group_id);

ALTER TABLE jbpm_user_tasks_excluded_users
    ADD CONSTRAINT jbpm_user_tasks_excluded_users_pkey PRIMARY KEY (task_id, user_id);

ALTER TABLE jbpm_user_tasks_attachments
    ADD CONSTRAINT jbpm_user_tasks_attachments_pkey PRIMARY KEY (id);

ALTER TABLE jbpm_user_tasks_comments
    ADD CONSTRAINT jbpm_user_tasks_comments_pkey PRIMARY KEY (id);

ALTER TABLE jbpm_user_tasks_inputs
    ADD CONSTRAINT jbpm_user_tasks_inputs_pkey PRIMARY KEY (task_id, input_name);

ALTER TABLE jbpm_user_tasks_outputs
    ADD CONSTRAINT jbpm_user_tasks_outputs_pkey PRIMARY KEY (task_id, output_name);

ALTER TABLE jbpm_user_tasks_metadata
    ADD CONSTRAINT jbpm_user_tasks_metadata_pkey PRIMARY KEY (task_id, metadata_name);

ALTER TABLE jbpm_user_tasks_deadline
    ADD CONSTRAINT jbpm_user_tasks_deadline_pkey PRIMARY KEY (id);

ALTER TABLE jbpm_user_tasks_reassignment
    ADD CONSTRAINT jbpm_user_tasks_reassignment_pkey PRIMARY KEY (id);

ALTER TABLE jbpm_user_tasks_deadline_timer
    ADD CONSTRAINT jbpm_user_tasks_deadline_timer_pkey PRIMARY KEY (task_id, notification_job_id);

ALTER TABLE jbpm_user_tasks_reassignment_timer
    ADD CONSTRAINT jbpm_user_tasks_reassignment_timer_pkey PRIMARY KEY (task_id, reassignment_job_id);

ALTER TABLE jbpm_user_tasks_potential_users
    ADD CONSTRAINT fk_jbpm_user_fk_tasks_potential_users_tid FOREIGN KEY (task_id)  REFERENCES jbpm_user_tasks(id) ON DELETE CASCADE;

ALTER TABLE jbpm_user_tasks_potential_groups
    ADD CONSTRAINT fk_jbpm_user_tasks_potential_groups_tid FOREIGN KEY (task_id)  REFERENCES jbpm_user_tasks(id) ON DELETE CASCADE;

ALTER TABLE jbpm_user_tasks_admin_users
    ADD CONSTRAINT fk_jbpm_user_tasks_admin_users_tid FOREIGN KEY (task_id)  REFERENCES jbpm_user_tasks(id) ON DELETE CASCADE;

ALTER TABLE jbpm_user_tasks_admin_groups
    ADD CONSTRAINT fk_jbpm_user_tasks_admin_groups_tid FOREIGN KEY (task_id) REFERENCES jbpm_user_tasks(id) ON DELETE CASCADE;

ALTER TABLE jbpm_user_tasks_excluded_users
    ADD CONSTRAINT fk_jbpm_user_tasks_excluded_users_tid FOREIGN KEY (task_id) REFERENCES jbpm_user_tasks(id) ON DELETE CASCADE;

ALTER TABLE jbpm_user_tasks_attachments
    ADD CONSTRAINT fk_user_tasks_attachments_tid FOREIGN KEY (task_id) REFERENCES jbpm_user_tasks(id) ON DELETE CASCADE;

ALTER TABLE jbpm_user_tasks_comments
    ADD CONSTRAINT fk_user_tasks_comments_tid FOREIGN KEY (task_id) REFERENCES jbpm_user_tasks(id) ON DELETE CASCADE;

ALTER TABLE jbpm_user_tasks_inputs
    ADD CONSTRAINT fk_jbpm_user_tasks_inputs_tid FOREIGN KEY (task_id) REFERENCES jbpm_user_tasks(id) ON DELETE CASCADE;

ALTER TABLE jbpm_user_tasks_outputs
    ADD CONSTRAINT fk_jbpm_user_tasks_outputs_tid FOREIGN KEY (task_id) REFERENCES jbpm_user_tasks(id) ON DELETE CASCADE;

ALTER TABLE jbpm_user_tasks_metadata
    ADD CONSTRAINT fk_jbpm_user_tasks_metadata_tid FOREIGN KEY (task_id) REFERENCES jbpm_user_tasks(id) ON DELETE CASCADE;

ALTER TABLE jbpm_user_tasks_deadline
    ADD CONSTRAINT fk_jbpm_user_tasks_deadline_tid FOREIGN KEY (task_id) REFERENCES jbpm_user_tasks(id) ON DELETE CASCADE;

ALTER TABLE jbpm_user_tasks_reassignment
    ADD CONSTRAINT fk_jbpm_user_tasks_reassignment_tid FOREIGN KEY (task_id) REFERENCES jbpm_user_tasks(id) ON DELETE CASCADE;

ALTER TABLE jbpm_user_tasks_deadline_timer
    ADD CONSTRAINT fk_jbpm_user_tasks_deadline_timer_tid FOREIGN KEY (task_id) REFERENCES jbpm_user_tasks(id) ON DELETE CASCADE;

ALTER TABLE jbpm_user_tasks_reassignment_timer
    ADD CONSTRAINT fk_jbpm_user_tasks_reassignment_timer_tid FOREIGN KEY (task_id) REFERENCES jbpm_user_tasks(id) ON DELETE CASCADE;