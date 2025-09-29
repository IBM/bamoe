# BAMOE Canvas Helm Chart

This chart can be used to deploy BAMOE Canvas image on a [Kubernetes](https://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

## Components

- BAMOE Canvas: main application
- Extended Services: powers the DMN Runner and validator
- CORS Proxy: intended to be used to solve CORS issues

## Installing the Chart

### Default install

To install the chart with the release name `bamoe-canvas`:

```console
helm install bamoe-canvas oci://quay.io/bamoe/canvas-helm-chart --version=9.3.0-ibm-0007
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
  export POD_NAME=$(kubectl get pods --namespace default -l "app.kubernetes.io/component=cors-proxy,app.kubernetes.io/instance=bamoe-canvas" -o jsonpath="{.items[0].metadata.name}")
  export CONTAINER_PORT=$(kubectl get pod --namespace default $POD_NAME -o jsonpath="{.spec.containers[0].ports[0].containerPort}")
  echo "CORS Proxy URL: http://127.0.0.1:8081"
  kubectl --namespace default port-forward $POD_NAME 8081:$CONTAINER_PORT

2. Run the following commands in a separate terminal to port-forward Extendend Services component:
  export POD_NAME=$(kubectl get pods --namespace default -l "app.kubernetes.io/component=extended-services,app.kubernetes.io/instance=bamoe-canvas" -o jsonpath="{.items[0].metadata.name}")
  export CONTAINER_PORT=$(kubectl get pod --namespace default $POD_NAME -o jsonpath="{.spec.containers[0].ports[0].containerPort}")
  echo "Extended Services URL: http://127.0.0.1:21345"
  kubectl --namespace default port-forward $POD_NAME 21345:$CONTAINER_PORT

3. Run the following commands in a separate terminal to port-forward BAMOE Canvas component and get the application URL:
  export POD_NAME=$(kubectl get pods --namespace default -l "app.kubernetes.io/component=canvas,app.kubernetes.io/instance=bamoe-canvas" -o jsonpath="{.items[0].metadata.name}")
  export CONTAINER_PORT=$(kubectl get pod --namespace default $POD_NAME -o jsonpath="{.spec.containers[0].ports[0].containerPort}")
  echo "BAMOE Canvas URL http://127.0.0.1:8080"
  kubectl --namespace default port-forward $POD_NAME 8080:$CONTAINER_PORT
```

Run above commands to forward container ports to your system ports. After this, BAMOE Canvas should be accessible via http://127.0.0.1:8080

### Minikube install

To install the chart with the release name `bamoe-canvas`:

```console
helm pull oci://quay.io/bamoe/canvas-helm-chart --version=9.3.0-ibm-0007 --untar
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
  echo "$MINIKUBE_IP canvas.local" | sudo tee -a /etc/hosts
```

### Kubernetes install

To install the chart with the release name `bamoe-canvas`:

```console
helm pull oci://quay.io/bamoe/canvas-helm-chart --version=9.3.0-ibm-0007 --untar
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
  http://canvas.<YOUR_KUBERNETES_CLUSTER_DOMAIN>
```

No need to run any commands. BAMOE Canvas should be accessible via https://canvas.<YOUR_KUBERNETES_CLUSTER_DOMAIN>

### OpenShift install

First, you may need to get the default OpenShift domain for your routes with this command:

```console
$ oc get ingresses.config cluster --output jsonpath={.spec.domain}
```

If you don't have access rigths to this config, try creating a dummy Route resource and checking its domain.

To install the chart with the release name `bamoe-canvas`:

```console
helm pull oci://quay.io/bamoe/canvas-helm-chart --version=9.3.0-ibm-0007 --untar
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
  https://canvas.<YOUR_OCP_ROUTE_DOMAIN>
```

No need to run any commands. BAMOE Canvas should be accessible via https://canvas.<YOUR_OCP_ROUTE_DOMAIN>

## Uninstalling the Chart

To uninstall the `bamoe-canvas` deployment:

```console
helm uninstall bamoe-canvas
```

## Passing Environmental variables

This chart uses default environmental variables from `values.yaml` file. We can override those by passing it from command line.

```console
helm install bamoe-canvas oci://quay.io/bamoe/canvas-helm-chart --set image.repository=quay.io
```

## Configuration

The following table lists the configurable parameters of the BAMOE Canvas chart and their default values.

<!-- CHART_VALUES_README -->

<table>
    <tr>
        <td>Key</td>
        <td>Type</td>
        <td>Default</td>
        <td>Description</td>
    </tr>
    <tr>
        <td>global.ingressSource</td>
        <td>string</td>
        <td>`&quot;&quot;`</td>
        <td>Which ingress source is being used (none/&quot;minikube&quot;/&quot;kubernetes&quot;/&quot;openshift&quot;) Obs.: For NOTES generation only</td>
    </tr>
    <tr>
        <td>global.kubernetesClusterDomain</td>
        <td>string</td>
        <td>`&quot;&quot;`</td>
        <td>If using Minikube or Kubernetes, set the cluster domain</td>
    </tr>
    <tr>
        <td>global.kubernetesIngressClass</td>
        <td>string</td>
        <td>`&quot;&quot;`</td>
        <td>If using Minikube or Kubernetes, set the Ingress class (i.e: nginx)</td>
    </tr>
    <tr>
        <td>global.openshiftRouteDomain</td>
        <td>string</td>
        <td>`&quot;&quot;`</td>
        <td>If using OpenShift Routes, set the Route domain</td>
    </tr>
    <tr>
        <td>fullnameOverride</td>
        <td>string</td>
        <td>`&quot;&quot;`</td>
        <td>Overrides charts full name</td>
    </tr>
    <tr>
        <td>nameOverride</td>
        <td>string</td>
        <td>`&quot;&quot;`</td>
        <td>Overrides charts name</td>
    </tr>
    <tr>
        <td>canvas.autoscaling</td>
        <td>object</td>
        <td>`{&quot;enabled&quot;:false,&quot;maxReplicas&quot;:100,&quot;minReplicas&quot;:1,&quot;targetCPUUtilizationPercentage&quot;:80}`</td>
        <td>BAMOE Canvas HorizontalPodAutoscaler configuration (https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale/)</td>
    </tr>
    <tr>
        <td>canvas.env</td>
        <td>list</td>
        <td>`[{&quot;name&quot;:&quot;KIE_SANDBOX_EXTENDED_SERVICES_URL&quot;,&quot;value&quot;:&quot;http://127.0.0.1:21345&quot;},{&quot;name&quot;:&quot;KIE_SANDBOX_CORS_PROXY_URL&quot;,&quot;value&quot;:&quot;http://127.0.0.1:8081&quot;}]`</td>
        <td>Env variables for BAMOE Canvas deployment</td>
    </tr>
    <tr>
        <td>canvas.fullnameOverride</td>
        <td>string</td>
        <td>`&quot;&quot;`</td>
        <td>Overrides charts full name</td>
    </tr>
    <tr>
        <td>canvas.image</td>
        <td>object</td>
        <td>`{&quot;account&quot;:&quot;bamoe&quot;,&quot;name&quot;:&quot;canvas&quot;,&quot;pullPolicy&quot;:&quot;IfNotPresent&quot;,&quot;registry&quot;:&quot;quay.io&quot;,&quot;tag&quot;:&quot;main&quot;}`</td>
        <td>Image source configuration for the BAMOE Canvas image</td>
    </tr>
    <tr>
        <td>canvas.imagePullSecrets</td>
        <td>list</td>
        <td>`[]`</td>
        <td>Pull secrets used when pulling BAMOE Canvas image</td>
    </tr>
    <tr>
        <td>canvas.ingress</td>
        <td>object</td>
        <td>`{&quot;annotations&quot;:{},&quot;className&quot;:&quot;{{ .Values.global.kubernetesIngressClass }}&quot;,&quot;enabled&quot;:false,&quot;hosts&quot;:[{&quot;host&quot;:&quot;bamoe-canvas.{{ .Values.global.kubernetesClusterDomain }}&quot;,&quot;paths&quot;:[{&quot;path&quot;:&quot;/&quot;,&quot;pathType&quot;:&quot;ImplementationSpecific&quot;}]}],&quot;tls&quot;:[]}`</td>
        <td>BAMOE Canvas Ingress configuration (https://kubernetes.io/docs/concepts/services-networking/ingress/)</td>
    </tr>
    <tr>
        <td>canvas.name</td>
        <td>string</td>
        <td>`&quot;canvas&quot;`</td>
        <td>The BAMOE Canvas application name</td>
    </tr>
    <tr>
        <td>canvas.nameOverride</td>
        <td>string</td>
        <td>`&quot;&quot;`</td>
        <td>Overrides charts name</td>
    </tr>
    <tr>
        <td>canvas.openshiftRoute</td>
        <td>object</td>
        <td>`{&quot;annotations&quot;:{},&quot;enabled&quot;:false,&quot;host&quot;:&quot;bamoe-canvas.{{ .Values.global.openshiftRouteDomain }}&quot;,&quot;tls&quot;:{&quot;insecureEdgeTerminationPolicy&quot;:&quot;None&quot;,&quot;termination&quot;:&quot;edge&quot;}}`</td>
        <td>BAMOE Canvas OpenShift Route configuration (https://docs.openshift.com/container-platform/4.14/networking/routes/route-configuration.html)</td>
    </tr>
    <tr>
        <td>canvas.service</td>
        <td>object</td>
        <td>`{&quot;nodePort&quot;:&quot;&quot;,&quot;port&quot;:8080,&quot;type&quot;:&quot;ClusterIP&quot;}`</td>
        <td>BAMOE Canvas Service configuration (https://kubernetes.io/docs/concepts/services-networking/service/)</td>
    </tr>
    <tr>
        <td>canvas.serviceAccount</td>
        <td>object</td>
        <td>`{&quot;annotations&quot;:{},&quot;create&quot;:true,&quot;name&quot;:&quot;&quot;}`</td>
        <td>BAMOE Canvas ServiceAccount configuration (https://kubernetes.io/docs/concepts/security/service-accounts/)</td>
    </tr>
    <tr>
        <td>cors_proxy.autoscaling</td>
        <td>object</td>
        <td>`{&quot;enabled&quot;:false,&quot;maxReplicas&quot;:100,&quot;minReplicas&quot;:1,&quot;targetCPUUtilizationPercentage&quot;:80}`</td>
        <td>CORS Proxy HorizontalPodAutoscaler configuration (https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale/)</td>
    </tr>
    <tr>
        <td>cors_proxy.fullnameOverride</td>
        <td>string</td>
        <td>`&quot;&quot;`</td>
        <td>Overrides charts full name</td>
    </tr>
    <tr>
        <td>cors_proxy.image</td>
        <td>object</td>
        <td>`{&quot;account&quot;:&quot;bamoe&quot;,&quot;name&quot;:&quot;cors-proxy&quot;,&quot;pullPolicy&quot;:&quot;IfNotPresent&quot;,&quot;registry&quot;:&quot;quay.io&quot;,&quot;tag&quot;:&quot;main&quot;}`</td>
        <td>Image source configuration for the CORS Proxy image</td>
    </tr>
    <tr>
        <td>cors_proxy.imagePullSecrets</td>
        <td>list</td>
        <td>`[]`</td>
        <td>Pull secrets used when pulling CORS Proxy image</td>
    </tr>
    <tr>
        <td>cors_proxy.ingress</td>
        <td>object</td>
        <td>`{&quot;annotations&quot;:{},&quot;className&quot;:&quot;{{ .Values.global.kubernetesIngressClass }}&quot;,&quot;enabled&quot;:false,&quot;hosts&quot;:[{&quot;host&quot;:&quot;cors-proxy.{{ .Values.global.kubernetesClusterDomain }}&quot;,&quot;paths&quot;:[{&quot;path&quot;:&quot;/&quot;,&quot;pathType&quot;:&quot;ImplementationSpecific&quot;}]}],&quot;tls&quot;:[]}`</td>
        <td>CORS Proxy Ingress configuration (https://kubernetes.io/docs/concepts/services-networking/ingress/)</td>
    </tr>
    <tr>
        <td>cors_proxy.name</td>
        <td>string</td>
        <td>`&quot;cors-proxy&quot;`</td>
        <td>The CORS Proxy application name</td>
    </tr>
    <tr>
        <td>cors_proxy.nameOverride</td>
        <td>string</td>
        <td>`&quot;&quot;`</td>
        <td>Overrides charts name</td>
    </tr>
    <tr>
        <td>cors_proxy.nodeSelector</td>
        <td>object</td>
        <td>`{}`</td>
        <td></td>
    </tr>
    <tr>
        <td>cors_proxy.openshiftRoute</td>
        <td>object</td>
        <td>`{&quot;annotations&quot;:{},&quot;enabled&quot;:false,&quot;host&quot;:&quot;cors-proxy.{{ .Values.global.openshiftRouteDomain }}&quot;,&quot;tls&quot;:{&quot;insecureEdgeTerminationPolicy&quot;:&quot;None&quot;,&quot;termination&quot;:&quot;edge&quot;}}`</td>
        <td>CORS Proxy OpenShift Route configuration (https://docs.openshift.com/container-platform/4.14/networking/routes/route-configuration.html)</td>
    </tr>
    <tr>
        <td>cors_proxy.service</td>
        <td>object</td>
        <td>`{&quot;nodePort&quot;:&quot;&quot;,&quot;port&quot;:8080,&quot;type&quot;:&quot;ClusterIP&quot;}`</td>
        <td>CORS Proxy Service configuration (https://kubernetes.io/docs/concepts/services-networking/service/)</td>
    </tr>
    <tr>
        <td>cors_proxy.serviceAccount</td>
        <td>object</td>
        <td>`{&quot;annotations&quot;:{},&quot;create&quot;:true,&quot;name&quot;:&quot;&quot;}`</td>
        <td>CORS Proxy ServiceAccount configuration (https://kubernetes.io/docs/concepts/security/service-accounts/)</td>
    </tr>
    <tr>
        <td>extended_services.autoscaling</td>
        <td>object</td>
        <td>`{&quot;enabled&quot;:false,&quot;maxReplicas&quot;:100,&quot;minReplicas&quot;:1,&quot;targetCPUUtilizationPercentage&quot;:80}`</td>
        <td>Extended Services HorizontalPodAutoscaler configuration (https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale/)</td>
    </tr>
    <tr>
        <td>extended_services.fullnameOverride</td>
        <td>string</td>
        <td>`&quot;&quot;`</td>
        <td>Overrides charts full name</td>
    </tr>
    <tr>
        <td>extended_services.image</td>
        <td>object</td>
        <td>`{&quot;account&quot;:&quot;bamoe&quot;,&quot;name&quot;:&quot;extended-services&quot;,&quot;pullPolicy&quot;:&quot;IfNotPresent&quot;,&quot;registry&quot;:&quot;quay.io&quot;,&quot;tag&quot;:&quot;main&quot;}`</td>
        <td>Image source configuration for the Extended Services image</td>
    </tr>
    <tr>
        <td>extended_services.imagePullSecrets</td>
        <td>list</td>
        <td>`[]`</td>
        <td>Pull secrets used when pulling Extended Services image</td>
    </tr>
    <tr>
        <td>extended_services.ingress</td>
        <td>object</td>
        <td>`{&quot;annotations&quot;:{},&quot;className&quot;:&quot;{{ .Values.global.kubernetesIngressClass }}&quot;,&quot;enabled&quot;:false,&quot;hosts&quot;:[{&quot;host&quot;:&quot;extended-services.{{ .Values.global.kubernetesClusterDomain }}&quot;,&quot;paths&quot;:[{&quot;path&quot;:&quot;/&quot;,&quot;pathType&quot;:&quot;ImplementationSpecific&quot;}]}],&quot;tls&quot;:[]}`</td>
        <td>Extended Services Ingress configuration (https://kubernetes.io/docs/concepts/services-networking/ingress/)</td>
    </tr>
    <tr>
        <td>extended_services.name</td>
        <td>string</td>
        <td>`&quot;extended-services&quot;`</td>
        <td>The Extended Services application name</td>
    </tr>
    <tr>
        <td>extended_services.nameOverride</td>
        <td>string</td>
        <td>`&quot;&quot;`</td>
        <td>Overrides charts name</td>
    </tr>
    <tr>
        <td>extended_services.nodeSelector</td>
        <td>object</td>
        <td>`{}`</td>
        <td></td>
    </tr>
    <tr>
        <td>extended_services.openshiftRoute</td>
        <td>object</td>
        <td>`{&quot;annotations&quot;:{},&quot;enabled&quot;:false,&quot;host&quot;:&quot;extended-services.{{ .Values.global.openshiftRouteDomain }}&quot;,&quot;tls&quot;:{&quot;insecureEdgeTerminationPolicy&quot;:&quot;None&quot;,&quot;termination&quot;:&quot;edge&quot;}}`</td>
        <td>Extended Services OpenShift Route configuration (https://docs.openshift.com/container-platform/4.14/networking/routes/route-configuration.html)</td>
    </tr>
    <tr>
        <td>extended_services.service</td>
        <td>object</td>
        <td>`{&quot;nodePort&quot;:&quot;&quot;,&quot;port&quot;:21345,&quot;type&quot;:&quot;ClusterIP&quot;}`</td>
        <td>Extended Services Service configuration (https://kubernetes.io/docs/concepts/services-networking/service/)</td>
    </tr>
    <tr>
        <td>extended_services.serviceAccount</td>
        <td>object</td>
        <td>`{&quot;annotations&quot;:{},&quot;create&quot;:true,&quot;name&quot;:&quot;&quot;}`</td>
        <td>Extended Services ServiceAccount configuration (https://kubernetes.io/docs/concepts/security/service-accounts/)</td>
    </tr>
</table>