# BAMOE MCP Server (Tech Preview)
Exposes Business Services as tools to external AI agents using the [MCP protocol](https://modelcontextprotocol.io/). BAMOE MCP Server is currently a tech preview and may contain bugs.

## Run
```
docker run -it --rm\
  -p 8084:8080 \
  -e MCP_SERVER_OPENAPI_URLS="http://localhost:8080/q/openapi,http://localhost:8081/q/openapi" \
  quay.io/bamoe/mcp-server:9.3.1-ibm-0006
```

BAMOE MCP Server (Tech Preview) will start on `http://localhost:8084`, automatically registering Business Services running on both `http://localhost:8080` and `http://localhost:8081`. Connecting your AI agents to `http://localhost:8084` via MCP allows your AI agent to trigger Processes and evaluate Decisions and Rules.

## Environment variables

### Required

- `MCP_SERVER_OPENAPI_URLS`: A comma-separated list of strings that represent OpenAPI endpoints that the MCP Server will scrape in order to register tools for AI agents to call, based on the available assets (Processes, Decisions, and Rules) contained in the Business Service(s) exposed in those endpoints.

### Optional

- `MCP_SERVER_DEBUG_LEVEL`: A **string** which determines the MCP Server Log level. Default is "INFO". Possible values are: "ALL", "TRACE", "DEBUG", "INFO", "WARN", "ERROR", "FATAL", "OFF"
- `MCP_SERVER_SECURITY_ENABLED`: A **boolean** that determines whether to enable the security layer. Default is false
- `MCP_SERVER_SECURITY_OIDC_CLIENT_ID`= A **string** which defines the client_id for the authentication process. No default value.
- `MCP_SERVER_SECURITY_AUTH_PERMISSION`=: A **string** which defines the permission level to apply to the MCP Server endpoints. Default is "permit", Possible values are: "permit", "authenticated" and "deny". See more [here](https://quarkus.io/guides/security-authorize-web-endpoints-reference#authorization-using-configuration).
- `MCP_SERVER_SECURITY_AUTH_SECRET` = A **string** which holds the secret required for the authentication process. Not stored in any intermediate step. No default value.
- `MCP_SERVER_SECURITY_AUTH_SERVER_URL` = A **string** that contains the url of the OIDC instance. Not stored in any intermediate step. No default value.

> NOTE: If you're running this image in a local environment using a desktop container tool (such as Rancher Desktop, Colima, or Docker Desktop), and you need to access services running on your host machine from inside the container, use `host.containers.internal` instead of `localhost`.
> This is necessary because `localhost` inside the container refers to the container itself, not your host machine. The special DNS name `host.containers.internal` allows the container to reach services exposed by your host system.