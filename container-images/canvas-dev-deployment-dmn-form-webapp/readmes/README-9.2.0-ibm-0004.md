# BAMOE Canvas Dev Deployment DMN Form Webapp

This image is ready to be used for Dev deployments that contain Decisions (`.dmn`) on BAMOE Canvas.
It expects a Quarkus application to be running at the same host, which it will use to fetch information to render a form that let's users interact with a Decision.

## Run

```bash
docker run -t -p 8080:8081 -i --rm quay.io/bamoe/canvas-dev-deployment-dmn-formwebapp:9.2.0-ibm-0004
# BAMOE Dev Deployment DMN Form Webapp will be up at http://localhost:8080
```