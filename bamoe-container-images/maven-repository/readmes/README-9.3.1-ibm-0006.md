# BAMOE Maven Repository

A static web server that serves as a Maven Repository for downloading Maven artifacts containing the multiple modules that compose BAMOE runtime libraries.

## Run

```bash
docker run -t -p 9999:8080 -i --rm quay.io/bamoe/maven-repository:9.3.1-ibm-0006
# BAMOE Maven Repository will be up at http://localhost:9999
```

## Using with Maven

Use the `~/.m2/repository/settings.xml` file (or any other you have configured as your `localRepository`) for Maven.

```xml
<settings
  xmlns="http://maven.apache.org/SETTINGS/1.0.0"
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xsi:schemaLocation="http://maven.apache.org/SETTINGS/1.0.0 https://maven.apache.org/xsd/settings-1.0.0.xsd"
>
  <profiles>
    <profile>
      <id>ibm-bamoe-maven-repository</id>
      <repositories>
        <repository>
          <id>ibm-bamoe-maven-repository</id>
          <url>http://localhost:9999</url>
          <releases>
            <enabled>true</enabled>
          </releases>
          <snapshots>
            <enabled>false</enabled>
          </snapshots>
        </repository>
      </repositories>
      <pluginRepositories>
        <pluginRepository>
          <id>ibm-bamoe-maven-repository</id>
          <url>http://localhost:9999</url>
          <releases>
            <enabled>true</enabled>
          </releases>
          <snapshots>
            <enabled>false</enabled>
          </snapshots>
        </pluginRepository>
      </pluginRepositories>
    </profile>
  </profiles>

  <activeProfiles>
    <activeProfile>ibm-bamoe-maven-repository</activeProfile>
  </activeProfiles>
</settings>
```
