# BAMOE Maven Repository

A static web server that serves as a Maven Repository for downloading Maven artifacts containing the multiple modules that compose BAMOE runtime libraries.

## Run

```bash
docker run -t -p 8080:80 -i --rm quay.io/bamoe/maven-repository:9.1.0-ibm-0001
# BAMOE Maven Repository will be up at http://localhost:8080
```

## Using with Maven

Use the `settings.xml` on `~/.m2/repository` or any other directory you have configured as your `localRepository` for Maven.

```xml
<settings xmlns="http://maven.apache.org/SETTINGS/1.0.0"
        xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
        xsi:schemaLocation="http://maven.apache.org/SETTINGS/1.0.0 https://maven.apache.org/xsd/settings-1.0.0.xsd">

    <activeProfile>ibm-bamoe-enterprise-maven-repository</activeProfile>

    <profile>
        <id>ibm-bamoe-enterprise-maven-repository</id>
        <repositories>
            <repository>
                <id>ibm-bamoe-enterprise-maven-repository</id>
                <url>http://localhost:8080/</url>
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
                <id>ibm-bamoe-enterprise-maven-repository</id>
                <url>http://localhost:8080/</url>
                <releases>
                    <enabled>true</enabled>
                </releases>
                <snapshots>
                    <enabled>false</enabled>
                </snapshots>
            </pluginRepository>
        </pluginRepositories>
    </profile>

</settings>
```
