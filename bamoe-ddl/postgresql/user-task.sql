--
-- User tasks uses below tables
--

-- TABLE jbpm_user_tasks
CREATE TABLE jbpm_user_tasks (
    id varchar(50) NOT NULL,
    user_task_id varchar(255),
    task_priority varchar(50),
    actual_owner varchar(255),
    task_description varchar(255),
    status varchar(255),
    termination_type varchar(255),
    external_reference_id varchar(255),
    task_name varchar(255)
);

-- TABLE jbpm_user_tasks_potential_users
CREATE TABLE jbpm_user_tasks_potential_users (
    task_id varchar(50) NOT NULL,
    user_id varchar(255) NOT NULL
);

-- TABLE jbpm_user_tasks_potential_groups
CREATE TABLE jbpm_user_tasks_potential_groups (
    task_id varchar(50) NOT NULL,
    group_id varchar(255) NOT NULL
);

-- TABLE jbpm_user_tasks_admin_users
CREATE TABLE jbpm_user_tasks_admin_users (
    task_id varchar(50) NOT NULL,
    user_id varchar(255) NOT NULL
);

-- TABLE jbpm_user_tasks_admin_groups
CREATE TABLE jbpm_user_tasks_admin_groups (
    task_id varchar(50) NOT NULL,
    group_id varchar(255) NOT NULL
);

-- TABLE jbpm_user_tasks_excluded_users
CREATE TABLE jbpm_user_tasks_excluded_users (
    task_id varchar(50) NOT NULL,
    user_id varchar(255) NOT NULL
);

-- TABLE jbpm_user_tasks_attachments
CREATE TABLE jbpm_user_tasks_attachments (
    id varchar(50) NOT NULL,
    name varchar(255),
    updated_by varchar(255),
    updated_at timestamp(6),
    url varchar(255),
    task_id varchar(50) NOT NULL
);

-- TABLE jbpm_user_tasks_comments
CREATE TABLE jbpm_user_tasks_comments (
    id varchar(50) NOT NULL,
    updated_by varchar(255),
    updated_at timestamp(6),
    comment varchar(255),
    task_id varchar(50) NOT NULL
);

-- TABLE jbpm_user_tasks_inputs
CREATE TABLE jbpm_user_tasks_inputs (
    task_id varchar(50) NOT NULL,
    input_name varchar(255) NOT NULL,
    input_value bytea,
    java_type varchar(255)
);

-- TABLE jbpm_user_tasks_outputs
CREATE TABLE jbpm_user_tasks_outputs (
    task_id varchar(50) NOT NULL,
    output_name varchar(255) NOT NULL,
    output_value bytea,
    java_type varchar(255)
);

-- TABLE jbpm_user_tasks_metadata
CREATE TABLE jbpm_user_tasks_metadata (
    task_id varchar(50),
    metadata_name varchar(255) NOT NULL,
    metadata_value varchar(512),
    java_type varchar(255)
);

ALTER TABLE ONLY jbpm_user_tasks
    ADD CONSTRAINT jbpm_user_tasks_pkey PRIMARY KEY (id);

ALTER TABLE ONLY jbpm_user_tasks_potential_users
    ADD CONSTRAINT jbpm_user_tasks_potential_users_pkey PRIMARY KEY (task_id, user_id);

ALTER TABLE ONLY jbpm_user_tasks_potential_groups
    ADD CONSTRAINT jbpm_user_tasks_potential_groups_pkey PRIMARY KEY (task_id, group_id);

ALTER TABLE ONLY jbpm_user_tasks_admin_users
    ADD CONSTRAINT jbpm_user_tasks_admin_users_pkey PRIMARY KEY (task_id, user_id);

ALTER TABLE ONLY jbpm_user_tasks_admin_groups
    ADD CONSTRAINT jbpm_user_tasks_admin_groups_pkey PRIMARY KEY (task_id, group_id);

ALTER TABLE ONLY jbpm_user_tasks_excluded_users
    ADD CONSTRAINT jbpm_user_tasks_excluded_users_pkey PRIMARY KEY (task_id, user_id);

