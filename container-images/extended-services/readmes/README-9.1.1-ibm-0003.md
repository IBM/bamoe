# BAMOE Extended Services

Extended Services that enhance BAMOE Canvas capabilities. This image powers DMN Runner and static validation for DMN and BPMN files.

## Run

```bash
docker run -t -p 8081:21345 -i --rm quay.io/bamoe/extended-services:9.1.1-ibm-0003
# BAMOE Extended Services will be up at http://localhost:8081
```

---


> NOTE: The CORS proxy capabilities for communicating with cloud providers have moved to `quay.io/bamoe/cors-proxy`, starting from version `9.1.0-ibm-0001`.