# BAMOE Management Console

A web application that is able to connect to multiple running Processes applications and lets users check more details about Process instances, like the path an instance has already gone though, or the jobs that an instance is waiting on. Process instances can also be filtered by multiple attributes, and it is possible to see Process definitions too.

The Task Console was integrated into BAMOE Management Console and all its functionalities are accessible via the `Tasks` menu.

## Run

```bash
docker run -t -p 8081:8080 -i --rm quay.io/bamoe/management-console:9.2.0-ibm-0004
# BAMOE Management Console will be up at http://localhost:8081
```

## Customization

`RUNTIME_TOOLS_MANAGEMENT_CONSOLE_APP_NAME` --> Management Console app name.  
`RUNTIME_TOOLS_MANAGEMENT_CONSOLE_OIDC_CLIENT_CLIENT_ID` --> OpenID Connect client ID for connecting to Identity Providers.  

### Examples

1. Using a different Client ID.

   ```bash
   docker run -t -p 8081:8080 -e RUNTIME_TOOLS_MANAGEMENT_CONSOLE_OIDC_CLIENT_CLIENT_ID=<my_value> -i --rm quay.io/bamoe/management-console:9.2.0-ibm-0004
   ```

2. Write a custom `Containerfile/Dockerfile` from the image:

   ```docker
   FROM quay.io/bamoe/management-console:9.2.0-ibm-0004

   ENV RUNTIME_TOOLS_MANAGEMENT_CONSOLE_OIDC_CLIENT_CLIENT_ID=<my_value>
   ```

3. Create the application from the image in OpenShift and set the deployment environment variable right from the OpenShift UI.
