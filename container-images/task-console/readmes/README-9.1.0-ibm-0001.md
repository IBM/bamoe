# BAMOE Task Console

A web application that is able to connect to running instances of Processes and lets users interact with their tasks.

## Run

```bash
docker run -t -p 8080:8080 -i --rm quay.io/bamoe/task-console:9.1.0-ibm-0001
# BAMOE Task Console will be up at http://localhost:8080
```

## Customization

### Environment variables

`RUNTIME_TOOLS_TASK_CONSOLE_KOGITO_ENV_MODE` --> Env Mode: "PROD" or "DEV". PROD enables Keycloak integration.  
`RUNTIME_TOOLS_TASK_CONSOLE_KOGITO_APP_NAME` --> Task Console app name.  
`RUNTIME_TOOLS_TASK_CONSOLE_KOGITO_APP_VERSION` --> Task Console app version.  
`RUNTIME_TOOLS_TASK_CONSOLE_KOGITO_TASK_STATES_LIST` --> Pre-selected task states.  
`RUNTIME_TOOLS_TASK_CONSOLE_KOGITO_TASK_ACTIVE_STATES_LIST` --> Pre-selected task active states.  
`RUNTIME_TOOLS_TASK_CONSOLE_DATA_INDEX_ENDPOINT` --> The URL that points to the Data Index service.  
`KOGITO_CONSOLES_KEYCLOAK_DISABLE_HEALTH_CHECK` --> Disables Keycloak health-check.  
`KOGITO_CONSOLES_KEYCLOAK_UPDATE_TOKEN_VALIDITY` --> Update token validity in minutes.  
`KOGITO_CONSOLES_KEYCLOAK_HEALTH_CHECK_URL` --> Keycloak health-check URL.  
`KOGITO_CONSOLES_KEYCLOAK_REALM` --> Keycloak realm name.  
`KOGITO_CONSOLES_KEYCLOAK_URL` --> Keycloak auth URL.  
`KOGITO_CONSOLES_KEYCLOAK_CLIENT_ID` --> Keycloak Client ID.

### Examples

1. Using a different Data Index Service.

   ```bash
   docker run -t -p 8080:8080 -e RUNTIME_TOOLS_TASK_CONSOLE_DATA_INDEX_ENDPOINT=<my_value> -i --rm quay.io/bamoe/task-console:9.1.0-ibm-0001
   ```

   _NOTE: Replace `docker` with `podman` if necessary._

2. Write a custom `Containerfile` from the image:

   ```docker
   FROM quay.io/bamoe/task-console:9.1.0-ibm-0001

   ENV RUNTIME_TOOLS_TASK_CONSOLE_DATA_INDEX_ENDPOINT=<my_value>
   ```

3. Create the application from the image in OpenShift and set the deployment environment variable right from the OpenShift UI.
