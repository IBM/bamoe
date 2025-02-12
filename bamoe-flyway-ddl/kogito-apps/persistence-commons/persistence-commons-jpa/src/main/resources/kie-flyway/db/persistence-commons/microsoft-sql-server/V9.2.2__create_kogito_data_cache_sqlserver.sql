CREATE TABLE kogito_data_cache (
    var_name character varying(255) NOT NULL,
    cache_name character varying(255) NOT NULL,
    json_value nvarchar(max)
);

ALTER TABLE kogito_data_cache
    ADD CONSTRAINT kogito_data_cache_pkey PRIMARY KEY (var_name, cache_name);