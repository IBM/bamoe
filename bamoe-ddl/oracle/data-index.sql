--
-- Data index uses below tables
--

-- TABLE attachments: user task instance attachments
CREATE TABLE attachments (
    id VARCHAR2(255) NOT NULL,
    content VARCHAR2(255),
    name VARCHAR2(255),
    updated_at timestamp,
    updated_by VARCHAR2(255),
    task_id VARCHAR2(255) NOT NULL
);

-- TABLE comments: user task instance comments
CREATE TABLE comments (
    id VARCHAR2(255) NOT NULL,
    content VARCHAR2(1000),
    updated_at timestamp,
    updated_by VARCHAR2(255),
    task_id VARCHAR2(255) NOT NULL
);

-- TABLE definitions: process definitions that has been deployed
CREATE TABLE definitions (
    id VARCHAR2(255) NOT NULL,
    version VARCHAR2(255) NOT NULL,
    name VARCHAR2(255),
    type VARCHAR2(255),
    source BLOB,
    endpoint VARCHAR2(255),
    description VARCHAR2(255),
    metadata JSON
);

-- TABLE definitions_addons: addons those process definitions were deployed with
CREATE TABLE definitions_addons (
    process_id VARCHAR2(255) NOT NULL,
    process_version VARCHAR2(255) NOT NULL,
    addon VARCHAR2(255) NOT NULL
);

-- TABLE definitions_annotations
CREATE TABLE definitions_annotations (
    annotation VARCHAR2(255) NOT NULL,
    process_id VARCHAR2(255) NOT NULL,
    process_version VARCHAR2(255) NOT NULL
);

-- TABLE definitions_nodes: last definitions of node executed by a process instance
CREATE TABLE definitions_nodes (
    id VARCHAR2(255) NOT NULL,
    name VARCHAR2(255),
    unique_id VARCHAR2(255),
    type VARCHAR2(255),
    process_id VARCHAR2(255) NOT NULL,
    process_version VARCHAR2(255) NOT NULL
);

-- TABLE definitions_nodes_metadata
CREATE TABLE definitions_nodes_metadata (
    node_id VARCHAR2(255) NOT NULL,
    process_id VARCHAR2(255) NOT NULL,
    process_version VARCHAR2(255) NOT NULL,
    meta_value VARCHAR2(255),
    name VARCHAR2(255) NOT NULL
);

-- TABLE definitions_roles
CREATE TABLE definitions_roles (
    process_id VARCHAR2(255) NOT NULL,
    process_version VARCHAR2(255) NOT NULL,
    role VARCHAR2(255) NOT NULL
);

-- TABLE jobs: timers created by runtime
CREATE TABLE jobs (
    id VARCHAR2(255) NOT NULL,
    callback_endpoint VARCHAR2(255),
    endpoint VARCHAR2(255),
    execution_counter integer,
    expiration_time timestamp,
    last_update timestamp,
    node_instance_id VARCHAR2(255),
    priority integer,
    process_id VARCHAR2(255),
    process_instance_id VARCHAR2(255),
    repeat_interval NUMBER(19),
    repeat_limit integer,
    retries integer,
    root_process_id VARCHAR2(255),
    root_process_instance_id VARCHAR2(255),
    scheduled_id VARCHAR2(255),
    status VARCHAR2(255)
);

-- TABLE jobs: kogito_data_cache
CREATE TABLE kogito_data_cache (
    var_name VARCHAR2(255) NOT NULL,
    cache_name VARCHAR2(255) NOT NULL,
    json_value JSON
);

-- TABLE milestones: special type of node that is completed through a condition (comes from cmmn)
CREATE TABLE milestones (
    id VARCHAR2(255) NOT NULL,
    process_instance_id VARCHAR2(255) NOT NULL,
    name VARCHAR2(255),
    status VARCHAR2(255)
);

