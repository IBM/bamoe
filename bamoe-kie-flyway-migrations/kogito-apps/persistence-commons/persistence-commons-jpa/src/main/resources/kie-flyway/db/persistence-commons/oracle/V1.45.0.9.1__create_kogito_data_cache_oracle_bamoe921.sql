CREATE TABLE kogito_data_cache (
    var_name VARCHAR2(255) NOT NULL,
    cache_name VARCHAR2(255) NOT NULL,
    json_value CLOB,
    CONSTRAINT kogito_data_cache_pkey PRIMARY KEY (var_name, cache_name)
);
