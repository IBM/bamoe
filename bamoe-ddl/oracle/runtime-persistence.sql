--
-- It contains all the required Tables used by runtime persistence.
--

-- TABLE business_key_mapping
CREATE TABLE business_key_mapping (
    business_key VARCHAR2(255) NOT NULL,
    process_instance_id VARCHAR2(36) NOT NULL
);

-- TABLE correlation_instances: composite business keys to locate a process without the process instance id
CREATE TABLE correlation_instances (
    id VARCHAR2(36) NOT NULL,
    encoded_correlation_id VARCHAR2(36) NOT NULL,
    correlated_id VARCHAR2(36) NOT NULL,
    correlation VARCHAR2(255) NOT NULL,
    version NUMBER(19)
);

-- TABLE process_instances: A process instance represents one specific instance of a process that is currently executing.
CREATE TABLE process_instances (
    id VARCHAR2(36) NOT NULL,
    payload BLOB NOT NULL,
    process_id VARCHAR2(255) NOT NULL,
    version NUMBER(19),
    process_version VARCHAR2(255)
);

ALTER TABLE business_key_mapping
    ADD CONSTRAINT business_key_mapping_pkey PRIMARY KEY (business_key);

ALTER TABLE correlation_instances
    ADD CONSTRAINT correlation_instances_encoded_correlation_id_key UNIQUE (encoded_correlation_id);

ALTER TABLE correlation_instances
    ADD CONSTRAINT correlation_instances_pkey PRIMARY KEY (id);

ALTER TABLE process_instances
    ADD CONSTRAINT process_instances_pkey PRIMARY KEY (id);

CREATE INDEX idx_business_key_process_instance_id ON business_key_mapping (process_instance_id);

CREATE INDEX idx_correlation_instances_correlated_id ON correlation_instances (correlated_id);

CREATE INDEX idx_process_instances_process_id ON process_instances (process_id, id, process_version);

ALTER TABLE business_key_mapping
    ADD CONSTRAINT fk_process_instances FOREIGN KEY (process_instance_id) REFERENCES process_instances(id) ON DELETE CASCADE;
