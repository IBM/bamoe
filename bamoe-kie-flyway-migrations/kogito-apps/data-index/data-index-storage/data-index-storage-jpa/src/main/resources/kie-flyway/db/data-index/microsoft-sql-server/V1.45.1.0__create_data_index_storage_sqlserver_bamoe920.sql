
CREATE TABLE process_definitions (
    id character varying(255) NOT NULL,
    version character varying(255) NOT NULL,
    name character varying(255),
    type character varying(255),
    source varbinary(max),
    endpoint character varying(255),
    description character varying(255),
    metadata varchar(max),
    CONSTRAINT definitions_pkey PRIMARY KEY (id, version)
);

CREATE TABLE definitions_addons (
    process_id character varying(255) NOT NULL,
    process_version character varying(255) NOT NULL,
    addon character varying(255) NOT NULL,
    CONSTRAINT definitions_addons_pkey PRIMARY KEY (process_id, process_version, addon),
    CONSTRAINT fk_definitions_addons_definitions FOREIGN KEY (process_id, process_version) REFERENCES process_definitions(id, version) ON DELETE CASCADE
);

CREATE TABLE definitions_annotations (
    annotation character varying(255) NOT NULL,
    process_id character varying(255) NOT NULL,
    process_version character varying(255) NOT NULL,
    CONSTRAINT definitions_annotations_pkey PRIMARY KEY (annotation, process_id, process_version),
    CONSTRAINT fk_definitions_annotations FOREIGN KEY (process_id, process_version) REFERENCES process_definitions(id, version) ON DELETE CASCADE
);

CREATE TABLE definitions_metadata (
    process_id character varying(255) NOT NULL,
    process_version character varying(255) NOT NULL,
    meta_value character varying(255),
    name character varying(255) NOT NULL,
    CONSTRAINT definitions_metadata_pkey PRIMARY KEY (process_id, process_version, name),
    CONSTRAINT fk_definitions_metadata FOREIGN KEY (process_id, process_version) REFERENCES process_definitions(id, version) ON DELETE CASCADE

);

CREATE TABLE definitions_nodes (
    id character varying(255) NOT NULL,
    name character varying(255),
    unique_id character varying(255),
    type character varying(255),
    process_id character varying(255) NOT NULL,
    process_version character varying(255) NOT NULL,
    CONSTRAINT definitions_nodes_pkey PRIMARY KEY (id, process_id, process_version),
    CONSTRAINT fk_definitions_nodes_definitions FOREIGN KEY (process_id, process_version) REFERENCES process_definitions(id, version) ON DELETE CASCADE
);

CREATE TABLE definitions_nodes_metadata (
    node_id character varying(255) NOT NULL,
    process_id character varying(255) NOT NULL,
    process_version character varying(255) NOT NULL,
    meta_value character varying(255),
    name character varying(255) NOT NULL,
    CONSTRAINT definitions_nodes_metadata_pkey PRIMARY KEY (node_id, process_id, process_version, name),
    CONSTRAINT fk_definitions_nodes_metadata_definitions_nodes FOREIGN KEY (node_id, process_id, process_version) REFERENCES definitions_nodes(id, process_id, process_version) ON DELETE CASCADE
);

CREATE TABLE definitions_roles (
    process_id character varying(255) NOT NULL,
    process_version character varying(255) NOT NULL,
    role character varying(255) NOT NULL,
    CONSTRAINT definitions_roles_pkey PRIMARY KEY (process_id, process_version, role),
    CONSTRAINT fk_definitions_roles_definitions FOREIGN KEY (process_id, process_version) REFERENCES process_definitions(id, version) ON DELETE CASCADE
);

CREATE TABLE jobs (
    id character varying(255) NOT NULL,
    callback_endpoint character varying(255),
    endpoint character varying(255),
    execution_counter integer,
    expiration_time datetimeoffset(6),
    last_update datetimeoffset(6),
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
    status character varying(255),
    CONSTRAINT jobs_pkey PRIMARY KEY (id)
);