ALTER TABLE ONLY jbpm_user_tasks_attachments
    ADD CONSTRAINT jbpm_user_tasks_attachments_pkey PRIMARY KEY (id);

ALTER TABLE ONLY jbpm_user_tasks_comments
    ADD CONSTRAINT jbpm_user_tasks_comments_pkey PRIMARY KEY (id);

ALTER TABLE ONLY jbpm_user_tasks_inputs
    ADD CONSTRAINT jbpm_user_tasks_inputs_pkey PRIMARY KEY (task_id, input_name);

ALTER TABLE ONLY jbpm_user_tasks_outputs
    ADD CONSTRAINT jbpm_user_tasks_outputs_pkey PRIMARY KEY (task_id, output_name);

ALTER TABLE ONLY jbpm_user_tasks_metadata
    ADD CONSTRAINT jbpm_user_tasks_metadata_pkey PRIMARY KEY (task_id, metadata_name);








alter table if exists jbpm_user_tasks_potential_users
drop constraint if exists fk_jbpm_user_tasks_potential_users_tid cascade;

alter table if exists jbpm_user_tasks_potential_users
    add constraint fk_jbpm_user_fk_tasks_potential_users_tid foreign key (task_id) references jbpm_user_tasks(id) on delete cascade;

alter table if exists jbpm_user_potential_groups
drop constraint if exists fk_jbpm_user_tasks_potential_groups_tid cascade;

alter table if exists jbpm_user_tasks_potential_groups
    add constraint fk_jbpm_user_tasks_potential_groups_tid foreign key (task_id) references jbpm_user_tasks(id) on delete cascade;

alter table if exists jbpm_user_tasks_admin_users
drop constraint if exists fk_jbpm_user_tasks_admin_users_tid cascade;

alter table if exists jbpm_user_tasks_admin_users
    add constraint fk_jbpm_user_tasks_admin_users_tid foreign key (task_id) references jbpm_user_tasks(id) on delete cascade;

alter table if exists jbpm_user_tasks_admin_groups
drop constraint if exists fk_jbpm_user_tasks_admin_groups_tid cascade;

alter table if exists jbpm_user_tasks_admin_groups
    add constraint fk_jbpm_user_tasks_admin_groups_tid foreign key (task_id) references jbpm_user_tasks(id) on delete cascade;

alter table if exists jbpm_user_tasks_excluded_users
drop constraint if exists fk_jbpm_user_tasks_excluded_users_tid cascade;

alter table if exists jbpm_user_tasks_excluded_users
    add constraint fk_jbpm_user_tasks_excluded_users_tid foreign key (task_id) references jbpm_user_tasks(id) on delete cascade;

alter table if exists jbpm_user_tasks_attachments
drop constraint if exists fk_user_task_attachment_tid cascade;

alter table if exists jbpm_user_tasks_attachments
    add constraint fk_user_task_attachment_tid foreign key (task_id) references jbpm_user_tasks(id) on delete cascade;

alter table if exists jbpm_user_tasks_comments
drop constraint if exists fk_user_task_comment_tid cascade;

alter table if exists jbpm_user_tasks_comments
    add constraint fk_user_task_comment_tid foreign key (task_id) references jbpm_user_tasks(id) on delete cascade;

alter table if exists jbpm_user_tasks_inputs
drop constraint if exists fk_jbpm_user_tasks_inputs_tid cascade;

alter table if exists jbpm_user_tasks_inputs
    add constraint fk_jbpm_user_tasks_inputs_tid foreign key (task_id) references jbpm_user_tasks(id) on delete cascade;

alter table if exists jbpm_user_tasks_outputs
drop constraint if exists fk_jbpm_user_tasks_outputs_tid cascade;

alter table if exists jbpm_user_tasks_outputs
    add constraint fk_jbpm_user_tasks_outputs_tid foreign key (task_id) references jbpm_user_tasks(id) on delete cascade;

alter table if exists jbpm_user_tasks_metadata
drop constraint if exists fk_jbpm_user_tasks_metadata_tid cascade;

alter table if exists jbpm_user_tasks_metadata
    add constraint fk_jbpm_user_tasks_metadata_tid foreign key (task_id) references jbpm_user_tasks(id) on delete cascade;