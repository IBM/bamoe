ALTER TABLE nodes ADD retrigger BIT DEFAULT 0;

ALTER TABLE nodes ADD rror_message character varying(max);

ALTER TABLE processes ADD node_instance_id character varying(255);