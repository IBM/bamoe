--
-- It contains all the required Tables to correctly manage and persist Job Instances
--

-- TABLE job_details: Represents a Job Instance on the Job Service with its details
CREATE TABLE job_details (
    id VARCHAR2(50) NOT NULL, -- the unique id internally on the job service
    correlation_id VARCHAR2(50), -- the job id on the runtimes,
    status VARCHAR2(40), -- the job status: 'ERROR' or 'EXECUTED' or 'SCHEDULED' or 'RETRY' or 'CANCELED'
    last_update timestamp with time zone,
    retries integer,
    execution_counter integer, -- number of times the job was executed
    scheduled_id VARCHAR2(40), -- the execution control on the scheduler (id on vertx.setTimer, quartzId...)
    priority integer,
    recipient CLOB, -- http callback, event topic
    job_trigger CLOB, -- when/how it should be executed
    fire_time timestamp with time zone,
    execution_timeout NUMBER(19),
    execution_timeout_unit VARCHAR2(40),
    created timestamp with time zone,
    CONSTRAINT job_details_pkey1 PRIMARY KEY (id)
);

-- TABLE job_service_management: used for clustering and to check lead instance
CREATE TABLE job_service_management (
    id VARCHAR2(40) NOT NULL,
    last_heartbeat timestamp with time zone,
    token VARCHAR2(40),
    CONSTRAINT job_service_management_pkey PRIMARY KEY (id),
    CONSTRAINT job_service_management_token_key UNIQUE (token)
);

CREATE INDEX job_details_created_idx ON job_details (created);

CREATE INDEX job_details_fire_time_idx ON job_details (fire_time);
