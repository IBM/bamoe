# BAMOE CORS Proxy (9.4.0-ibm-0006)

A web application that acts as a proxy to enable BAMOE Canvas to communicate, directly from the browser, with Git and cloud providers. Some Git providers (like `github.com` and `bitbucket.org`) do not allow requests coming from any webpage, and the is true for some OpenShift and Kubernetes installations. Since BAMOE Canvas features an in-browser Git subsystem and Dev deployments to the configured cloud providers, when doing Git operations (like `clone`, `fetch`, `push`, `pull`), or cloud operations like "Deploy", we go through this proxy to work around that fact.


## Run

Start up a new container with:

```bash
docker run -p 7081:8080 -i --rm quay.io/bamoe/cors-proxy:9.4.0-ibm-0006
# CORS Proxy will be up at http://localhost:7081
```



### Container configuration

It's possible to configure certain parameters of the container using the following env variables:

- _CORS_PROXY_ALLOWED_ORIGINS_:  Comma-separated list of origins that can use the CORS Proxy service. Requests from origins not specified will be rejected. Does not have a default value and does **not** accept the `*` wildcard.
- _CORS_PROXY_ALLOWED_HOSTS_: Comma-separated list of hosts that the CORS Proxy service can proxy to. Requests to hosts not specified will be rejected. Defaults to the `*` wildcard, which means that any host can be proxied. Recommend changing this environment variable to list only the hosts that will be proxied (OpenShift clusters, Git providers, AI providers, etc).
- _CORS_PROXY_VERBOSE_: Allows the proxy to run in verbose mode. Useful to trace requests on development environments. Defaults to `false`.

For example setting an `.env` file like:

```bash
CORS_PROXY_ALLOWED_ORIGINS=https://my-canvas.com
CORS_PROXY_ALLOWED_HOSTS=https://github.com,https://bitbucket.org,https://console.my-openshift-cluster.com
CORS_PROXY_VERBOSE=false
```

or by passing the variables as arguments like

```bash
docker run -p 7081:8080 -i --rm -e CORS_PROXY_ORIGIN=* -e CORS_PROXY_VERBOSE=false quay.io/bamoe/cors-proxy:9.4.0-ibm-0006
```

## Running with an external proxy

When starting the container, pass the `HTTP_PROXY`/`HTTPS_PROXY` environment variable pointing to the URL of your proxy service:

```bash
docker run -p 7081:8080 -i --rm -e HTTPS_PROXY=<YOUR_PROXY_URL> quay.io/bamoe/cors-proxy:9.4.0-ibm-0006
```

---

> NOTE: This image includes all the capabilities from the previous `quay.io/bamoe/git-cors-proxy:9.0.1` image, combined with the CORS proxy that used to be on `quay.io/bamoe/extended-services:9.0.1`
