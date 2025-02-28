<!--
   Licensed to the Apache Software Foundation (ASF) under one
   or more contributor license agreements.  See the NOTICE file
   distributed with this work for additional information
   regarding copyright ownership.  The ASF licenses this file
   to you under the Apache License, Version 2.0 (the
   "License"); you may not use this file except in compliance
   with the License.  You may obtain a copy of the License at
     http://www.apache.org/licenses/LICENSE-2.0
   Unless required by applicable law or agreed to in writing,
   software distributed under the License is distributed on an
   "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
   KIND, either express or implied.  See the License for the
   specific language governing permissions and limitations
   under the License.
-->

# Example :: Process Persistence

This example depicts the usage of persistence configuration for various databases like H2, Postgresql and MS SQL. 
This application can be run in dev and container modes.

This example also showcases a basic implementation of a **Hiring** Process that drives a _Candidate_ through different
interviews until they get hired. It features simple User Task orchestration including the use of DMN decisions to
generate the candidate's offer and timers to skip interviews. This example is based on `process-compact-architecture` 
example. You could find more details about that example from its README.

---

## Configuration

As mentioned earlier, this example can be run in quarkus development mode and in container mode. In dev mode, the 
example could use `h2`, `postgresql` or `mssql`. In container mode it can use `postgresql` or `mssql`.

Each database is paired with a maven profile and a quarkus profile which are tied together. So in this example there 
are four maven profiles `h2`, `postgresql`, `mssql` and `container` tied to quarkus profiles with similar 
name. `h2`, `postgresql` and `mssql` profiles defines their own specific database dependencies and configurations.
`container` profile defines the dependencies to pack the example as a docker image and configurations of the image.