CREATE TABLE processes (
    id character varying(255) NOT NULL,
    business_key character varying(255),
    end_time datetimeoffset(6),
    endpoint character varying(255),
    message character varying(max),
    node_definition_id character varying(255),
    last_update_time datetimeoffset(6),
    parent_process_instance_id character varying(255),
    process_id character varying(255),
    process_name character varying(255),
    root_process_id character varying(255),
    root_process_instance_id character varying(255),
    start_time datetimeoffset(6),
    state integer,
    variables nvarchar(max),
    version character varying(255),
    created_by character varying(max),
    updated_by character varying(max),
    sla_due_date datetimeoffset(6),
    CONSTRAINT processes_pkey PRIMARY KEY (id)
);


CREATE TABLE milestones (
    id character varying(255) NOT NULL,
    process_instance_id character varying(255) NOT NULL,
    name character varying(255),
    status character varying(255),
    CONSTRAINT milestones_pkey PRIMARY KEY (id, process_instance_id),
    CONSTRAINT fk_milestones_process FOREIGN KEY (process_instance_id) REFERENCES processes(id) ON DELETE CASCADE
);

CREATE TABLE nodes (
    id character varying(255) NOT NULL,
    definition_id character varying(255),
    enter_time datetimeoffset(6),
    exit_time datetimeoffset(6),
    name character varying(255),
    node_id character varying(255),
    type character varying(255),
    process_instance_id character varying(255) NOT NULL,
    sla_due_date datetimeoffset(6),
    CONSTRAINT nodes_pkey PRIMARY KEY (id),
    CONSTRAINT fk_nodes_process FOREIGN KEY (process_instance_id) REFERENCES processes(id) ON DELETE CASCADE
);

CREATE TABLE processes_addons (
    process_id character varying(255) NOT NULL,
    addon character varying(255) NOT NULL,
    CONSTRAINT processes_addons_pkey PRIMARY KEY (process_id, addon),
    CONSTRAINT fk_processes_addons_processes FOREIGN KEY (process_id) REFERENCES processes(id) ON DELETE CASCADE
);

CREATE TABLE processes_roles (
    process_id character varying(255) NOT NULL,
    role character varying(255) NOT NULL,
    CONSTRAINT processes_roles_pkey PRIMARY KEY (process_id, role),
    CONSTRAINT fk_processes_roles_processes FOREIGN KEY (process_id) REFERENCES processes(id) ON DELETE CASCADE
);

CREATE TABLE tasks (
    id character varying(255) NOT NULL,
    actual_owner character varying(255),
    completed datetimeoffset(6),
    description character varying(255),
    endpoint character varying(255),
    inputs nvarchar(max),
    last_update datetimeoffset(6),
    name character varying(255),
    outputs nvarchar(max),
    priority character varying(255),
    process_id character varying(255),
    process_instance_id character varying(255),
    reference_name character varying(255),
    root_process_id character varying(255),
    root_process_instance_id character varying(255),
    started datetimeoffset(6),
    state character varying(255),
    external_reference_id character varying(4000),
    sla_due_date datetimeoffset(6),
    CONSTRAINT tasks_pkey PRIMARY KEY (id)
);


CREATE TABLE attachments (
    id character varying(255) NOT NULL,
    content character varying(255),
    name character varying(255),
    updated_at datetimeoffset(6),
    updated_by character varying(255),
    task_id character varying(255) NOT NULL,
    CONSTRAINT attachments_pkey PRIMARY KEY (id),
    CONSTRAINT fk_attachments_tasks FOREIGN KEY (task_id) REFERENCES tasks(id) ON DELETE CASCADE,
);

