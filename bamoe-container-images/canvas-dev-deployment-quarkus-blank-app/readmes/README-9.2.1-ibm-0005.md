# BAMOE Canvas Dev Deployment Quarkus Blank App

This image is ready to be used for Dev deployments on BAMOE Canvas.
It starts the `dev-deployment-upload-service` and then places the uploaded files inside a blank Quarkus app.
These files can be Decisions (`.dmn`) or Processes (`.bpmn`), all of them will be used as resources for the app.

## Run

```bash
docker run -t -p 8080:8080 -i --rm -e DEV_DEPLOYMENT__UPLOAD_SERVICE_API_KEY=<string> quay.io/bamoe/canvas-dev-deployment-quarkus-blank-app:9.2.1-ibm-0005
# BAMOE Dev Deployment Quarkus Blank App will be up at http://localhost:8080
```

You can then upload a `.zip` file to `/upload` using `?apiKey=<string>`, which will be unzipped at `DEV_DEPLOYMENT__UPLOAD_SERVICE_EXTRACT_TO_DIR`.

## Environment variables

### Pre defined (have a default value)

- `ROOT_PATH`: The root path for the Quarkus app and it's sub-applications (e.g. Swagger UI). Defaults to `""`, meaning the app will run at the root path.
- `DEV_DEPLOYMENT__UPLOAD_SERVICE_EXTRACT_TO_DIR`: The directory to extract the files uploaded via the Upload Service. Defaults to `/app/src/main/resources` inside the container.
- `DEV_DEPLOYMENT__UPLOAD_SERVICE_PORT`: The port where the Upload Service will listen on. Defaults to `8080`.

### Required

- `DEV_DEPLOYMENT__UPLOAD_SERVICE_API_KEY`: A string that represents the API Key the Upload Service will accepts. It should be passed as a Query Param when making requests to the service.

### Optional

- `DEV_DEPLOYMENT__UPLOAD_SERVICE_ROOT_PATH`: If the Upload Service is not running in the root path of the URL, this variable should be specified. (Usually follows the same value as `ROOT_PATH`).