# BAMOE Extended Services

Extended Services that enhance BAMOE Canvas capabilities. This image powers DMN Runner, static validation for DMN and BPMN files, and features a generic CORS proxy that is used to communicate with OpenShift and Kubernetes clusters that don't allow requests coming from BAMOE Canvas webpage.

## Run

```bash
docker run -t -p 8081:21345 -i --rm quay.io/bamoe/extended-services:9.0.0
# BAMOE Extended Services will be up at http://localhost:8081
```