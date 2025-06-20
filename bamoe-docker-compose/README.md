# BAMOE Docker Compose

Contains convenience files for a local setup of BAMOE.

---

Open a Terminal windows and run the following command to get started:

```shell
export MAVEN_ARGS="-s $(realpath ./settings.xml)" 
docker compose up -d
```

The following containers will be up:
- `bamoe_canvas` @ http://localhost:9090
- `bamoe_extended_services` @ http://localhost:21345
- `bamoe_cors_proxy` @ http://localhost:7081
- `bamoe_maven_repository` @ http://localhost:9999
- `bamoe_management_console` @ http://localhost:9091

And all invocations of Maven (`mvn`) for that Terminal window will be able to download content from BAMOE Maven repository.

See [Getting started → Initial Business Service project setup and walkthrough](https://www.ibm.com/docs/en/ibamoe/9.2.x?topic=started-initial-business-service-project-setup-walkthrough) to start your first project with BAMOE.