In dev mode, Quarkus provides us with a zero config database out of the box, a feature referred to as Dev Services.
The only configuration that needs to be defined is `quarkus.datasource.db-kind` and the only main dependency required 
is the corresponding jdbc driver. H2 runs in-process, whereas postgresql and mssql runs as containers. So you will 
need Docker installed in order to use this feature. More information about Dev Services can be found 
[here](https://quarkus.io/guides/databases-dev-services).

In container mode, the example is run as docker containers. First the example need to be packed into a docker image. 
The configurations of the docker image is defined under the quarkus container profile. The `container` maven profile 
is coupled with another maven database profile like `postgresql` or `mssql` to build the example's image. The image 
is then used in a corresponding docker compose file which also includes the database and any other related database 
services. The application can be started easily by using the [startContainer.sh](docker-compose/startContainers.sh) 
script

---

## Running

### Prerequisites

- Java 17+ installed
- Environment variable JAVA_HOME set accordingly
- Maven 3.9.6+ installed
- Docker and Docker Compose to run the required example infrastructure.

### Running as containers

First, build the example by running the following command in a terminal

```shell
mvn clean package -Pcontainer,<dbtype>
```
Current supported dbtypes in container mode are `postgresql` and `mssql`. So for e.g. to build the example using 
postgresql database configuration we can run the following command

```shell
mvn clean package -Pcontainer,postgresql
```
This will build this example's Quarkus application with the corresponding database configuration and create a Docker 
image that will be used in the `docker-compose` template.

To execute the full example, run the following command inside the `docker-compose` folder

```shell
# cd docker-compose
sh startContainers.sh <dbtype>
```
If we don't specify a dbtype `sh startContainers.sh`, database configurations of postgresql is used by default in 
container mode.

> **_IMPORTANT:_** if you are running this example on macOS and you are not using **Docker Desktop**, please append
> the following entry in your `/etc/hosts` file to enable a good communication between al components.
>
> ```
> 127.0.0.1 kubernetes.docker.internal
> ```

### Running in Development mode

The development mode in this application currently supports three databases: `h2`, `postgresql` and `mssql`. The dev 
mode will embed all the needed Infrastructure Services (Database, Data-Index & Jobs Service) and won't require any 
extra step. To start this example's app in Development mode with a specific database configuration, just run the 
following command in a terminal
```shell
mvn clean package quarkus:dev -P<dbtype>
```
So for e.g. to start the example in dev mode using `postgresql` database configuration we can run the following command:
```shell
mvn clean package quarkus:dev -Ppostgresql
```
If we don't specify a profile `mvn clean package quarkus:dev`, database configurations of h2 is used by default in dev mode.

---

## Using

### Starting an instance of the Hiring Process

Once the service is up and running you can make use of the **Hiring** application by a sending request to
`http://localhost:8080/hiring`.

Sending the following valid `CandidateData` will start a process instance that will land into the _HR Interview_ task:

```json
{
  "candidateData": {
    "name": "Jon",
    "lastName": "Snow",
    "email": "jon@snow.org",
    "experience": 5,
    "skills": ["Java", "Kogito", "Fencing"]
  }
}
```

In a Terminal you can execute this curl command to start a **Hiring** process:

```bash
curl -H "Content-Type: application/json" -H "Accept: application/json" -X POST http://localhost:8080/hiring -d '{"candidateData": { "name": "Jon", "lastName": "Snow", "email": "jon@snow.org", "experience": 5, "skills": ["Java", "Kogito", "Fencing"]}}'
```

If everything went well you may get a response like:

```json
{
  "id": "628e679f-4deb-4abc-9f28-668914c64ef9",
  "offer": {
    "category": "Senior Software Engineer",
    "salary": 40450
  }
}
```

In the server logs you may find a trace like:

```
New Hiring has been created for candidate: Jon Snow
###################################
Generated offer for candidate: Jon Snow
Job Category: Senior Software Engineer
Base salary: 40450
###################################
```

Use the following `CandidateData` that don't match the minimal candidate requirements, to start a process that will
automatically end:

```json
{
  "candidateData": {
    "name": "Jon",
    "lastName": "Snow",
    "email": "jon@snow.org",
    "experience": 0,
    "skills": []
  }
}
```

In a Terminal you can execute this curl command to start a **Hiring** process:

```bash
curl -H "Content-Type: application/json" -H "Accept: application/json" -X POST http://localhost:8080/hiring -d '{"candidateData": { "name": "Jon", "lastName": "Snow", "email": "jon@snow.org", "experience": 0, "skills": []}}'
```

If everything went well you may get a response like:

```json
{
  "id": "3659601a-bb59-458d-859e-7892621ad5b7",
  "offer": null
}
```

In the server log You may find a trace like:

```
New Hiring has been created for candidate: Jon Snow
###################################
Candidate Jon Snow don't meet the requirements for the position but we'll keep it on records for the future!
###################################
```

### Completing the Hiring Process

- After starting a hiring process that meets the minimal candidate requirements, it starts an HR Interview Task. The task 
has a _Timer_ that will skip the task if it's not completed in a given amount of time (3 minutes in this example). We can
either wait 3 minutes to see the timer in action making the process instance skip the HR Interview task or complete the 
process by following the next steps.

- Inorder to complete the HR Interview task we can use the below curl command

```bash
curl -X POST "http://localhost:8080/usertasks/instance/{taskId}/transition?user=jdoe" -H "content-type: application/json" -d '{"transitionId": "complete","data": {"offer": {"category": "Senior Software Engineer","salary": 45000},"approve": true}}'
```
The taskId could be retrieved by running below command which returns all the usertasks assigned to the user. The id
field in the response is the required taskId.
```bash
curl -X GET "http://localhost:8080/usertasks/instance?user=jdoe"
```
- After the HR Interview Task is completed, we now have a new IT Interview Task that needs to be completed. Use the 
below command to complete the task
```bash
curl -X POST "http://localhost:8080/usertasks/instance/{taskId}/transition?user=jdoe" -H "content-type: application/json" -d '{"transitionId": "complete","data": {"approve": true}}'
```
As mentioned above the taskId for IT Interview Task also can be fetched using below query
```bash
curl -X GET "http://localhost:8080/usertasks/instance?user=jdoe"
```
- Once the IT Interview Task is successfully completed, in the server logs you may be able to see something like
```
###################################
To: jon@snow.org
Subject: Congratulations you made it!
Dear Jon Snow, we are happy to tell you that you've successfully went through the hiring process. You'll find the final Offer details in attached.
Job Category: Senior Software Engineer
Base salary: 45000
###################################
```
