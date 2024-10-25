This folder contains all the required DDL (Data Definition Language) to create from scratch a new database for **POSTGRESQL** the following features:
* **Data Audit subsystem**
  * DDL Schema: data-audit.sql
  * SQL files Location in community: [kogito-apps](https://github.com/apache/incubator-kie-kogito-apps/tree/main/data-audit/kogito-addons-data-audit-jpa/kogito-addons-data-audit-jpa-common/src/main/resources/kie-flyway/db/data-audit/postgresql)
* **Data Index**
  * DDL Schema: data-index.sql
  * SQL files Location in community: [kogito-apps](https://github.com/apache/incubator-kie-kogito-apps/tree/main/data-index/data-index-storage/data-index-storage-postgresql/src/main/resources/kie-flyway/db/data-index/postgresql)
* **Job Services**
  * DDL Schema: jobs-services.sql
  * SQL files Location in community: [kogito-apps](https://github.com/apache/incubator-kie-kogito-apps/blob/main/jobs-service/jobs-service-postgresql-common/src/main/resources/kie-flyway/db/jobs-service/postgresql/V2.0.0__Create_Table.sql)
* **Runtime Persistence**
  * DDL Schema: runtime-persistence.sql
  * SQL files Location in community: [kogito-runtime](https://github.com/apache/incubator-kie-kogito-runtimes/tree/main/addons/common/persistence/jdbc/src/main/resources/kie-flyway/db/persistence-jdbc/postgresql)
* **User Tasks**
  * DDL Schema: user-tasks.sql
  * SQL files Location in community: [kogito-runtime](https://github.com/apache/incubator-kie-kogito-runtimes/tree/main/addons/common/jbpm-usertask-storage-jpa/src/main/resources/kie-flyway/db/user-tasks/postgresql)

It's crucial to keep the DDL Schema updated with any added patches on the above area.
This check should be manually checked before any release.
At the time of writing, the DDL Schema update is a manual process. 
For perform the updates, here the steps:

1. A PostgreSQL instance should be available on your local system
2. Create a Database and apply the above patches form community SQL patch. The patches order MATTERS!
3. As an alternative, you can rely on flyway to automatically create the Tables in you database. To do that, the steps are:
   1. Clone the [kie-tools](https://github.com/apache/incubator-kie-tools) repository
   2. Set `export KIE_TOOLS-BUILD__buildExamples=true`
   3. Set `export KIE_TOOLS-BUILD__buildContainerImages=true`
   4. Launch `pnpm -F @kie-tools-examples/jbpm-compact-architecture-example... build:dev`
   5. Launch `pnpm -F @kie-tools-examples/jbpm-compact-architecture-example quarkus:dev`
   6. Launch `pnpm -F @kie-tools-examples/jbpm-compact-architecture-example start`
4. Export the DB using the following command: ```pg_dump -U <user> -d <db> -F p --no-owner --schema-only```
5. Update the DDL according to the above results
6. Re-run the updated DDLs to double-check their correctness.