-- TABLE nodes: nodes executed by the process instance
CREATE TABLE nodes (
    id VARCHAR2(255) NOT NULL,
    definition_id VARCHAR2(255),
    enter timestamp,
    exit timestamp,
    name VARCHAR2(255),
    node_id VARCHAR2(255),
    type VARCHAR2(255),
    process_instance_id VARCHAR2(255) NOT NULL,
    sla_due_date timestamp
);

-- TABLE processes: last state of the process instance
CREATE TABLE processes (
    id VARCHAR2(255) NOT NULL,
    business_key VARCHAR2(255),
    end_time timestamp,
    endpoint VARCHAR2(255),
    message CLOB,
    node_definition_id VARCHAR2(255),
    last_update_time timestamp,
    parent_process_instance_id VARCHAR2(255),
    process_id VARCHAR2(255),
    process_name VARCHAR2(255),
    root_process_id VARCHAR2(255),
    root_process_instance_id VARCHAR2(255),
    start_time timestamp,
    state NUMBER(10),
    variables JSON,
    version VARCHAR2(255),
    created_by CLOB,
    updated_by CLOB,
    sla_due_date timestamp
);

-- TABLE processes_addons: addons this process instance is being executed with
CREATE TABLE processes_addons (
    process_id VARCHAR2(255) NOT NULL,
    addon VARCHAR2(255) NOT NULL
);

-- TABLE processes_roles: roles this process instance requires
CREATE TABLE processes_roles (
    process_id VARCHAR2(255) NOT NULL,
    role VARCHAR2(255) NOT NULL
);

-- TABLE tasks: user task instance last state
CREATE TABLE tasks (
    id VARCHAR2(255) NOT NULL,
    actual_owner VARCHAR2(255),
    completed timestamp,
    description VARCHAR2(255),
    endpoint VARCHAR2(255),
    inputs JSON,
    last_update timestamp,
    name VARCHAR2(255),
    outputs JSON,
    priority VARCHAR2(255),
    process_id VARCHAR2(255),
    process_instance_id VARCHAR2(255),
    reference_name VARCHAR2(255),
    root_process_id VARCHAR2(255),
    root_process_instance_id VARCHAR2(255),
    started timestamp,
    state VARCHAR2(255),
    external_reference_id VARCHAR2(4000),
    sla_due_date timestamp
);

-- TABLE tasks_admin_groups: user task instance admin groups assigned
CREATE TABLE tasks_admin_groups (
    task_id VARCHAR2(255) NOT NULL,
    group_id VARCHAR2(255) NOT NULL
);

-- TABLE tasks_admin_users: user task instance admin user assigned
CREATE TABLE tasks_admin_users (
    task_id VARCHAR2(255) NOT NULL,
    user_id VARCHAR2(255) NOT NULL
);

-- TABLE tasks_excluded_users: user task instance excluded users
CREATE TABLE tasks_excluded_users (
    task_id VARCHAR2(255) NOT NULL,
    user_id VARCHAR2(255) NOT NULL
);

-- TABLE tasks_potential_groups: user task instance potential groups
CREATE TABLE tasks_potential_groups (
    task_id VARCHAR2(255) NOT NULL,
    group_id VARCHAR2(255) NOT NULL
);

-- TABLE tasks_potential_users: user task instance potential users
CREATE TABLE tasks_potential_users (
    task_id VARCHAR2(255) NOT NULL,
    user_id VARCHAR2(255) NOT NULL
);

CREATE TABLE definitions_metadata (
    process_id VARCHAR2(255) NOT NULL,
    process_version VARCHAR2(255) NOT NULL,
    meta_value VARCHAR2(255),
    name VARCHAR2(255) NOT NULL
);

ALTER TABLE attachments
    ADD CONSTRAINT attachments_pkey PRIMARY KEY (id);

ALTER TABLE comments
    ADD CONSTRAINT comments_pkey PRIMARY KEY (id);

ALTER TABLE definitions_addons
    ADD CONSTRAINT definitions_addons_pkey PRIMARY KEY (process_id, process_version, addon);

