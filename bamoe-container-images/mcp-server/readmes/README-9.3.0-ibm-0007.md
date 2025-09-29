# BAMOE MCP Server (Tech Preview)
Exposes Business Services as tools to external AI agents using the [MCP protocol](https://modelcontextprotocol.io/). BAMOE MCP Server is currently a tech preview and may contain bugs.

## Run
```
docker run -it --rm\
  -p 8084:8080 \
  -e MCP_SERVER_OPENAPI_URLS="http://localhost:8080/q/openapi,http://localhost:8081/q/openapi" \
  quay.io/bamoe/mcp-server:9.3.0-ibm-0007
```

BAMOE MCP Server (Tech Preview) will start on `http://localhost:8084`, automatically registering Business Services running on both `http://localhost:8080` and `http://localhost:8081`. Connecting your AI agents to `http://localhost:8084` via MCP allows your AI agent to trigger Processes and evaluate Decisions and Rules.

## Environment variables

### Required

- `MCP_SERVER_OPENAPI_URLS`: A comma-separated list of strings that represent OpenAPI endpoints that the MCP Server will scrape in order to register tools for AI agents to call, based on the available assets (Processes, Decisions, and Rules) contained in the Business Service(s) exposed in those endpoints.