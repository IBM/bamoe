# BAMOE MCP Server

Provides an implementation of an **MCP Server** that exposes Business Services to external AI agents.

## Run
```bash
docker run -it --rm\
  -p 8080:8080 \
  --name mcp-server \
  -e MCP_SERVER_OPENAPI_URLS="http://host.docker.internal:8080/q/openapi" \
  quay.io/bamoe/mcp-server:9.3.0-ibm-0007
```

The MCP Server will start pointing to the provided BAMOE OpenApi page.

## Environment variables

### Required

- `MCP_SERVER_OPENAPI_URLS`: A **list of strings** that represents the OpenAPI endpoints that the MCP Server should parse to register Tools, based on the available Business services (Processes, Decisions, and Rules) exposed in those endpoints.