# BAMOE Canvas

BAMOE Canvas is a web application based on the opensource KIE Sandbox project that enables authoring, testing, and deploying Decisions and Processes for Business Automation solutions. It features in-browser Git capabilities, making it possible to work with any Git repository, most notably GitHub and Bitbucket repositories. Decisions can be deployed to OpenShift and Kubernetes clusters.

## Run

```bash
docker run -t -p 9090:8080 -i --rm quay.io/bamoe/canvas:9.2.1-ibm-0005
# BAMOE Canvas will be up at http://localhost:9090
```

## Customization

1. Run a container with custom environment variables:

`KIE_SANDBOX_EXTENDED_SERVICES_URL` --> The URL that points to the Extended Services.

`KIE_SANDBOX_CORS_PROXY_URL` --> The URL that points to the BAMOE CORS proxy for interacting with Git and cloud providers.

`KIE_SANDBOX_DEV_DEPLOYMENT_BASE_IMAGE_URL` --> The URL that points to base image that is used for Dev deployments.

`KIE_SANDBOX_DEV_DEPLOYMENT_KOGITO_QUARKUS_BLANK_APP_IMAGE_URL` --> The URL that points to the Quarkus Blank App for Dev deployments.

`KIE_SANDBOX_DEV_DEPLOYMENT_DMN_FORM_WEBAPP_IMAGE_URL` --> The URL that points to the DMN Form Webapp for Dev deployments.

`KIE_SANDBOX_DEV_DEPLOYMENT_IMAGE_PULL_POLICY` --> Pull Policy of images used by Dev deployments. Can be `Always` or `IfNotPresent`.

`KIE_SANDBOX_REQUIRE_CUSTOM_COMMIT_MESSAGE` --> Require users to type a custom commit message when creating a new commit.

`KIE_SANDBOX_CUSTOM_COMMIT_MESSAGES_VALIDATION_SERVICE_URL` --> Service URL to validate commit messages.

`KIE_SANDBOX_AUTH_PROVIDERS` --> Authentication providers configuration. Used to enable integration with GitHub Enterprise Server instances and more.

`KIE_SANDBOX_ACCELERATORS` --> Accelerators configuration. Used to add a template to a set of Decisions and Workflows, making it buildable and deployable.

`KIE_SANDBOX_EDITORS` --> Editors configuration. Allows the enabling/disabling of specific editors and removes the disabled editors from the home page.

`KIE_SANDBOX_APP_NAME` --> Allows BAMOE Canvas to be referred by a different name.

### Examples

1.  Using a different Extended Services deployment.

    ```bash
    docker run -t -p 9090:8080 -e KIE_SANDBOX_EXTENDED_SERVICES_URL=<my_value> -i --rm quay.io/bamoe/canvas:9.2.1-ibm-0005
    ```

2.  Enabling authentication with a GitHub Enterprise Server instance.

    ```
    docker run -t -p 9090:8080 -e KIE_SANDBOX_AUTH_PROVIDERS='[{ "id":"github_at_my_company", "domain":"github.my-company.com", "supportedGitRemoteDomains":["github.my-company.com","gist.github.my-company.com"], "type":"github", "name":"GitHub @ MyCompany", "enabled":true, "group":"git" }]' -i --rm quay.io/bamoe/canvas:9.2.1-ibm-0005
    ```

3.  Requiring users to input a custom commit message on every commit.

    ```bash
    docker run -t -p 9090:8080 -e KIE_SANDBOX_REQUIRE_CUSTOM_COMMIT_MESSAGE='true' -i --rm quay.io/bamoe/canvas:9.2.1-ibm-0005
    ```

