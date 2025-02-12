USE bamoe;

--
-- It contains all the required Tables to correctly manage and persist Job Instances
--

-- TABLE job_details: Represents a Job Instance on the Job Service with its details
CREATE TABLE job_details (
    id character varying(50) NOT NULL, -- the unique id internally on the job service
    correlation_id character varying(50), -- the job id on the runtimes,
    status character varying(40), -- the job status: 'ERROR' or 'EXECUTED' or 'SCHEDULED' or 'RETRY' or 'CANCELED'
    last_update datetimeoffset,
    retries integer,
    execution_counter integer, -- number of times the job was executed
    scheduled_id character varying(40), -- the execution control on the scheduler (id on vertx.setTimer, quartzId...)
    priority integer,
    recipient nvarchar(MAX), -- http callback, event topic
    job_trigger nvarchar(MAX),-- when/how it should be executed
    fire_time datetimeoffset,
    execution_timeout bigint,
    execution_timeout_unit character varying(40),
    created datetimeoffset
);

-- TABLE job_service_management: used for clustering and to check lead instance
CREATE TABLE job_service_management (
    id character varying(40) NOT NULL,
    last_heartbeat datetimeoffset,
    token character varying(40)
);

ALTER TABLE job_details
    ADD CONSTRAINT job_details_pkey1 PRIMARY KEY (id);

ALTER TABLE job_service_management
    ADD CONSTRAINT job_service_management_pkey PRIMARY KEY (id);

ALTER TABLE job_service_management
    ADD CONSTRAINT job_service_management_token_key UNIQUE (token);

CREATE INDEX job_details_created_idx ON job_details (created);

CREATE INDEX job_details_fire_time_idx ON job_details (fire_time);
