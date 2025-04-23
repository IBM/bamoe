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

This example depicts the usage of persistence configuration for various databases like H2, Postgresql, MS SQL and Oracle. 
This application can be run in dev and container modes.

This example also showcases a basic implementation of a **Hiring** Process that drives a _Candidate_ through different
interviews until they get hired. It features simple User Task orchestration including the use of DMN decisions to
generate the candidate's offer and timers to skip interviews. This example is based on `process-compact-architecture` 
example. You could find more details about that example from its README.

---

## Configuration

As mentioned earlier, this example can be run in quarkus development mode and in container mode. In dev mode, the 
example could use `h2`, `postgresql`, `mssql` or `oracle`. In container mode it can use `postgresql`, `mssql` or `oracle`.

Each database is paired with a maven profile and a quarkus profile which are tied together. So in this example there 
are five maven profiles `h2`, `postgresql`, `mssql`, `oracle` and `container` tied to quarkus profiles with similar 
name. `h2`, `postgresql`, `mssql` and `oracle` profiles defines their own specific database dependencies and configurations 
whereas `container` profile defines the dependencies and configurations to pack the example as a docker image.

In Dev mode, Quarkus provides us with a zero config database out of the box, a feature referred to as Dev Services.
The only configuration that needs to be defined is `quarkus.datasource.db-kind` and the only main dependency required 
is the corresponding jdbc driver. Don’t configure a database URL, username and password if you intend to use Dev 
Services. If you would still like to customize the database properties, you can refer 
[this](https://quarkus.io/version/3.15/guides/databases-dev-services#configuration-reference). More information about 
Dev Services can be found [here](https://quarkus.io/version/3.15/guides/databases-dev-services).

If you like to use your own database you could add necessary datasource properties from 
[here](https://quarkus.io/version/3.15/guides/datasource#jdbc-configuration). When you add a direct datasource 
property, Quarkus does not start a Dev Service database but instead will look for a user provided database.

One of the common dependency across various database profile is Agroal. It is an advanced datasource connection pool 
implementation with integration with transaction and security.
```
<dependency>
    <groupId>io.quarkus</groupId>
    <artifactId>quarkus-agroal</artifactId>
</dependency>
```

Let's take a look at each profile and the configurations in detail.

### H2

This is the maven profile for H2

```
<profile>
    <id>h2</id>
    <activation>
        <activeByDefault>true</activeByDefault>
    </activation>
    <properties>
        <quarkus.profile>h2</quarkus.profile>
    </properties>
    <dependencies>
        <dependency>
            <groupId>io.quarkus</groupId>
            <artifactId>quarkus-jdbc-h2</artifactId>
        </dependency>
    </dependencies>
</profile>
```
So H2 is the default database if we don't specify any profile. The only dependency needed is h2 jdbc driver.

This is the configuration for H2
```
%h2.quarkus.datasource.db-kind=h2
%h2.quarkus.datasource.devservices.properties.NON_KEYWORDS=VALUE,KEY
```

`quarkus.datasource.devservices.properties.NON_KEYWORDS=VALUE,KEY` is a generic property that is usually added 
to the database connection url. The flyway scripts defines tables with columns names like `key` and `value`. But 
these are reserved words when working with H2. So this property effectively allows to create columns with these 
names without any problems.

The H2 database runs in-process.

### Postgresql

This is the maven profile for Postgresql
```
<profile>
    <id>postgresql</id>
    <properties>
        <quarkus.profile>postgresql</quarkus.profile>
    </properties>
    <dependencies>
        <dependency>
            <groupId>io.quarkus</groupId>
            <artifactId>quarkus-jdbc-postgresql</artifactId>
        </dependency>
    </dependencies>
</profile>
```
The only dependency needed is postgresql jdbc driver.

This is the configuration for Postgresql
```
%postgresql.quarkus.datasource.db-kind=postgresql
```

When running the example in Dev mode, Quarkus will stat a `Postgresql` database container as a part of the Dev
Services. So make sure to install docker before running this example.

### MS SQL Server

This is the maven profile for MS SQL Server
```
<profile>
    <id>mssql</id>
    <properties>
        <quarkus.profile>mssql</quarkus.profile>
    </properties>
    <dependencies>
        <dependency>
            <groupId>io.quarkus</groupId>
            <artifactId>quarkus-jdbc-mssql</artifactId>
        </dependency>
        <dependency>
            <groupId>com.ibm.bamoe</groupId>
            <artifactId>bamoe-mssql-mappings</artifactId>
            <version>${version.com.ibm.bamoe}</version>
        </dependency>
    </dependencies>
</profile>
```
The dependencies needed are mssql jdbc driver and `bamoe-mssql-mappings`.

This is the configuration for MS SQL Server
```
%mssql.quarkus.datasource.db-kind=mssql
%mssql.quarkus.hibernate-orm.mapping-files=META-INF/bamoe-data-index-orm.xml,META-INF/bamoe-job-service-orm.xml
```

The `bamoe-mssql-mappings` is a utility library to help Job Service and Data Audit storage work properly with 
`MS SQL Server`. It contains the hibernate orm.xml that will remap some of the JPA entities contained in both modules.

The available orm's are:
- META-INF/bamoe-data-index-orm.xml: This file remaps some entities from the data-index component.
- META-INF/bamoe-job-service-orm.xml: This file remaps some entities from the job-service component.

When running the example in Dev mode, Quarkus will start a `MS SQL Server` database container as a part of the Dev 
Services. So make sure to install docker before running this example. In order to use mssql database as a Dev Service 
it also requires us to have a [license acceptance file](src/main/resources/container-license-acceptance.txt). More on
this [here](https://quarkus.io/version/3.15/guides/databases-dev-services#license_acceptance).

### Oracle

This is the maven profile for Oracle
```
  <profile>
            <id>oracle</id>
            <properties>
                <quarkus.profile>oracle</quarkus.profile>
            </properties>
            <dependencies>
                <dependency>
                    <groupId>io.quarkus</groupId>
                    <artifactId>quarkus-jdbc-oracle</artifactId>
                </dependency>
                <dependency>
                    <groupId>com.ibm.bamoe</groupId>
                    <artifactId>bamoe-oracle-mappings</artifactId> 
                    <version>${version}</version>
                </dependency>
            </dependencies>
        </profile>
```
The dependencies needed are `oracle jdbc driver` and `bamoe-oracle-mappings`.

This is the configuration for Oracle
```
%oracle.quarkus.datasource.db-kind=oracle
%oracle.quarkus.hibernate-orm.mapping-files=META-INF/bamoe-user-task-orm.xml,META-INF/bamoe-job-service-orm.xml
```

The `bamoe-oracle-mappings` is a utility library to help Job Service and Data Audit storage work properly with 
`Oracle`. It contains the hibernate orm.xml that will remap some of the JPA entities contained in both modules.

The available orm's are:
- META-INF/bamoe-user-task-orm.xml: This file remaps some entities from the jbpm-usertask-storage-jpa component.
- META-INF/bamoe-job-service-orm.xml: This file remaps some entities from the job-service component.


Depending on the dependencies configured in our application it may be required to configure the ORMs to be used.
To configure which mapping files should be imported you can use the `quarkus.hibernate-orm.mapping-files` property to 
configure a comma-separated list of ORM files to use.

When running the example in Dev mode, Quarkus will start a `Oracle` database container as a part of the Dev 
Services. So make sure to install docker before running this example. 

### Container

This is the container maven profile
```
<profile>
    <id>container</id>
    <properties>
        <quarkus.profile>container</quarkus.profile>
    </properties>
    <dependencies>
        <dependency>
            <groupId>io.quarkus</groupId>
            <artifactId>quarkus-container-image-jib</artifactId>
        </dependency>
    </dependencies>
</profile>
```
The `quarkus-container-image-jib` library is used to package the example as a docker image.

This is the corresponding configuration
```
%container,postgresql,mssql,oracle.quarkus.container-image.build=true
%container,postgresql,mssql,oracle.quarkus.container-image.push=false
%container,postgresql,mssql,oracle.quarkus.container-image.group=bamoe
%container,postgresql,mssql,oracle.quarkus.container-image.registry=dev.local
%container,postgresql,mssql,oracle.quarkus.container-image.tag=${project.version}
%postgresql.quarkus.container-image.name=process-persistence-postgresql
%mssql.quarkus.container-image.name=process-persistence-mssql
%oracle.quarkus.container-image.name=process-persistence-oracle
```

These are the configurations of the resulting image. The `container` profile is used in tandem with a database profile 
like `postgresql` or `mssql` or`oracle` to pack related database dependencies and configurations. The resulting image is then 
used in a docker compose file to run all services including this example, database and any other database addon 
services together as containers. The docker compose files are located [here](docker-compose).

---

## Running

### Prerequisites

- Java 17+ installed
- Environment variable JAVA_HOME set accordingly
- Maven 3.9.6+ installed
- Docker and Docker Compose to run the required example infrastructure.

### Running as containers

First, build the example by running the following command in a terminal

```
mvn clean package -Pcontainer,<dbtype>
```
Current supported dbtypes in container mode are `postgresql`, `mssql` and `oracle`. So for e.g. to build the example using 
postgresql database configuration we can run the following command

```shell
mvn clean package -Pcontainer,postgresql
```
This will build this example's Quarkus application with the corresponding database configuration and create a Docker 
image that will be used in the `docker compose` template.

Finally, to start the example using `docker compose`, run

```
docker compose -f ./docker-compose/docker-compose-<dbtype>.yml up
```

For e.g. to start the example with postgresql run

```bash
docker compose -f ./docker-compose/docker-compose-postgresql.yml up
```

To stop and remove containers run

```
docker compose -f ./docker-compose/docker-compose-<dbtype>.yml down
```

### Running in Development mode

The development mode in this application currently supports three databases: `h2`, `postgresql`, `mssql` and `oracle`. The dev 
mode will embed all the needed Infrastructure Services (Database, Data-Index & Jobs Service) and won't require any 
extra step. To start this example's app in Development mode with a specific database configuration, just run the 
following command in a terminal
```
mvn clean package quarkus:dev -P<dbtype>
```
So for e.g. to start the example in dev mode using `postgresql` database configuration we can run the following command:
```shell
mvn clean package quarkus:dev -Ppostgresql
```
If we don't specify a profile, database configurations of h2 is used by default in dev mode.
```shell
mvn clean package quarkus:dev
```

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
