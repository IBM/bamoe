# BAMOE Management Console

A web application that is able to connect to multiple running Processes applications and lets users check more details about Process instances, like the path an instance has already gone though, or the jobs that an instance is waiting on. Process instances can also be filtered by multiple attributes, and it is possible to see Process definitions too.

The Task Console was integrated into BAMOE Management Console and all its functionalities are accessible via the `Tasks` menu.

## Run

```bash
docker run -t -p 8081:8080 -i --rm quay.io/bamoe/management-console:9.2.1-ibm-0005
# BAMOE Management Console will be up at http://localhost:8081
```

## Customization

`RUNTIME_TOOLS_MANAGEMENT_CONSOLE_APP_NAME` --> Management Console app name.  
`RUNTIME_TOOLS_MANAGEMENT_CONSOLE_OIDC_CLIENT_CLIENT_ID` --> OpenID Connect client ID for connecting to Identity Providers.  
`RUNTIME_TOOLS_MANAGEMENT_CONSOLE_OIDC_CLIENT_DEFAULT_SCOPES` --> OpenID Connect default scopes when connecting to Identity Providers.
`RUNTIME_TOOLS_MANAGEMENT_CONSOLE_OIDC_CLIENT_DEFAULT_AUDIENCE` --> OpenID Connect default audience when connecting to Identity Providers.
`RUNTIME_TOOLS_MANAGEMENT_CONSOLE_MANAGED_BUSINESS_SERVICES` --> List of Business Services that are automatically connected to the Management Console.

### Examples

1. Using a different Client ID.

   ```bash
   docker run -t -p 8081:8080 -e RUNTIME_TOOLS_MANAGEMENT_CONSOLE_OIDC_CLIENT_CLIENT_ID=<my_value> -i --rm quay.io/bamoe/management-console:9.2.1-ibm-0005
   ```

2. Setting pre-defined Business Services

   ```bash
   docker run -t -p 8080:8080 -e RUNTIME_TOOLS_MANAGEMENT_CONSOLE_MANAGED_BUSINESS_SERVICES='[{ "name":"Unauthenticated 8081", "businessServiceUrl":"http://localhost:8081" }, { "name":"Unauthenticated 8082", "businessServiceUrl":"http://localhost:8082" }, { "name":"Authenticated 8091", "businessServiceUrl":"http://localhost:8091/my-subpath" }, { "name":"Authenticated 8092", "businessServiceUrl":"http://localhost:8092" }]' -i --rm quay.io/bamoe/management-console:main
   ```

3. Write a custom `Containerfile/Dockerfile` from the image:

   ```docker
   FROM quay.io/bamoe/management-console:9.2.1-ibm-0005

   ENV RUNTIME_TOOLS_MANAGEMENT_CONSOLE_OIDC_CLIENT_CLIENT_ID=<my_value>
   ```

4. Create the application from the image in OpenShift and set the deployment environment variable right from the OpenShift UI.

## Pre-defined connected Business Services

They are defined via the `RUNTIME_TOOLS_MANAGEMENT_CONSOLE_MANAGED_BUSINESS_SERVICES` environment variable, in the following format:

```js
{
  name: string;
  businessServiceUrl: string;
  clientId?: string; // Optional
  scope?: string; // Optional
  audience?: string; // Optional
}
```

Example:

```json
[
  {
    "name": "My Business Service 1",
    "businessServiceUrl": "http://my-business-service-1.url",
  },
  {
    "name": "My Business Service 2",
    "businessServiceUrl": "http://my-business-service-2.url",
    "clientId": "custom-client-id",
    "scope": "custom scopes for openid",
    "audience": "business-service-audience"
  },
  ...
]
```
