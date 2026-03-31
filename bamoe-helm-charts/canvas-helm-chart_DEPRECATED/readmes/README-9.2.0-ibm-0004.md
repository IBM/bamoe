# BAMOE Canvas Helm Chart

BAMOE Canvas helm chart is a Helm chart based on the opensource KIE Sandbox helm chart that can be used to deploy BAMOE Canvas image on a [Kubernetes](https://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

## Components

- BAMOE Canvas webapp: main application
- BAMOE Extended Services: powers the DMN Runner and static validation for DMN and BPMN files.
- BAMOE CORS Proxy: solves CORS issues when communicating with Git and cloud providers.

## Installing the Chart

### Default install

To install the chart with the release name `bamoe-canvas`:

```console
helm install bamoe-canvas oci://quay.io/bamoe/canvas-helm-chart --version=9.2.0-ibm-0004
```

Following message should be displayed on your console.

```console
NAME: bamoe-canvas
LAST DEPLOYED: Wed Nov 29 17:09:04 2023
NAMESPACE: default
STATUS: deployed
REVISION: 1
NOTES:
In order to get BAMOE Canvas running you need to run these commands:

1. Run the following commands in a separate terminal to port-forward CORS Proxy component:
  export POD_NAME=$(kubectl get pods --namespace default -l "app.kubernetes.io/name=kie_sandbox,app.kubernetes.io/component=cors-proxy,app.kubernetes.io/instance=bamoe-canvas" -o jsonpath="{.items[0].metadata.name}")
  export CONTAINER_PORT=$(kubectl get pod --namespace default $POD_NAME -o jsonpath="{.spec.containers[0].ports[0].containerPort}")
  echo "CORS Proxy URL: http://127.0.0.1:8081"
  kubectl --namespace default port-forward $POD_NAME 8081:$CONTAINER_PORT

2. Run the following commands in a separate terminal to port-forward Extendend Services component:
  export POD_NAME=$(kubectl get pods --namespace default -l "app.kubernetes.io/name=kie_sandbox,app.kubernetes.io/component=extended-services,app.kubernetes.io/instance=bamoe-canvas" -o jsonpath="{.items[0].metadata.name}")
  export CONTAINER_PORT=$(kubectl get pod --namespace default $POD_NAME -o jsonpath="{.spec.containers[0].ports[0].containerPort}")
  echo "Extended Services URL: http://127.0.0.1:21345"
  kubectl --namespace default port-forward $POD_NAME 21345:$CONTAINER_PORT

3. Run the following commands in a separate terminal to port-forward Sanxbox component and get the application URL:
  export POD_NAME=$(kubectl get pods --namespace default -l "app.kubernetes.io/name=kie_sandbox,app.kubernetes.io/component=kie-sandbox,app.kubernetes.io/instance=bamoe-canvas" -o jsonpath="{.items[0].metadata.name}")
  export CONTAINER_PORT=$(kubectl get pod --namespace default $POD_NAME -o jsonpath="{.spec.containers[0].ports[0].containerPort}")
  echo "BAMOE Canvas URL http://127.0.0.1:8080"
  kubectl --namespace default port-forward $POD_NAME 8080:$CONTAINER_PORT
```

Run above commands to forward container ports to your system ports. After this, BAMOE Canvas should be accessible via http://127.0.0.1:8080

### Minikube install

To install the chart with the release name `bamoe-canvas`:

```console
helm pull oci://quay.io/bamoe/canvas-helm-chart --version=9.2.0-ibm-0004 --untar
helm install bamoe-canvas ./canvas-helm-chart --values ./canvas-helm-chart/values-minikube-nginx.yaml
```

Following message should be displayed on your console.

```console
NAME: bamoe-canvas
LAST DEPLOYED: Wed Nov 29 17:09:04 2023
NAMESPACE: default
STATUS: deployed
REVISION: 1
NOTES:
You may need to add the above hostnames to your /etc/hosts file, mapping them to your minikube ip.

Run the following commands:
  export MINIKUBE_IP=$(minikube ip)
  echo "\n# Minikube BAMOE Canvas Helm Chart hostnames" | sudo tee -a /etc/hosts
  echo "$MINIKUBE_IP cors-proxy.local" | sudo tee -a /etc/hosts
  echo "$MINIKUBE_IP extended-services.local" | sudo tee -a /etc/hosts
  echo "$MINIKUBE_IP bamoe-canvas.local" | sudo tee -a /etc/hosts
```

### Kubernetes install

To install the chart with the release name `bamoe-canvas`:

```console
helm pull oci://quay.io/bamoe/canvas-helm-chart --version=9.2.0-ibm-0004 --untar
helm install bamoe-canvas ./canvas-helm-chart --values ./canvas-helm-chart/values-kubernetes.yaml --set global.kubernetesClusterDomain="<YOUR_KUBERNETES_CLUSTER_DOMAIN>" --set global.kubernetesIngressClass="<YOUR_KUBERNETES_INGRESS_CLASS>"
```

Following message should be displayed on your console.

```console
NAME: bamoe-canvas
LAST DEPLOYED: Wed Nov 29 17:09:04 2023
NAMESPACE: default
STATUS: deployed
REVISION: 1
NOTES:
1. CORS Proxy available at:
  http://cors-proxy.<YOUR_KUBERNETES_CLUSTER_DOMAIN>
2. Extended Services available at:
  http://extended-services.<YOUR_KUBERNETES_CLUSTER_DOMAIN>
3. BAMOE Canvas available at:
  http://bamoe-canvas.<YOUR_KUBERNETES_CLUSTER_DOMAIN>
```

No need to run any extra commands. BAMOE Canvas should be accessible via https://bamoe-canvas.<YOUR_KUBERNETES_CLUSTER_DOMAIN>

### OpenShift install

First, you may need to get the default OpenShift domain for your routes with this command:

```console
oc get ingresses.config cluster --output jsonpath={.spec.domain}
```

If you don't have access rigths to this config, try creating a dummy Route resource and checking its domain.

To install the chart with the release name `bamoe-canvas`:

```console
helm pull oci://quay.io/bamoe/canvas-helm-chart --version=9.2.0-ibm-0004 --untar
helm install bamoe-canvas ./canvas-helm-chart --values ./canvas-helm-chart/values-openshift.yaml --set global.openshiftRouteDomain="<YOUR_OCP_ROUTE_DOMAIN>"
```

Following message should be displayed on your console.

```console
NAME: bamoe-canvas
LAST DEPLOYED: Wed Nov 29 17:09:04 2023
NAMESPACE: default
STATUS: deployed
REVISION: 1
NOTES:
1. CORS Proxy available at:
  https://cors-proxy.<YOUR_OCP_ROUTE_DOMAIN>
2. Extended Services available at:
  https://extended-services.<YOUR_OCP_ROUTE_DOMAIN>
3. BAMOE Canvas available at:
  https://bamoe-canvas.<YOUR_OCP_ROUTE_DOMAIN>
```

No need to run any commands. BAMOE Canvas should be accessible via https://bamoe-canvas.<YOUR_OCP_ROUTE_DOMAIN>

## Uninstalling the Chart

To uninstall the `bamoe-canvas` deployment:

```console
helm uninstall bamoe-canvas
```

## Passing Environmental variables

This chart uses default environmental variables from `values.yaml` file. It can overriden those by passing them from command line:

```console
helm install bamoe-canvas ./src --set image.repository=quay.io
```

Or passing a new `values.yaml` file with the new values:

```console
helm install bamoe-canvas ./src --values new-values-file.yaml
```

## Configuration

The following list displays all the configurable parameters of the BAMOE Canvas chart and their default values.

  - **global.ingressSource**
    - type: `string`
    - default: `""`
    - description: Which ingress source is being used (none/"minikube"/"kubernetes"/"openshift") Obs.: For NOTES generation only
  - **global.kubernetesClusterDomain**
    - type: `string`
    - default: `""`
    - description: If using Minikube or Kubernetes, set the cluster domain
  - **global.kubernetesIngressClass**
    - type: `string`
    - default: `""`
    - description: If using Minikube or Kubernetes, set the Ingress class (i.e: nginx)
  - **global.openshiftRouteDomain**
    - type: `string`
    - default: `""`
    - description: If using OpenShift Routes, set the Route domain
  - **fullnameOverride**
    - type: `string`
    - default: `""`
    - description: Overrides charts full name
  - **nameOverride**
    - type: `string`
    - default: `""`
    - description: Overrides charts name
  - **cors_proxy.autoscaling**
    - type: `object`
    - default: `{"enabled":false,"maxReplicas":100,"minReplicas":1,"targetCPUUtilizationPercentage":80}`
    - description: CORS Proxy HorizontalPodAutoscaler configuration (https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale/)
  - **cors_proxy.fullnameOverride**
    - type: `string`
    - default: `""`
    - description: Overrides charts full name
  - **cors_proxy.image**
    - type: `object`
    - default: `{"account":"bamoe","name":"cors-proxy","pullPolicy":"IfNotPresent","registry":"quay.io","tag":"9.2.0-ibm-0004"}`
    - description: Image source configuration for the CORS Proxy image
  - **cors_proxy.imagePullSecrets**
    - type: `list`
    - default: `[]`
    - description: Pull secrets used when pulling CORS Proxy image
  - **cors_proxy.ingress**
    - type: `object`
    - default: `{"annotations":{},"className":"{{ .Values.global.kubernetesIngressClass }}","enabled":false,"hosts":[{"host":"cors-proxy.{{ .Values.global.kubernetesClusterDomain }}","paths":[{"path":"/","pathType":"ImplementationSpecific"}]}],"tls":[]}`
    - description: CORS Proxy Ingress configuration (https://kubernetes.io/docs/concepts/services-networking/ingress/)
  - **cors_proxy.name**
    - type: `string`
    - default: `"cors-proxy"`
    - description: The CORS Proxy application name
  - **cors_proxy.nameOverride**
    - type: `string`
    - default: `""`
    - description: Overrides charts name
  - **cors_proxy.nodeSelector**
    - type: `object`
    - default: `{}	`
  - **cors_proxy.openshiftRoute**
    - type: `object`
    - default: `{"annotations":{},"enabled":false,"host":"cors-proxy.{{ .Values.global.openshiftRouteDomain }}","tls":{"insecureEdgeTerminationPolicy":"None","termination":"edge"}}`
    - description: CORS Proxy OpenShift Route configuration (https://docs.openshift.com/container-platform/4.14/networking/routes/route-configuration.html)
  - **cors_proxy.service**
    - type: `object`
    - default: `{"nodePort":"","port":8080,"type":"ClusterIP"}`
    - description: CORS Proxy Service configuration (https://kubernetes.io/docs/concepts/services-networking/service/)
  - **cors_proxy.serviceAccount**
    - type: `object`
    - default: `{"annotations":{},"create":true,"name":""}`
    - description: CORS Proxy ServiceAccount configuration (https://kubernetes.io/docs/concepts/security/service-accounts/)
  - **extended_services.autoscaling**
    - type: `object`
    - default: `{"enabled":false,"maxReplicas":100,"minReplicas":1,"targetCPUUtilizationPercentage":80}`
    - description: Extended Services HorizontalPodAutoscaler configuration (https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale/)
  - **extended_services.fullnameOverride**
    - type: `string`
    - default: `""`
    - description: Overrides charts full name
  - **extended_services.image**
    - type: `object`
    - default: `{"account":"bamoe","name":"extended-services","pullPolicy":"IfNotPresent","registry":"quay.io","tag":"9.2.0-ibm-0004"}`
    - description: Image source configuration for the Extended Services image
  - **extended_services.imagePullSecrets**
    - type: `list`
    - default: `[]`
    - description: Pull secrets used when pulling Extended Services image
  - **extended_services.ingress**
    - type: `object`
    - default: `{"annotations":{},"className":"{{ .Values.global.kubernetesIngressClass }}","enabled":false,"hosts":[{"host":"extended-services.{{ .Values.global.kubernetesClusterDomain }}","paths":[{"path":"/","pathType":"ImplementationSpecific"}]}],"tls":[]}`
    - description: Extended Services Ingress configuration (https://kubernetes.io/docs/concepts/services-networking/ingress/)
  - **extended_services.name**
    - type: `string`
    - default: `"extended-services"`
    - description: The Extended Services application name
  - **extended_services.nameOverride**
    - type: `string`
    - default: `""`
    - description: Overrides charts name
  - **extended_services.nodeSelector**
    - type: `object`
    - default: `{}`
  - **extended_services.openshiftRoute**
    - type: `object`
    - default: `{"annotations":{},"enabled":false,"host":"extended-services.{{ .Values.global.openshiftRouteDomain }}","tls":{"insecureEdgeTerminationPolicy":"None","termination":"edge"}}`
    - description: Extended Services OpenShift Route configuration (https://docs.openshift.com/container-platform/4.14/networking/routes/route-configuration.html)
  - **extended_services.service**
    - type: `object`
    - default: `{"nodePort":"","port":21345,"type":"ClusterIP"}`
    - description: Extended Services Service configuration (https://kubernetes.io/docs/concepts/services-networking/service/)
  - **extended_services.serviceAccount**
    - type: `object`
    - default: `{"annotations":{},"create":true,"name":""}`
    - description: Extended Services ServiceAccount configuration (https://kubernetes.io/docs/concepts/security/service-accounts/)
  - **kie_sandbox.autoscaling**
    - type: `object`
    - default: `{"enabled":false,"maxReplicas":100,"minReplicas":1,"targetCPUUtilizationPercentage":80}`
    - description: KIE Sandbox HorizontalPodAutoscaler configuration (https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale/)
  - **kie_sandbox.env**
    - type: `list`
    - default: `[{"name":"KIE_SANDBOX_EXTENDED_SERVICES_URL","value":"http://127.0.0.1:21345"},{"name":"KIE_SANDBOX_CORS_PROXY_URL","value":"http://127.0.0.1:8081"}]`
    - description: Env variables for KIE Sandbox deployment
  - **kie_sandbox.fullnameOverride**
    - type: `string`
    - default: `""`
    - description: Overrides charts full name
  - **kie_sandbox.image**
    - type: `object`
    - default: `{"account":"bamoe","name":"canvas","pullPolicy":"IfNotPresent","registry":"quay.io","tag":"9.2.0-ibm-0004"}`
    - description: Image source configuration for the KIE Sandbox image
  - **kie_sandbox.imagePullSecrets**
    - type: `list`
    - default: `[]`
    - description: Pull secrets used when pulling KIE Sandbox image
  - **kie_sandbox.ingress**
    - type: `object`
    - default: `{"annotations":{},"className":"{{ .Values.global.kubernetesIngressClass }}","enabled":false,"hosts":[{"host":"kie-sandbox.{{ .Values.global.kubernetesClusterDomain }}","paths":[{"path":"/","pathType":"ImplementationSpecific"}]}],"tls":[]}`
    - description: KIE Sandbox Ingress configuration (https://kubernetes.io/docs/concepts/services-networking/ingress/)
  - **kie_sandbox.name**
    - type: `string`
    - default: `"kie-sandbox"`
    - description: The KIE Sandbox application name
  - **kie_sandbox.nameOverride**
    - type: `string`
    - default: `""`
    - description: Overrides charts name
  - **kie_sandbox.openshiftRoute**
    - type: `object`
    - default: `{"annotations":{},"enabled":false,"host":"kie-sandbox.{{ .Values.global.openshiftRouteDomain }}","tls":{"insecureEdgeTerminationPolicy":"None","termination":"edge"}}`
    - description: KIE Sandbox OpenShift Route configuration (https://docs.openshift.com/container-platform/4.14/networking/routes/route-configuration.html)
  - **kie_sandbox.service**
    - type: `object`
    - default: `{"nodePort":"","port":8080,"type":"ClusterIP"}`
    - description: KIE Sandbox Service configuration (https://kubernetes.io/docs/concepts/services-networking/service/)
  - **kie_sandbox.serviceAccount**
    - type: `object`
    - default: `{"annotations":{},"create":true,"name":""}`
    - description: KIE Sandbox ServiceAccount configuration (https://kubernetes.io/docs/concepts/security/service-accounts/)