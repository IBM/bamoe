# BAMOE Git CORS proxy

A web application that acts as a proxy to enable BAMOE Canvas to communicate, directly from the browser, with Git repositories. Some Git providers (like `github.com` and `bitbucket.org`) do not allow requests coming from any webpage. Since BAMOE Canvas features an in-browser Git subsystem, when doing Git operations (like `clone`, `fetch`, `push`, `pull`), we go through this proxy to work around that fact.


## Run

```bash
docker run -t -p 8082:8080 -i --rm quay.io/bamoe/git-cors-proxy:9.0.1
# BAMOE Git CORS proxy will be up at http://localhost:8082
```