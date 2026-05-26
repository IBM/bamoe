# BAMOE Extended Services (9.4.1-ibm-0002)

Extended Services that enhance BAMOE Canvas capabilities. This image powers DMN Runner and static validation for DMN and BPMN files.

## Run

```bash
docker run -t -p 21345:21345 -i --rm quay.io/bamoe/extended-services:9.4.1-ibm-0002
# BAMOE Extended Services will be up at http://localhost:21345
```

---


> NOTE: The CORS proxy capabilities for communicating with cloud providers have moved to `quay.io/bamoe/cors-proxy`, starting from version `9.1.0-ibm-0001`.
