# BAMOE Management Console

A web application that is able to connect to multiple running Processes applications and lets users check more details about Process instances, like the path an instance has already gone though, or the jobs that an instance is waiting on. Process instances can also be filtered by multiple attributes, and it is possible to see Process definitions too.

The Task Console was integrated into BAMOE Management Console and all its functionalities are accessible via the `Tasks` menu.

## Run

```bash
docker run -t -p 9091:8080 -i --rm quay.io/bamoe/management-console:9.3.1-ibm-0006
# BAMOE Management Console will be up at http://localhost:9091
```

## Customization

`RUNTIME_TOOLS_MANAGEMENT_CONSOLE_APP_NAME` --> Management Console app name.  
`RUNTIME_TOOLS_MANAGEMENT_CONSOLE_OIDC_CLIENT_CLIENT_ID` --> OpenID Connect client ID for connecting to Identity Providers.  
`RUNTIME_TOOLS_MANAGEMENT_CONSOLE_OIDC_CLIENT_DEFAULT_SCOPES` --> OpenID Connect default scopes when connecting to Identity Providers.  
`RUNTIME_TOOLS_MANAGEMENT_CONSOLE_OIDC_CLIENT_DEFAULT_AUDIENCE` --> OpenID Connect default audience when connecting to Identity Providers.  
`RUNTIME_TOOLS_MANAGEMENT_CONSOLE_MANAGED_BUSINESS_SERVICES` --> List of Business Services that are automatically connected to the Management Console.  
`RUNTIME_TOOLS_MANAGEMENT_CONSOLE_BASE_PATH` --> Base path used for all routes in the Management Console.  
`RUNTIME_TOOLS_MANAGEMENT_CONSOLE_USE_APACHE_HTTPD_BASE_PATH_ALIAS` --> Set to "true" if the Apache HTTP Server should serve files under an alias, prefixed by the $RUNTIME_TOOLS_MANAGEMENT_CONSOLE_BASE_PATH path.  

### Examples

1. Using a different Client ID.

   ```bash
   docker run -t -p 9091:8080 -e RUNTIME_TOOLS_MANAGEMENT_CONSOLE_OIDC_CLIENT_CLIENT_ID=<my_value> -i --rm quay.io/bamoe/management-console:9.3.1-ibm-0006
   ```

2. Setting pre-defined Business Services

   ```bash
   docker run -t -p 9091:8080 -e RUNTIME_TOOLS_MANAGEMENT_CONSOLE_MANAGED_BUSINESS_SERVICES='[{ "name":"Unauthenticated 8081", "businessServiceUrl":"http://localhost:8081" }, { "name":"Unauthenticated 8082", "businessServiceUrl":"http://localhost:8082" }, { "name":"Authenticated 8091", "businessServiceUrl":"http://localhost:8091/my-subpath" }, { "name":"Authenticated 8092", "businessServiceUrl":"http://localhost:8092" }]' -i --rm quay.io/bamoe/management-console:9.3.1-ibm-0006
   ```

3. Write a custom `Containerfile/Dockerfile` from the image:

   ```docker
   FROM quay.io/bamoe/management-console:9.3.1-ibm-0006

   ENV RUNTIME_TOOLS_MANAGEMENT_CONSOLE_APP_NAME=<my_app_name>
   ENV RUNTIME_TOOLS_MANAGEMENT_CONSOLE_OIDC_CLIENT_CLIENT_ID=<my_client_id>
   ENV RUNTIME_TOOLS_MANAGEMENT_CONSOLE_OIDC_CLIENT_DEFAULT_SCOPES=<my_default_scopes>
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

## Serving the Management Console from a custom subpath

By default, the Management Console is served from the root path (`/`) on its web server, either when running directly from the container image or deployed to a Kubernetes/OpenShift cluster. This means that the web application is served through an URL that looks like `https://my.domain.com/`.

In some cases, you may want to serve the application from a subpath for example, `/bamoe-management-console`, with the final URL looking like `https://my.domain.com/bamoe-management-console`.

To achieve this, the Management Console container image accepts two environment variables that are used to configure the subpath:

- `RUNTIME_TOOLS_MANAGEMENT_CONSOLE_BASE_PATH`: The target subpath where the web application will be served from (for example, `/bamoe-management-console`). Empty by default, which means that the web application is served from the root (`/`) path. Obs.: The subpath should *not* include the leading `/`.
- `RUNTIME_TOOLS_MANAGEMENT_CONSOLE_USE_APACHE_HTTPD_BASE_PATH_ALIAS`: Whether or not the Apache HTTP Server should define an `Alias` in the `/etc/httpd/conf/httpd.conf` inside the container image during runtime. The alias will look like: `Alias /$RUNTIME_TOOLS_MANAGEMENT_CONSOLE_BASE_PATH /var/www/html`.

There are two different scenarios for running the Management Console: behind a reverse proxy (be it an Ingress in a Kubernetes cluster, a Route in an OpenShift cluster, or an Nginx instance in a Docker Compose, for example) or served directly from the container image (by running it via Docker locally, for example).

### Behind a reverse proxy (Kubernetes / OpenShift / Nginx)

In this scenario, only the `RUNTIME_TOOLS_MANAGEMENT_CONSOLE_BASE_PATH` environment variable needs to be set, while `RUNTIME_TOOLS_MANAGEMENT_CONSOLE_USE_APACHE_HTTPD_BASE_PATH_ALIAS` should remain empty or set to `"false"`.

If you are installing by using the Helm chart, this can be set by using the `management-console.applicationSubpath` value and appending `--set management-console.applicationSubpath=your-subpath` to the `helm install` command. 

But if installed by using the `oc` CLI, the Deployment resource can be updated with `oc set env deployment/bamoe-management-console RUNTIME_TOOLS_MANAGEMENT_CONSOLE_BASE_PATH=your-subpath`.


### Container image running locally by using Docker

In this case, if running on a different port is not an option, both environment variables need to be set. `RUNTIME_TOOLS_MANAGEMENT_CONSOLE_BASE_PATH` with the subpath value and `RUNTIME_TOOLS_MANAGEMENT_CONSOLE_USE_APACHE_HTTPD_BASE_PATH_ALIAS` with `"true"`.

Example:

```shell
docker run -d -p 9091:8080 -e RUNTIME_TOOLS_MANAGEMENT_CONSOLE_BASE_PATH=bamoe-management-console -e RUNTIME_TOOLS_MANAGEMENT_CONSOLE_USE_APACHE_HTTPD_BASE_PATH_ALIAS=true quay.io/bamoe/management-console:9.3.1-ibm-0006
```