ALTER TABLE definitions_annotations
    ADD CONSTRAINT definitions_annotations_pkey PRIMARY KEY (annotation, process_id, process_version);

ALTER TABLE definitions_metadata
    ADD CONSTRAINT definitions_metadata_pkey PRIMARY KEY (process_id, process_version, name);

ALTER TABLE definitions_nodes_metadata
    ADD CONSTRAINT definitions_nodes_metadata_pkey PRIMARY KEY (node_id, process_id, process_version, name);

ALTER TABLE definitions_nodes
    ADD CONSTRAINT definitions_nodes_pkey PRIMARY KEY (id, process_id, process_version);

ALTER TABLE definitions
    ADD CONSTRAINT definitions_pkey PRIMARY KEY (id, version);

ALTER TABLE definitions_roles
    ADD CONSTRAINT definitions_roles_pkey PRIMARY KEY (process_id, process_version, role);

ALTER TABLE jobs
    ADD CONSTRAINT jobs_pkey PRIMARY KEY (id);

ALTER TABLE kogito_data_cache
    ADD CONSTRAINT kogito_data_cache_pkey PRIMARY KEY (var_name, cache_name);

ALTER TABLE milestones
    ADD CONSTRAINT milestones_pkey PRIMARY KEY (id, process_instance_id);

ALTER TABLE nodes
    ADD CONSTRAINT nodes_pkey PRIMARY KEY (id);

ALTER TABLE processes_addons
    ADD CONSTRAINT processes_addons_pkey PRIMARY KEY (process_id, addon);

ALTER TABLE processes
    ADD CONSTRAINT processes_pkey PRIMARY KEY (id);

ALTER TABLE processes_roles
    ADD CONSTRAINT processes_roles_pkey PRIMARY KEY (process_id, role);

ALTER TABLE tasks_admin_groups
    ADD CONSTRAINT tasks_admin_groups_pkey PRIMARY KEY (task_id, group_id);

ALTER TABLE tasks_admin_users
    ADD CONSTRAINT tasks_admin_users_pkey PRIMARY KEY (task_id, user_id);

ALTER TABLE tasks_excluded_users
    ADD CONSTRAINT tasks_excluded_users_pkey PRIMARY KEY (task_id, user_id);

ALTER TABLE tasks
    ADD CONSTRAINT tasks_pkey PRIMARY KEY (id);

ALTER TABLE tasks_potential_groups
    ADD CONSTRAINT tasks_potential_groups_pkey PRIMARY KEY (task_id, group_id);

ALTER TABLE tasks_potential_users
    ADD CONSTRAINT tasks_potential_users_pkey PRIMARY KEY (task_id, user_id);

CREATE INDEX idx_attachments_tid ON attachments  btree (task_id);

CREATE INDEX idx_comments_tid ON comments  btree (task_id);

CREATE INDEX idx_definitions_addons_pid_pv ON definitions_addons  btree (process_id, process_version);

CREATE INDEX idx_definitions_annotations_pid_pv ON definitions_annotations  btree (process_id, process_version);

CREATE INDEX idx_definitions_metadata_pid_pv ON definitions_metadata  btree (process_id, process_version);

CREATE INDEX idx_definitions_nodes_metadata_pid_pv ON definitions_nodes_metadata  btree (process_id, process_version);

CREATE INDEX idx_definitions_nodes_pid_pv ON definitions_nodes  btree (process_id, process_version);

CREATE INDEX idx_definitions_roles_pid_pv ON definitions_roles  btree (process_id, process_version);

CREATE INDEX idx_milestones_piid ON milestones  btree (process_instance_id);

CREATE INDEX idx_nodes_piid ON nodes  btree (process_instance_id);

CREATE INDEX idx_processes_addons_pid ON processes_addons  btree (process_id);

CREATE INDEX idx_processes_roles_pid ON processes_roles  btree (process_id);

CREATE INDEX idx_tasks_admin_groups_tid ON tasks_admin_groups  btree (task_id);

