# BAMOE Data Cleanup Tool

The **BAMOE Data Cleanup Tool** is a command-line utility packaged as a container image that helps manage historical data growth in BAMOE subsystems (`data-index` and `data-audit`).
It connects to your database, deletes data from eligible process instances based on your configuration, and then terminates.

This tool is intended to be run periodically (e.g., daily or weekly) to maintain database performance and prevent uncontrolled data growth.

## Configuration

The image is fully configurable via environment variables:

### Datasource (required):

  * `QUARKUS_PROFILE` → database kind (`postgresql`, `mssql`, `oracle`)
  * `QUARKUS_DATASOURCE_USERNAME` → database username
  * `QUARKUS_DATASOURCE_PASSWORD` → database password
  * `QUARKUS_DATASOURCE_JDBC_URL` → JDBC connection URL

### Cleanup behavior (optional):

  * `BAMOE_DATA_CLEANUP_TOOL_SUBSYSTEMS` → `data-audit` or `data-audit,data-index` (default: both)
  * `BAMOE_DATA_CLEANUP_TOOL_BATCH_SIZE` → number of process instances per delete transaction (default: `1000`)
  * `BAMOE_DATA_CLEANUP_TOOL_OLDER_THAN_PERIOD` → delete processes older than given days
  * `BAMOE_DATA_CLEANUP_TOOL_OLDER_THAN` → delete processes older than a given date (`YYYY-MM-DD`)
  * `BAMOE_DATA_CLEANUP_TOOL_PROCESSES` → comma-separated list of parent process IDs
  * `BAMOE_DATA_CLEANUP_TOOL_LOG_LEVEL` → `DEBUG`, `INFO`, `WARN`, `ERROR`, `OFF` (default: `INFO`)
  * `BAMOE_DATA_CLEANUP_TOOL_ACCEPT` → must be set to `true` to actually delete data (default: `false`)

> **Note:** If both `BAMOE_DATA_CLEANUP_TOOL_OLDER_THAN_PERIOD` and `BAMOE_DATA_CLEANUP_TOOL_OLDER_THAN` are provided, the period takes precedence. If neither is provided, all eligible data will be deleted.

## Usage

The container runs once, performs cleanup, and exits.

Examples:

**Run locally with Docker:**

```bash
docker run --rm \
  -e QUARKUS_PROFILE=postgresql \
  -e QUARKUS_DATASOURCE_USERNAME=myuser \
  -e QUARKUS_DATASOURCE_PASSWORD=mypass \
  -e QUARKUS_DATASOURCE_JDBC_URL=jdbc:postgresql://db:5432/mydb \
  -e BAMOE_DATA_CLEANUP_TOOL_OLDER_THAN_PERIOD=30 \
  -e BAMOE_DATA_CLEANUP_TOOL_ACCEPT=true \
  quay.io/bamoe/data-cleanup-tool:9.3.1-ibm-0006
```

**Run in Kubernetes as a Job:**

Define a `Job` or `CronJob` with the required environment variables to automate recurring cleanup tasks.

## Best Practices

* Run during off-peak hours.
* Adjust batch size (`BAMOE_DATA_CLEANUP_TOOL_BATCH_SIZE`) to balance performance and transaction size.
* Take backups if needed before running.
