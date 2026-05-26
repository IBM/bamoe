# DMOE Runtime Environment Helm Chart (9.4.1-ibm-0002)

This chart can be used to deploy BAMOE Management Console and the MCP Server container images on a [Kubernetes](https://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

## Components

- Management Console: User interface for managing Workflows
- MCP Server: Tool for exposing Business Services as tools to external AI agents using the MCP protocol

## Installing the Chart

### On an OpenShift cluster

First, you may need to get the default OpenShift domain for your routes with this command:

```console
$ oc get ingresses.config cluster --output jsonpath={.spec.domain}
```

If you don't have access rights to this config, try creating a dummy Route resource and checking its domain.

To install the chart with the release name `dmoe-runtime`:

```console
helm pull oci://quay.io/bamoe/dmoe-runtime-environment-helm-chart --version=9.4.1-ibm-0002 --untar
helm install dmoe-runtime ./dmoe-runtime-environment-helm-chart --values ./dmoe-runtime-environment-helm-chart/values-openshift.yaml --set global.openshiftRouteDomain="<YOUR_OCP_ROUTE_DOMAIN>"
```

### On a generic Kubernetes cluster

To install the chart with the release name `dmoe-runtime`:

```console
helm pull oci://quay.io/bamoe/dmoe-runtime-environment-helm-chart --version=9.4.1-ibm-0002 --untar
helm install dmoe-runtime ./dmoe-runtime-environment-helm-chart --values ./dmoe-runtime-environment-helm-chart/values-kubernetes.yaml --set global.kubernetesClusterDomain="<YOUR_KUBERNETES_CLUSTER_DOMAIN>" --set global.kubernetesIngressClass="<YOUR_KUBERNETES_INGRESS_CLASS>"
```

### On a Minikube cluster with Nginx Ingress controller

To install the chart with the release name `dmoe-runtime`:

```console
helm pull oci://quay.io/bamoe/dmoe-runtime-environment-helm-chart --version=9.4.1-ibm-0002 --untar
helm install dmoe-runtime ./dmoe-runtime-environment-helm-chart --values ./dmoe-runtime-environment-helm-chart/values-minikube-nginx.yaml
```

### Using default values

To install the chart with the release name `dmoe-runtime`:

```console
helm install dmoe-runtime oci://quay.io/bamoe/dmoe-runtime-environment-helm-chart --version=9.4.1-ibm-0002
```

## Uninstalling the Chart

To uninstall the `dmoe-runtime` deployment:

```console
helm uninstall dmoe-runtime
```

## Passing Environmental variables

This chart uses default environmental variables from `values.yaml` file. Override those by passing it from command line.

```console
helm install dmoe-runtime oci://quay.io/bamoe/dmoe-runtime-environment-helm-chart --set image.repository=quay.io
```

## Configuration

The following table lists the configurable parameters of this helm chart and their default values.

| Key                                          | Type   | Default                                                                                                                                                                                                                                                 | Description                                                                                                                                      |
| -------------------------------------------- | ------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------ |
| global.chargedProductValues.productID        | string | `"46b14c7f2f894218a7879b3f6416024f"`                                                                                                                                                                                                                    |                                                                                                                                                  |
| global.chargedProductValues.productMetric    | string | `"VIRTUAL_PROCESSOR_CORE"`                                                                                                                                                                                                                              |                                                                                                                                                  |
| global.chargedProductValues.productName      | string | `"IBM Decision Manager Open Edition"`                                                                                                                                                                                                                   |                                                                                                                                                  |
| global.ingressSource                         | string | `""`                                                                                                                                                                                                                                                    | Which ingress source is being used (none/"minikube"/"kubernetes"/"openshift") Obs.: For NOTES generation only                                    |
| global.kubernetesClusterDomain               | string | `""`                                                                                                                                                                                                                                                    | If using Minikube or Kubernetes, set the cluster domain                                                                                          |
| global.kubernetesIngressClass                | string | `""`                                                                                                                                                                                                                                                    | If using Minikube or Kubernetes, set the Ingress class (i.e: nginx)                                                                              |
| global.openshiftRouteDomain                  | string | `""`                                                                                                                                                                                                                                                    | If using OpenShift Routes, set the Route domain                                                                                                  |
| fullnameOverride                             | string | `""`                                                                                                                                                                                                                                                    | Overrides charts full name                                                                                                                       |
| nameOverride                                 | string | `""`                                                                                                                                                                                                                                                    | Overrides charts name                                                                                                                            |
| management_console.appNameOverride           | string | `""`                                                                                                                                                                                                                                                    | Overrides the deployed application name                                                                                                          |
| management_console.applicationSubpath        | string | `""`                                                                                                                                                                                                                                                    | Overrides the subpath the Management Console will be served on                                                                                   |
| management_console.autoscaling               | object | `{"enabled":false,"maxReplicas":100,"minReplicas":1,"targetCPUUtilizationPercentage":80}`                                                                                                                                                               | Management Console HorizontalPodAutoscaler configuration (https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale/)            |
| management_console.chargedProductAnnotations | object | `{"productID":"{{ .Values.global.chargedProductValues.productID }}","productMetric":"{{ .Values.global.chargedProductValues.productMetric }}","productName":"{{ .Values.global.chargedProductValues.productName }}"}`                                   | Charged product annotations for ILMT tracking These values are populated from global.chargedProductValues                                        |
| management_console.enabled                   | bool   | `true`                                                                                                                                                                                                                                                  | Enable or disable Management Console installation                                                                                                |
| management_console.env                       | object | `{}`                                                                                                                                                                                                                                                    | Custom environment variables added to the Management Console Deployment                                                                          |
| management_console.fullnameOverride          | string | `""`                                                                                                                                                                                                                                                    | Overrides charts full name                                                                                                                       |
| management_console.image                     | object | `{"account":"bamoe","name":"management-console","pullPolicy":"IfNotPresent","registry":"quay.io","tag":"9.4.1-ibm-0002"}`                                                                                                                               | Image source configuration for the Management Console image                                                                                      |
| management_console.imagePullSecrets          | list   | `[]`                                                                                                                                                                                                                                                    | Pull secrets used when pulling Management Console image                                                                                          |
| management_console.ingress                   | object | `{"annotations":{},"className":"{{ .Values.global.kubernetesIngressClass }}","enabled":false,"hosts":[{"host":"management-console.{{ .Values.global.kubernetesClusterDomain }}","paths":[{"path":"/","pathType":"ImplementationSpecific"}]}],"tls":[]}` | Management Console Ingress configuration (https://kubernetes.io/docs/concepts/services-networking/ingress/)                                      |
| management_console.managedBusinessServices   | list   | `[]`                                                                                                                                                                                                                                                    | Overrides the List of Business Services that are automatically connected to the Management Console                                               |
| management_console.name                      | string | `"management-console"`                                                                                                                                                                                                                                  | Component name                                                                                                                                   |
| management_console.nameOverride              | string | `""`                                                                                                                                                                                                                                                    | Overrides charts name                                                                                                                            |
| management_console.nodeSelector              | object | `{}`                                                                                                                                                                                                                                                    |                                                                                                                                                  |
| management_console.oidcClientDefaultAudience | string | `""`                                                                                                                                                                                                                                                    | Overrides the OIDC Client Default audience when connecting to Identity Providers                                                                 |
| management_console.oidcClientDefaultScopes   | string | `""`                                                                                                                                                                                                                                                    | Overrides the OIDC Client Default Scopes when connecting to Identity Providers                                                                   |
| management_console.oidcClientIdOverride      | string | `""`                                                                                                                                                                                                                                                    | Overrides the OIDC Client ID used by the Management Console                                                                                      |
| management_console.openshiftRoute            | object | `{"annotations":{},"enabled":false,"host":"management-console.{{ .Values.global.openshiftRouteDomain }}","path":"","tls":{"insecureEdgeTerminationPolicy":"None","termination":"edge"}}`                                                                | Management Console OpenShift Route configuration (https://docs.openshift.com/container-platform/4.14/networking/routes/route-configuration.html) |
| management_console.pimMaxBulkIterationsCount | string | `""`                                                                                                                                                                                                                                                    | Overrides The maximum number of bulk requests in one migration operation                                                                         |
| management_console.pimMaxBulkSize            | string | `""`                                                                                                                                                                                                                                                    | Overrides the maximum number of process instance ids that can be sent in one request                                                             |
| management_console.resources                 | object | `{"limits":{"cpu":"2000m","memory":"4Gi"},"requests":{"cpu":"500m","memory":"1Gi"}}`                                                                                                                                                                    | Management Console resource requests and limits (https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/)                 |
| management_console.service                   | object | `{"nodePort":"","port":8081,"targetPort":8080,"type":"ClusterIP"}`                                                                                                                                                                                      | Management Console Service configuration (https://kubernetes.io/docs/concepts/services-networking/service/)                                      |
| management_console.serviceAccount            | object | `{"annotations":{},"create":true,"name":""}`                                                                                                                                                                                                            | Management Console ServiceAccount configuration (https://kubernetes.io/docs/concepts/security/service-accounts/)                                 |
| mcp_server.autoscaling                       | object | `{"enabled":false,"maxReplicas":100,"minReplicas":1,"targetCPUUtilizationPercentage":80}`                                                                                                                                                               | MCP Server HorizontalPodAutoscaler configuration (https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale/)                    |
| mcp_server.chargedProductAnnotations         | object | `{"productID":"{{ .Values.global.chargedProductValues.productID }}","productMetric":"{{ .Values.global.chargedProductValues.productMetric }}","productName":"{{ .Values.global.chargedProductValues.productName }}"}`                                   | Charged product annotations for ILMT tracking These values are populated from global.chargedProductValues                                        |
| mcp_server.env                               | object | `{}`                                                                                                                                                                                                                                                    | Env variables for BAMOE MCP Server deployment                                                                                                    |
| mcp_server.fullnameOverride                  | string | `""`                                                                                                                                                                                                                                                    | Overrides charts full name                                                                                                                       |
| mcp_server.image                             | object | `{"account":"bamoe","name":"mcp-server","pullPolicy":"IfNotPresent","registry":"quay.io","tag":"9.4.1-ibm-0002"}`                                                                                                                                       | Image source configuration for the MCP Server image                                                                                              |
| mcp_server.imagePullSecrets                  | list   | `[]`                                                                                                                                                                                                                                                    | Pull secrets used when pulling MCP Server image                                                                                                  |
| mcp_server.ingress                           | object | `{"annotations":{},"className":"{{ .Values.global.kubernetesIngressClass }}","enabled":false,"hosts":[{"host":"mcp-server.{{ .Values.global.kubernetesClusterDomain }}","paths":[{"path":"/","pathType":"ImplementationSpecific"}]}],"tls":[]}`         | MCP Server Ingress configuration (https://kubernetes.io/docs/concepts/services-networking/ingress/)                                              |
| mcp_server.name                              | string | `"mcp-server"`                                                                                                                                                                                                                                          | The MCP Server application name                                                                                                                  |
| mcp_server.nameOverride                      | string | `""`                                                                                                                                                                                                                                                    | Overrides charts name                                                                                                                            |
| mcp_server.nodeSelector                      | object | `{}`                                                                                                                                                                                                                                                    |                                                                                                                                                  |
| mcp_server.openshiftRoute                    | object | `{"annotations":{},"enabled":false,"host":"mcp-server.{{ .Values.global.openshiftRouteDomain }}","tls":{"insecureEdgeTerminationPolicy":"None","termination":"edge"}}`                                                                                  | MCP Server OpenShift Route configuration (https://docs.openshift.com/container-platform/4.14/networking/routes/route-configuration.html)         |
| mcp_server.resources                         | object | `{"limits":{"cpu":"1000m","memory":"2Gi"},"requests":{"cpu":"250m","memory":"512Mi"}}`                                                                                                                                                                  | MCP Server resource requests and limits (https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/)                         |
| mcp_server.service                           | object | `{"nodePort":"","port":8080,"type":"ClusterIP"}`                                                                                                                                                                                                        | MCP Server Service configuration (https://kubernetes.io/docs/concepts/services-networking/service/)                                              |
| mcp_server.serviceAccount                    | object | `{"annotations":{},"create":true,"name":""}`                                                                                                                                                                                                            | MCP Server ServiceAccount configuration (https://kubernetes.io/docs/concepts/security/service-accounts/)                                         |

---
