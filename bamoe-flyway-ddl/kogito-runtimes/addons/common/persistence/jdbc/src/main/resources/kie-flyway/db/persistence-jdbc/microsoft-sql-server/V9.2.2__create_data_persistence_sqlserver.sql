USE bamoe;

--
-- It contains all the required Tables used by runtime persistence.
--

-- TABLE business_key_mapping
CREATE TABLE business_key_mapping (
    business_key character(255) NOT NULL,
    process_instance_id character(36) NOT NULL
);

-- TABLE correlation_instances: composite business keys to locate a process without the process instance id
CREATE TABLE correlation_instances (
    id character(36) NOT NULL,
    encoded_correlation_id character varying(36) NOT NULL,
    correlated_id character varying(36) NOT NULL,
    correlation character varying(255) NOT NULL,
    version bigint
);

-- TABLE process_instances: A process instance represents one specific instance of a process that is currently executing.
CREATE TABLE process_instances (
    id character(36) NOT NULL,
    payload varbinary(MAX) NOT NULL,
    process_id character varying(255) NOT NULL,
    version bigint,
    process_version character varying(36)
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

CREATE INDEX idx_correlation_instances_encoded_id ON correlation_instances (encoded_correlation_id);

CREATE INDEX idx_process_instances_process_id ON process_instances (process_id, id, process_version);

ALTER TABLE business_key_mapping
    ADD CONSTRAINT fk_process_instances FOREIGN KEY (process_instance_id) REFERENCES process_instances(id) ON DELETE CASCADE;
