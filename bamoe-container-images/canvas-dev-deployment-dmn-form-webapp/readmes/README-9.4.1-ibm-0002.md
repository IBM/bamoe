# BAMOE Canvas Dev Deployment DMN Form Webapp (9.4.1-ibm-0002)

This image is ready to be used for Dev Deployments that contain Decisions (`.dmn`) on BAMOE Canvas.
It expects a Quarkus application to be running on the same host, which it will use to fetch information to render a form that lets users interact with a Decision.

## Run

```bash
docker run -t -p 8080:8081 -i --rm quay.io/bamoe/canvas-dev-deployment-dmn-formwebapp:9.4.1-ibm-0002
# BAMOE Dev Deployment DMN Form Webapp will be up at http://localhost:8080
```