4.  Requiring users to input a custom commit message on every commit and validate it via an [example Commit Message Validation Service from Apache KIE](https://github.com/apache/incubator-kie-tools/tree/main/examples/commit-message-validation-service).

    ```bash
    docker run -t -p 9090:8080 -e KIE_SANDBOX_REQUIRE_CUSTOM_COMMIT_MESSAGE='true' KIE_SANDBOX_CUSTOM_COMMIT_MESSAGE_VALIDATION_SERVICE_URL='http://localhost:8090/validate' -i --rm quay.io/bamoe/canvas:9.2.1-ibm-0005
    ```

5.  Adding Accelerators available for your users.

    ```bash
docker run -t -p 9090:8080 -e KIE_SANDBOX_ACCELERATORS='[{ "name": "Quarkus", "iconUrl": "https://github.com/ibm/bamoe-canvas-quarkus-accelerator/raw/9.2.1-ibm-0005-quarkus-full/logo.png", "gitRepositoryUrl": "https://github.com/ibm/bamoe-canvas-quarkus-accelerator", "gitRepositoryGitRef": "9.2.1-ibm-0005-quarkus-full", "dmnDestinationFolder": "src/main/resources/dmn", "bpmnDestinationFolder": "src/main/resources/bpmn", "otherFilesDestinationFolder": "src/main/resources/others" }]' -i --rm quay.io/bamoe/canvas:9.2.1-ibm-0005
    ```

6.  Write a custom `Containerfile/Dockerfile` from the image:

    ```docker
    FROM quay.io/bamoe/canvas:9.2.1-ibm-0005

    ENV KIE_SANDBOX_EXTENDED_SERVICES_URL=<my_value>
    ENV KIE_SANDBOX_CORS_PROXY_URL=<my_value>
    ENV KIE_SANDBOX_DEV_DEPLOYMENT_BASE_IMAGE_URL=<my_value>
    ENV KIE_SANDBOX_DEV_DEPLOYMENT_KOGITO_QUARKUS_BLANK_APP_IMAGE_URL=<my_value>
    ENV KIE_SANDBOX_DEV_DEPLOYMENT_DMN_FORM_WEBAPP_IMAGE_URL=<my_value>
    ENV KIE_SANDBOX_DEV_DEPLOYMENT_IMAGE_PULL_POLICY=<my_value>
    ENV KIE_SANDBOX_REQUIRE_CUSTOM_COMMIT_MESSAGE=<my_value>
    ENV KIE_SANDBOX_CUSTOM_COMMIT_MESSAGE_VALIDATION_SERVICE_URL=<my_value>
    ENV KIE_SANDBOX_AUTH_PROVIDERS=<my_value>
    ENV KIE_SANDBOX_ACCELERATORS=<my_value>
    ENV KIE_SANDBOX_EDITORS=<my_value>
    ENV KIE_SANDBOX_APP_NAME=<my_value>
    ```

7.  Create the application from the image in OpenShift and set the deployment environment variable right from the OpenShift UI.

### Providing your own _Commit message validation service_

To validate a commit message against your custom rules you'll need to provide a service that takes the message as input and returns the desired validation.

BAMOE Canvas expects that your service provides an endpoint for a POST request containing the commit message in its body:

```
POST http://yourdomain.com/commit-message-validation-url
Content-Type: text/plain

This is the commit message to be validated.
```

In return, your service should respond with a JSON object with the properties `result` and `reasons`.

- `result`: Boolean value ( `true` | `false` ). True if the validation passes, else false.
- `reasons`: Array of strings with the reasons why the validation failed (only when `result = false`). If `result = true` this property can be an empty array or omitted completely.

### Validations

#### Validation success

```bash
HTTP/1.1 200 OK
Content-Type: application/json

{
    "result": true,
}
```

#### Validation failed (single reason)

```bash
HTTP/1.1 200 OK
Content-Type: application/json

{
    "result": false,
    "reasons": ["Message exceeds the maximum length of 72 characters."]
}
```

#### Validation failed (multiple reasons)

```bash
HTTP/1.1 200 OK
Content-Type: application/json

{
    "result": false,
    "reasons": [
      "Message exceeds the maximum length of 72 characters.",
      "Missing required prefix with issue number in the format: my-issue#123."
    ]
}
```

#### Errors

- **Unreachable URL**

  BAMOE Canvas will display an error message if the validation service URL is unreachable and won't allow the user to proceed with the commit.

- **HTTP Status different from 200**

  If the service responds with an HTTP code other than 200, an error message is displayed alongside the HTTP Code + the response body of the request in full.

### Accelerators

Accelerators are Git repositories that contain a skeleton of an application and will convert a working directory with your .dmn and .bpmn files into a fully functional application that can be built and deployed.

After creating yours you must define where resources should be placed inside these repositories. For example, `.dmn` files should be placed inside `src/main/resources` for a Quarkus application. As a bonus, adding an image/logo can be used to better represent your Accelerator wherever it's listed.

#### The Accelerator configuration

Having all of that, it's time to create the configuration required to add it to the **`KIE_SANDBOX_ACCELERATORS`** list env var.
It looks like this:

```json
{
    "name": "Your Accelerator name",
    "iconUrl": "https://link.to/your/logo/image",
    "gitRepositoryUrl": "https://github.com/...",
    "gitRepositoryGitRef": "branchName",
    "dmnDestinationFolder": "path/to/place/dmn/files",
    "bpmnDestinationFolder": "path/to/place/bpmn/files",
    "otherFilesDestinationFolder": "path/to/place/other/files"
}
```

- **name**: This is how the Accelerator will be known inside BAMOE Canvas.
- **iconUrl**: An optional parameter to add an image/logo besides you Accelerator name.
- **gitRepositoryUrl**: This is where your Accelerator is hosted. Should be an URL that can be used with `git clone`.
- **gitRepositoryGitRef**: Where in your repository is this Accelerator located. Could be a branch, commit, tag, anything that can be used with `git checkout`.
- **dmnDestinationFolder**: Where your DMN and PMML files will be moved to after applying the Accelerator.
- **bpmnDestinationFolder**: Where your BPMN files will be moved to after applying the Accelerator.
- **otherFilesDestinationFolder**: Where other files will be moved to after applying the Accelerator.

Here's an example of what it should look like:

```json
{
    "name": "Quarkus",
    "iconUrl": "https://github.com/ibm/bamoe-canvas-quarkus-accelerator/raw/9.2.1-ibm-0005-quarkus-full/logo.png",
    "gitRepositoryUrl": "https://github.com/ibm/bamoe-canvas-quarkus-accelerator",
    "gitRepositoryGitRef": "9.2.1-ibm-0005-quarkus-full",
    "dmnDestinationFolder": "src/main/resources/dmn",
    "bpmnDestinationFolder": "src/main/resources/bpmn",
    "otherFilesDestinationFolder": "src/main/resources/others"
}
```

### Editors

By default BPMN and DMN Editors will be enabled. To disable an editor simply delete/comment out the respective json.

- **extension**: The extension of the file that you want to edit.
- **filePathGlob**: The glob pattern of the file you want to edit.
- **editor.resourcesPathPrefix**: The path to the gwt-editor.
- **editor.path**: The path of the editor envelope.html.
- **card.title**: The title of the editor that will be displayed on the home page.
- **card.description**: Displays a short description of the editor under the title on the home page.

Here's an example of what it should look like:

```json
    [{
      "extension": "bpmn",
      "filePathGlob": "**/*.bpmn?(2)",
      "editor": {
        "resourcesPathPrefix": "gwt-editors/bpmn",
        "path": "bpmn-envelope.html"
      },
      "card": {
        "title": "Workflow",
        "description": "BPMN files are used to generate business workflows."
      }
    },
    {
      "extension": "dmn",
      "filePathGlob": "**/*.dmn",
      "editor": {
        "resourcesPathPrefix": "",
        "path": "new-dmn-editor-envelope.html"
      },
      "card": {
        "title": "Decision",
        "description": "DMN files are used to generate decision models"
      }
    }]
```

### Custom branding

BAMOE Canvas can be customized to show your own logo and/or branding by extending this image and overriding environment variables and files.

- **Header logo:** Override `/var/www/html/images/app_logo_rgb_fullcolor_reverse.svg`. Fixed height of `38px`.
- **Colored logo:** Override `/var/www/html/images/app_logo_rgb_fullcolor_default.svg`. Fixed height of `80px`.
- **Favicon:** Override `/var/www/html/favicon.svg`
- **App name:** Use the `KIE_SANDBOX_APP_NAME` environment variable.

### Custom base image for Dev Deployments

BAMOE Canvas allows for the base image used on Dev deployments to be customized. For example:

```docker
ENV KIE_SANDBOX_DEV_DEPLOYMENT_BASE_IMAGE_URL="quay.io/bamoe/canvas-dev-deployment-base:9.2.1-ibm-0005"
```
