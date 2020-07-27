/*
-- Database: pidsvc
-- DROP DATABASE pidsvc;
CREATE DATABASE "pidsvc"
  WITH OWNER = "pidsvc-admin"
       ENCODING = 'UTF8'
       TABLESPACE = pg_default
       LC_COLLATE = 'en_AU.UTF-8'
       LC_CTYPE = 'en_AU.UTF-8'
       CONNECTION LIMIT = -1;
CREATE LANGUAGE plpgsql;
*/
/*
DROP TABLE configuration CASCADE;
DROP TABLE mapping_type CASCADE;
DROP TABLE condition_type CASCADE;
DROP TABLE action_type CASCADE;
DROP TABLE mapping CASCADE;
DROP TABLE condition_set CASCADE;
DROP TABLE condition CASCADE;
DROP TABLE action CASCADE;
DROP TABLE lookup CASCADE;
DROP TABLE lookup_ns CASCADE;
DROP TABLE lookup_type CASCADE;
DROP TABLE lookup_behaviour_type CASCADE;
DROP FUNCTION delete_mapping_default_action() CASCADE;
DROP FUNCTION set_original_mapping_path() CASCADE;
*/

-- Table: configuration
-- DROP TABLE configuration;
CREATE TABLE configuration
(
  name character varying(50) NOT NULL,
  value character varying(255),
  CONSTRAINT configuration_pkey PRIMARY KEY (name)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE configuration
  OWNER TO "pidsvc-admin";

-- Table: mapping_type
CREATE TABLE mapping_type
(
  type character varying(50) NOT NULL,
  CONSTRAINT mapping_type_pkey PRIMARY KEY (type)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE mapping_type
  OWNER TO "pidsvc-admin";

-- Table: condition_type
CREATE TABLE condition_type
(
  type character varying(50) NOT NULL,
  CONSTRAINT condition_type_pkey PRIMARY KEY (type)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE condition_type
  OWNER TO "pidsvc-admin";

-- Table: action_type
CREATE TABLE action_type
(
  type character varying(50) NOT NULL,
  description character varying(50) NOT NULL,
  CONSTRAINT action_type_pkey PRIMARY KEY (type)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE action_type
  OWNER TO "pidsvc-admin";

-- Table: mapping
CREATE TABLE mapping
(
  mapping_id serial NOT NULL,
  mapping_path character varying(255),
  original_path character varying(255),
  parent character varying(255),
  title character varying(50),
  description text,
  creator character varying(255),
  type character varying(50) NOT NULL,
  commit_note text,
  default_action_id integer,
  default_action_description text,
  date_start timestamp without time zone NOT NULL DEFAULT now(),
  date_end timestamp without time zone,
  qr_hits integer DEFAULT 0 NOT NULL,
  CONSTRAINT mapping_pkey PRIMARY KEY (mapping_id),
--
--  The following contraint is added later once "action" table is created.
--
--  CONSTRAINT "FK_mapping_default_action_id" FOREIGN KEY (default_action_id)
--      REFERENCES action (action_id) MATCH SIMPLE
--      ON UPDATE RESTRICT ON DELETE RESTRICT,
  CONSTRAINT "FK_mapping_type" FOREIGN KEY (type)
      REFERENCES mapping_type (type) MATCH SIMPLE
      ON UPDATE RESTRICT ON DELETE RESTRICT
)
WITH (
  OIDS=FALSE
);
ALTER TABLE mapping
  OWNER TO "pidsvc-admin";

-- Index: "IX_mapping_mapping_path"
-- DROP INDEX "IX_mapping_mapping_path";
CREATE INDEX "IX_mapping_mapping_path"
  ON mapping
  USING btree
  (mapping_path);
ALTER TABLE mapping CLUSTER ON "IX_mapping_mapping_path";

-- Index: "IX_mapping_parent"
-- DROP INDEX "IX_mapping_parent";
CREATE INDEX "IX_mapping_parent"
  ON mapping
  USING btree
  (parent);

-- Index: "IX_mapping_date_start"
-- DROP INDEX "IX_mapping_date_start";
CREATE INDEX "IX_mapping_date_start"
  ON mapping
  USING btree
  (date_start);

-- Index: "IX_mapping_date_end"
-- DROP INDEX "IX_mapping_date_end";
CREATE INDEX "IX_mapping_date_end"
  ON mapping
  USING btree
  (date_end);

-- Table: condition_set
CREATE TABLE condition_set
(
  condition_set_id serial NOT NULL,
  name character varying(50) NOT NULL,
  description text,
  CONSTRAINT condition_set_pkey PRIMARY KEY (condition_set_id),
  CONSTRAINT "IX_condition_set_name" UNIQUE (name)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE condition_set
  OWNER TO "pidsvc-admin";

-- Table: condition
CREATE TABLE condition
(
  condition_id serial NOT NULL,
  mapping_id integer,
  condition_set_id integer,
  type character varying(50) NOT NULL,
  match character varying(255) NOT NULL,
  description text,
  CONSTRAINT condition_pkey PRIMARY KEY (condition_id),
  CONSTRAINT "FK_condition_mapping_id" FOREIGN KEY (mapping_id)
      REFERENCES mapping (mapping_id) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT "FK_condition_set_id" FOREIGN KEY (condition_set_id)
      REFERENCES condition_set (condition_set_id) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT "FK_condition_type" FOREIGN KEY (type)
      REFERENCES condition_type (type) MATCH SIMPLE
      ON UPDATE RESTRICT ON DELETE RESTRICT,
  CONSTRAINT "CHK_parent" CHECK ((mapping_id IS NOT NULL OR condition_set_id IS NOT NULL) AND NOT (mapping_id IS NOT NULL AND condition_set_id IS NOT NULL))
)
WITH (
  OIDS=FALSE
);
ALTER TABLE condition
  OWNER TO "pidsvc-admin";

-- Table: action
CREATE TABLE action
(
  action_id serial NOT NULL,
  condition_id integer,
  type character varying(50) NOT NULL,
  action_name character varying(50),
  action_value character varying(4096),
  CONSTRAINT "action_pkey" PRIMARY KEY (action_id),
  CONSTRAINT "FK_action_condition_id" FOREIGN KEY (condition_id)
      REFERENCES condition (condition_id) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT "FK_action_type" FOREIGN KEY (type)
      REFERENCES action_type (type) MATCH SIMPLE
      ON UPDATE RESTRICT ON DELETE RESTRICT
)
WITH (
  OIDS=FALSE
);
ALTER TABLE action
  OWNER TO "pidsvc-admin";

-- Foreign Key: "FK_mapping_default_action_id"
-- ALTER TABLE mapping DROP CONSTRAINT "FK_mapping_default_action_id";
ALTER TABLE mapping
  ADD CONSTRAINT "FK_mapping_default_action_id" FOREIGN KEY (default_action_id)
      REFERENCES action (action_id) MATCH SIMPLE
      ON UPDATE RESTRICT ON DELETE RESTRICT;

-- Function: delete_mapping_default_action()
CREATE OR REPLACE FUNCTION delete_mapping_default_action()
  RETURNS trigger AS
$BODY$
BEGIN
	DELETE FROM "action" WHERE action_id = OLD.default_action_id;
	RETURN OLD;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION delete_mapping_default_action()
  OWNER TO "pidsvc-admin";

-- Trigger: TR_delete_mapping_default_action on mapping
-- DROP TRIGGER "TR_delete_mapping_default_action" ON mapping;
CREATE TRIGGER "TR_delete_mapping_default_action"
  AFTER DELETE
  ON mapping
  FOR EACH ROW
  EXECUTE PROCEDURE delete_mapping_default_action();

-- Function: set_original_mapping_path()
CREATE OR REPLACE FUNCTION set_original_mapping_path()
  RETURNS trigger AS
$BODY$
BEGIN
	IF NEW.original_path IS NULL THEN
		NEW.original_path := NEW.mapping_path;
	END IF;
	RETURN NEW;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION set_original_mapping_path()
  OWNER TO "pidsvc-admin";

-- Trigger: TR_set_original_mapping_path on mapping
-- DROP TRIGGER "TR_set_original_mapping_path" ON mapping;
CREATE TRIGGER "TR_set_original_mapping_path"
  BEFORE INSERT
  ON mapping
  FOR EACH ROW
  EXECUTE PROCEDURE set_original_mapping_path();

-- Table: lookup_type
-- DROP TABLE lookup_type;
CREATE TABLE lookup_type
(
  type character varying(50) NOT NULL,
  CONSTRAINT lookup_type_pkey PRIMARY KEY (type)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE lookup_type
  OWNER TO "pidsvc-admin";

-- Table: lookup_behaviour_type
-- DROP TABLE lookup_behaviour_type;
CREATE TABLE lookup_behaviour_type
(
  type character varying(50) NOT NULL,
  CONSTRAINT lookup_behaviour_type_pkey PRIMARY KEY (type)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE lookup_behaviour_type
  OWNER TO "pidsvc-admin";

-- Table: lookup_ns
-- DROP TABLE lookup_ns;
CREATE TABLE lookup_ns
(
  ns character varying(255) NOT NULL,
  type character varying(50) NOT NULL,
  behaviour_type character varying(50) NOT NULL,
  behaviour_value character varying(255),
  CONSTRAINT lookup_ns_pkey PRIMARY KEY (ns),
  CONSTRAINT "FK_lookup_ns_type" FOREIGN KEY (type)
      REFERENCES lookup_type (type) MATCH SIMPLE
      ON UPDATE RESTRICT ON DELETE RESTRICT,
  CONSTRAINT "FK_lookup_ns_behaviour_type" FOREIGN KEY (behaviour_type)
      REFERENCES lookup_behaviour_type (type) MATCH SIMPLE
      ON UPDATE RESTRICT ON DELETE RESTRICT
)
WITH (
  OIDS=FALSE
);
ALTER TABLE lookup_ns
  OWNER TO "pidsvc-admin";

-- Table: lookup
-- DROP TABLE lookup;
CREATE TABLE lookup
(
  lookup_id serial NOT NULL,
  ns character varying(255) NOT NULL,
  key text NOT NULL,
  value text NOT NULL,
  CONSTRAINT lookup_pkey PRIMARY KEY (lookup_id),
  CONSTRAINT "IX_lookup_ns" FOREIGN KEY (ns)
      REFERENCES lookup_ns (ns) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE CASCADE
)
WITH (
  OIDS=FALSE
);
ALTER TABLE lookup
  OWNER TO "pidsvc-admin";

-- Index: "IX_lookup_key"
-- DROP INDEX "IX_lookup_key";
CREATE INDEX "IX_lookup_key"
  ON lookup
  USING btree
  (key);
ALTER TABLE lookup CLUSTER ON "IX_lookup_key";

-- View: vw_latest_mapping
-------: List of latest mappings only INCLUDING deprecated ones.
-- DROP VIEW vw_latest_mapping;
CREATE OR REPLACE VIEW vw_latest_mapping AS 
 SELECT f.mapping_id, f.mapping_path, f.original_path, f.parent, f.title, f.description, f.creator, f.type, f.commit_note, f.default_action_id, f.default_action_description, f.date_start, f.date_end
   FROM mapping f
   JOIN ( SELECT max(mapping.mapping_id) AS mapping_id
           FROM mapping
          GROUP BY mapping.mapping_path) a ON a.mapping_id = f.mapping_id;

ALTER TABLE vw_latest_mapping
  OWNER TO "pidsvc-admin";

-- View: vw_active_mapping
-------: List of latest currently active mappings only EXCLUDING deprecated ones.
-- DROP VIEW vw_active_mapping;
CREATE OR REPLACE VIEW vw_active_mapping AS 
 SELECT f.mapping_id, f.mapping_path, f.original_path, f.parent, f.title, f.description, f.creator, f.type, f.commit_note, f.default_action_id, f.default_action_description, f.date_start, f.date_end
   FROM mapping f
   JOIN ( SELECT max(mapping.mapping_id) AS mapping_id
           FROM mapping
          GROUP BY mapping.mapping_path) a ON a.mapping_id = f.mapping_id
  WHERE f.date_end IS NULL;

ALTER TABLE vw_active_mapping
  OWNER TO "pidsvc-admin";

-- View: vw_deprecated_mapping
-------: List of deprecated mappings only.
-- DROP VIEW vw_deprecated_mapping;
CREATE OR REPLACE VIEW vw_deprecated_mapping AS 
 SELECT f.mapping_id, f.mapping_path, f.original_path, f.parent, f.title, f.description, f.creator, f.type, f.commit_note, f.default_action_id, f.default_action_description, f.date_start, f.date_end
   FROM mapping f
   JOIN ( SELECT max(mapping.mapping_id) AS mapping_id
           FROM mapping
          GROUP BY mapping.mapping_path) a ON a.mapping_id = f.mapping_id
  WHERE f.date_end IS NOT NULL;

ALTER TABLE vw_deprecated_mapping
  OWNER TO "pidsvc-admin";

-- View: vw_full_mapping_activeonly
-------: List of all mappings configurations (including historical records) for all active mapping EXCLUDING deprecated ones.
-- DROP VIEW vw_full_mapping_activeonly;
CREATE OR REPLACE VIEW vw_full_mapping_activeonly AS 
 SELECT f.mapping_id, f.mapping_path, f.original_path, f.parent, f.title, f.description, f.creator, f.type, f.commit_note, f.default_action_id, f.default_action_description, f.date_start, f.date_end
   FROM mapping f
  WHERE (EXISTS ( SELECT 1
           FROM mapping b
          WHERE b.mapping_path::text = f.mapping_path::text AND b.date_end IS NULL
         LIMIT 1));

ALTER TABLE vw_full_mapping_activeonly
  OWNER TO "pidsvc-admin";

-- Populate with data
INSERT INTO "configuration" ("name", "value") VALUES ('DispatcherTracingMode', '0');
INSERT INTO "configuration" ("name", "value") VALUES ('CaseSensitiveURI', '1');

INSERT INTO "mapping_type" ("type") VALUES ('1:1');
INSERT INTO "mapping_type" ("type") VALUES ('Regex');

INSERT INTO "condition_type" ("type") VALUES ('Comparator');
INSERT INTO "condition_type" ("type") VALUES ('ComparatorI');
INSERT INTO "condition_type" ("type") VALUES ('ConditionSet');
INSERT INTO "condition_type" ("type") VALUES ('ContentType');
INSERT INTO "condition_type" ("type") VALUES ('Extension');
INSERT INTO "condition_type" ("type") VALUES ('HttpHeader');
INSERT INTO "condition_type" ("type") VALUES ('QueryString');

INSERT INTO "action_type" ("type", "description") VALUES ('301', 'Moved permanently to a target URL');
INSERT INTO "action_type" ("type", "description") VALUES ('302', 'Simple redirection to a target URL');
INSERT INTO "action_type" ("type", "description") VALUES ('303', 'See other URLs');
INSERT INTO "action_type" ("type", "description") VALUES ('307', 'Temporary redirect to a target URL');
INSERT INTO "action_type" ("type", "description") VALUES ('404', 'Temporarily gone');
INSERT INTO "action_type" ("type", "description") VALUES ('410', 'Permanently gone');
INSERT INTO "action_type" ("type", "description") VALUES ('415', 'Unsupported media type');
INSERT INTO "action_type" ("type", "description") VALUES ('AddHttpHeader', 'Add HTTP response header');
INSERT INTO "action_type" ("type", "description") VALUES ('RemoveHttpHeader', 'Remove HTTP response header');
INSERT INTO "action_type" ("type", "description") VALUES ('ClearHttpHeaders', 'Clear HTTP response headers');
INSERT INTO "action_type" ("type", "description") VALUES ('Proxy', 'Proxy request');

INSERT INTO "lookup_type" ("type") VALUES ('Static');
INSERT INTO "lookup_type" ("type") VALUES ('HttpResolver');

INSERT INTO "lookup_behaviour_type" ("type") VALUES ('Constant');
INSERT INTO "lookup_behaviour_type" ("type") VALUES ('PassThrough');
