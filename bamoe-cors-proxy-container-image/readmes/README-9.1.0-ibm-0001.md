# BAMOE CORS proxy

A web application that acts as a proxy to enable BAMOE Canvas to communicate, directly from the browser, with Git and cloud providers. Some Git providers (like `github.com` and `bitbucket.org`) do not allow requests coming from any webpage, and the is true for some OpenShift and Kubernetes installations. Since BAMOE Canvas features an in-browser Git subsystem and Dev deployments to the configured cloud providers, when doing Git operations (like `clone`, `fetch`, `push`, `pull`), or cloud operations like "Deploy", we go through this proxy to work around that fact.


## Run

Start up a new container with:

```bash
$ docker run -p 8080:8080 -i --rm quay.io/bamoe/cors-proxy-image:9.1.0-ibm-0001
```

The service will be up at http://localhost:8080

### Container configuration

It's possible to configure certain parameters of the container using the following env variables:

- _CORS_PROXY_ORIGIN_: Sets the value of the 'Access-Control-Allow-Origin' header, defaults to `*`
- _CORS_PROXY_VERBOSE_: Allows the proxy to run in verbose mode... useful to trace requests on development environments. Defaults to `false`

For example setting an `.env` file like:

```bash
CORS_PROXY_ORIGIN=*
CORS_PROXY_VERBOSE=false
```

or by passing the variables as arguments like

```bash
$ docker run -p 8080:8080 -e CORS_PROXY_ORIGIN=* -e CORS_PROXY_VERBOSE=false -i --rm quay.io/bamoe/cors-proxy-image:9.1.0-ibm-0001
```

---

> NOTE: This image includes all the capabilities from the previous `quay.io/bamoe/git-cors-proxy:9.0.1` image, combined with the CORS proxy that used to be on `quay.io/bamoe/extended-services:9.0.1`