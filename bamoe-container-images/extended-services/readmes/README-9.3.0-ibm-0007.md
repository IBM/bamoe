# BAMOE Extended Services

Extended Services that enhance BAMOE Canvas capabilities. This image powers DMN Runner and static validation for DMN and BPMN files.

## Run

```bash
docker run -t -p 21345:21345 -i --rm quay.io/bamoe/extended-services:9.3.0-ibm-0007
# BAMOE Extended Services will be up at http://localhost:21345
```

---


> NOTE: The CORS proxy capabilities for communicating with cloud providers have moved to `quay.io/bamoe/cors-proxy`, starting from version `9.1.0-ibm-0001`.