CREATE TABLE comments (
    id character varying(255) NOT NULL,
    content character varying(1000),
    updated_at datetimeoffset(6),
    updated_by character varying(255),
    task_id character varying(255) NOT NULL,
    CONSTRAINT comments_pkey PRIMARY KEY (id),
    CONSTRAINT fk_comments_tasks FOREIGN KEY (task_id) REFERENCES tasks(id) ON DELETE CASCADE
);

CREATE TABLE tasks_admin_groups (
    task_id character varying(255) NOT NULL,
    group_id character varying(255) NOT NULL,
    CONSTRAINT tasks_admin_groups_pkey PRIMARY KEY (task_id, group_id),
    CONSTRAINT fk_tasks_admin_groups_tasks FOREIGN KEY (task_id) REFERENCES tasks(id) ON DELETE CASCADE
);

CREATE TABLE tasks_admin_users (
    task_id character varying(255) NOT NULL,
    user_id character varying(255) NOT NULL,
    CONSTRAINT tasks_admin_users_pkey PRIMARY KEY (task_id, user_id),
    CONSTRAINT fk_tasks_admin_users_tasks FOREIGN KEY (task_id) REFERENCES tasks(id) ON DELETE CASCADE
);

CREATE TABLE tasks_excluded_users (
    task_id character varying(255) NOT NULL,
    user_id character varying(255) NOT NULL,
    CONSTRAINT tasks_excluded_users_pkey PRIMARY KEY (task_id, user_id),
    CONSTRAINT fk_tasks_excluded_users_tasks FOREIGN KEY (task_id) REFERENCES tasks(id) ON DELETE CASCADE
);

CREATE TABLE tasks_potential_groups (
    task_id character varying(255) NOT NULL,
    group_id character varying(255) NOT NULL,
    CONSTRAINT tasks_potential_groups_pkey PRIMARY KEY (task_id, group_id),
    CONSTRAINT fk_tasks_potential_groups_tasks FOREIGN KEY (task_id) REFERENCES tasks(id) ON DELETE CASCADE
);

CREATE TABLE tasks_potential_users (
    task_id character varying(255) NOT NULL,
    user_id character varying(255) NOT NULL,
    CONSTRAINT tasks_potential_users_pkey PRIMARY KEY (task_id, user_id),
   CONSTRAINT fk_tasks_potential_users_tasks FOREIGN KEY (task_id) REFERENCES tasks(id) ON DELETE CASCADE
);


CREATE INDEX idx_comments_tid ON comments (task_id);

CREATE INDEX idx_attachments_tid ON attachments (task_id)

CREATE INDEX idx_definitions_addons_pid_pv ON definitions_addons (process_id, process_version);

CREATE INDEX idx_definitions_annotations_pid_pv ON definitions_annotations (process_id, process_version);

CREATE INDEX idx_definitions_metadata_pid_pv ON definitions_metadata (process_id, process_version);

CREATE INDEX idx_definitions_nodes_metadata_pid_pv ON definitions_nodes_metadata (process_id, process_version);

CREATE INDEX idx_definitions_nodes_pid_pv ON definitions_nodes (process_id, process_version);

CREATE INDEX idx_definitions_roles_pid_pv ON definitions_roles (process_id, process_version);

CREATE INDEX idx_milestones_piid ON milestones (process_instance_id);

CREATE INDEX idx_nodes_piid ON nodes (process_instance_id);

CREATE INDEX idx_processes_addons_pid ON processes_addons (process_id);

CREATE INDEX idx_processes_roles_pid ON processes_roles (process_id);

CREATE INDEX idx_tasks_admin_groups_tid ON tasks_admin_groups (task_id);

CREATE INDEX idx_tasks_admin_users_tid ON tasks_admin_users (task_id);

CREATE INDEX idx_tasks_excluded_users_tid ON tasks_excluded_users (task_id);

CREATE INDEX idx_tasks_potential_groups_tid ON tasks_potential_groups (task_id);

CREATE INDEX idx_tasks_potential_users_tid ON tasks_potential_users (task_id);