CREATE INDEX idx_tasks_admin_users_tid ON tasks_admin_users  btree (task_id);

CREATE INDEX idx_tasks_excluded_users_tid ON tasks_excluded_users  btree (task_id);

CREATE INDEX idx_tasks_potential_groups_tid ON tasks_potential_groups  btree (task_id);

CREATE INDEX idx_tasks_potential_users_tid ON tasks_potential_users  btree (task_id);

ALTER TABLE attachments
    ADD CONSTRAINT fk_attachments_tasks FOREIGN KEY (task_id) REFERENCES tasks(id) ON DELETE CASCADE;

ALTER TABLE comments
    ADD CONSTRAINT fk_comments_tasks FOREIGN KEY (task_id) REFERENCES tasks(id) ON DELETE CASCADE;

ALTER TABLE definitions_addons
    ADD CONSTRAINT fk_definitions_addons_definitions FOREIGN KEY (process_id, process_version) REFERENCES definitions(id, version) ON DELETE CASCADE;

ALTER TABLE definitions_annotations
    ADD CONSTRAINT fk_definitions_annotations FOREIGN KEY (process_id, process_version) REFERENCES definitions(id, version) ON DELETE CASCADE;

ALTER TABLE definitions_metadata
    ADD CONSTRAINT fk_definitions_metadata FOREIGN KEY (process_id, process_version) REFERENCES definitions(id, version) ON DELETE CASCADE;

ALTER TABLE definitions_nodes
    ADD CONSTRAINT fk_definitions_nodes_definitions FOREIGN KEY (process_id, process_version) REFERENCES definitions(id, version) ON DELETE CASCADE;

ALTER TABLE definitions_nodes_metadata
    ADD CONSTRAINT fk_definitions_nodes_metadata_definitions_nodes FOREIGN KEY (node_id, process_id, process_version) REFERENCES definitions_nodes(id, process_id, process_version) ON DELETE CASCADE;

ALTER TABLE definitions_roles
    ADD CONSTRAINT fk_definitions_roles_definitions FOREIGN KEY (process_id, process_version) REFERENCES definitions(id, version) ON DELETE CASCADE;

ALTER TABLE milestones
    ADD CONSTRAINT fk_milestones_process FOREIGN KEY (process_instance_id) REFERENCES processes(id) ON DELETE CASCADE;

ALTER TABLE nodes
    ADD CONSTRAINT fk_nodes_process FOREIGN KEY (process_instance_id) REFERENCES processes(id) ON DELETE CASCADE;

ALTER TABLE processes_addons
    ADD CONSTRAINT fk_processes_addons_processes FOREIGN KEY (process_id) REFERENCES processes(id) ON DELETE CASCADE;

ALTER TABLE processes_roles
    ADD CONSTRAINT fk_processes_roles_processes FOREIGN KEY (process_id) REFERENCES processes(id) ON DELETE CASCADE;

ALTER TABLE tasks_admin_groups
    ADD CONSTRAINT fk_tasks_admin_groups_tasks FOREIGN KEY (task_id) REFERENCES tasks(id) ON DELETE CASCADE;

ALTER TABLE tasks_admin_users
    ADD CONSTRAINT fk_tasks_admin_users_tasks FOREIGN KEY (task_id) REFERENCES tasks(id) ON DELETE CASCADE;

ALTER TABLE tasks_excluded_users
    ADD CONSTRAINT fk_tasks_excluded_users_tasks FOREIGN KEY (task_id) REFERENCES tasks(id) ON DELETE CASCADE;

ALTER TABLE tasks_potential_groups
    ADD CONSTRAINT fk_tasks_potential_groups_tasks FOREIGN KEY (task_id) REFERENCES tasks(id) ON DELETE CASCADE;

ALTER TABLE tasks_potential_users
    ADD CONSTRAINT fk_tasks_potential_users_tasks FOREIGN KEY (task_id) REFERENCES tasks(id) ON DELETE CASCADE;
