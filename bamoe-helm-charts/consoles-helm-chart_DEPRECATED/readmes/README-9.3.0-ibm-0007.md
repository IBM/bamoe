# BAMOE Consoles Helm Chart

This chart can be used to deploy the Management Console image on a [Kubernetes](https://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

## Components

- Management Console

## Installing the Chart

### Minikube install

To install the chart with the release name `bamoe-consoles`:

```console
helm pull oci://quay.io/bamoe/consoles-helm-chart --version=9.3.0-ibm-0007 --untar
helm install bamoe-consoles ./consoles-helm-chart --values ./consoles-helm-chart/values-minikube-nginx.yaml
```

Following message should be displayed on your console.

```console
NAME: bamoe-consoles
LAST DEPLOYED: Wed Aug 7 17:09:04 2024
NAMESPACE: default
STATUS: deployed
REVISION: 1
NOTES:
You may need to add the above hostnames to your /etc/hosts file, mapping them to your minikube ip.

Run the following commands:
  export MINIKUBE_IP=$(minikube ip)
  echo "\n# Minikube BAMOE Consoles Helm Chart hostnames" | sudo tee -a /etc/hosts
  echo "$MINIKUBE_IP management-console.local" | sudo tee -a /etc/hosts
```

### Kubernetes install

To install the chart with the release name `bamoe-consoles`:

```console
helm pull oci://quay.io/bamoe/consoles-helm-chart --version=9.3.0-ibm-0007 --untar
helm install bamoe-consoles ./consoles-helm-chart --values ./consoles-helm-chart/values-kubernetes.yaml --set global.kubernetesClusterDomain="<YOUR_KUBERNETES_CLUSTER_DOMAIN>" --set global.kubernetesIngressClass="<YOUR_KUBERNETES_INGRESS_CLASS>"
```

Following message should be displayed on your console.

```console
NAME: bamoe-consoles
LAST DEPLOYED: Wed Aug 7 17:09:04 2024
NAMESPACE: default
STATUS: deployed
REVISION: 1
NOTES:
1. Management Console available at:
  http://management-console.<YOUR_KUBERNETES_CLUSTER_DOMAIN>
```

### OpenShift install

First, you may need to get the default OpenShift domain for your routes with this command:

```console
oc get ingresses.config cluster --output jsonpath={.spec.domain}
```

If you don't have access rigths to this config, try creating a dummy Route resource and checking its domain.

To install the chart with the release name `bamoe-consoles`:

```console
helm pull oci://quay.io/bamoe/consoles-helm-chart --version=9.3.0-ibm-0007 --untar
helm install bamoe-consoles ./consoles-helm-chart --values ./consoles-helm-chart/values-openshift.yaml --set global.openshiftRouteDomain="<YOUR_OCP_ROUTE_DOMAIN>"
```

Following message should be displayed on your console.

```console
NAME: bamoe-consoles
LAST DEPLOYED: Wed Aug 7 17:09:04 2024
NAMESPACE: default
STATUS: deployed
REVISION: 1
NOTES:
1. Management Console available at:
  https://management-console.<YOUR_OCP_ROUTE_DOMAIN>
```

## Uninstalling the Chart

To uninstall the `bamoe-consoles` deployment:

```console
helm uninstall bamoe-consoles
```

## Configuration

The following table lists the configurable parameters of the BAMOE Consoles helm chart and their default values.

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
        <td>Which ingress source is being used (none/&quot;minikube&quot;/&quot;kubernetes&quot;/&quot;openshift&quot;). Obs.: For NOTES generation only</td>
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
        <td>If using Minikube or Kubernetes, set the Ingress class (i.e, nginx)</td>
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
        <td>management-console.appNameOverride</td>
        <td>string</td>
        <td>`&quot;&quot;`</td>
        <td>Overrides the deployed application name</td>
    </tr>
    <tr>
        <td>management-console.applicationSubpath</td>
        <td>string</td>
        <td>`&quot;&quot;`</td>
        <td>Overrides the subpath the Management Console will be served on</td>
    </tr>
    <tr>
        <td>management-console.autoscaling</td>
        <td>object</td>
        <td>`{&quot;enabled&quot;:false,&quot;maxReplicas&quot;:100,&quot;minReplicas&quot;:1,&quot;targetCPUUtilizationPercentage&quot;:80}`</td>
        <td>Management Console HorizontalPodAutoscaler configuration (https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale/)</td>
    </tr>
    <tr>
        <td>management-console.enabled</td>
        <td>bool</td>
        <td>`true`</td>
        <td>Enable or disable Management Console installation</td>
    </tr>
    <tr>
        <td>management-console.env</td>
        <td>object</td>
        <td>`{}`</td>
        <td>Custom environment variables added to the Management Console Deployment</td>
    </tr>
    <tr>
        <td>management-console.fullnameOverride</td>
        <td>string</td>
        <td>`&quot;&quot;`</td>
        <td>Overrides charts full name</td>
    </tr>
    <tr>
        <td>management-console.image</td>
        <td>object</td>
        <td>`{&quot;account&quot;:&quot;bamoe&quot;,&quot;name&quot;:&quot;management-console&quot;,&quot;pullPolicy&quot;:&quot;IfNotPresent&quot;,&quot;registry&quot;:&quot;quay.io&quot;,&quot;tag&quot;:&quot;9.3.0&quot;}`</td>
        <td>Image source configuration for the Management Console image</td>
    </tr>
    <tr>
        <td>management-console.imagePullSecrets</td>
        <td>list</td>
        <td>`[]`</td>
        <td>Pull secrets used when pulling Management Console image</td>
    </tr>
    <tr>
        <td>management-console.ingress</td>
        <td>object</td>
        <td>`{&quot;annotations&quot;:{},&quot;className&quot;:&quot;{{ .Values.global.kubernetesIngressClass }}&quot;,&quot;enabled&quot;:false,&quot;hosts&quot;:[{&quot;host&quot;:&quot;management-console.{{ .Values.global.kubernetesClusterDomain }}&quot;,&quot;paths&quot;:[{&quot;path&quot;:&quot;/&quot;,&quot;pathType&quot;:&quot;ImplementationSpecific&quot;}]}],&quot;tls&quot;:[]}`</td>
        <td>Management Console Ingress configuration (https://kubernetes.io/docs/concepts/services-networking/ingress/)</td>
    </tr>
    <tr>
        <td>management-console.managedBusinessServices</td>
        <td>list</td>
        <td>`[]`</td>
        <td>Overrides the List of Business Services that are automatically connected to the Management Console</td>
    </tr>
    <tr>
        <td>management-console.name</td>
        <td>string</td>
        <td>`&quot;management-console&quot;`</td>
        <td>Component name</td>
    </tr>
    <tr>
        <td>management-console.nameOverride</td>
        <td>string</td>
        <td>`&quot;&quot;`</td>
        <td>Overrides charts name</td>
    </tr>
    <tr>
        <td>management-console.nodeSelector</td>
        <td>object</td>
        <td>`{}`</td>
        <td></td>
    </tr>
    <tr>
        <td>management-console.oidcClientDefaultAudience</td>
        <td>string</td>
        <td>`&quot;&quot;`</td>
        <td>Overrides the OIDC Client Default audience when connecting to Identity Providers</td>
    </tr>
    <tr>
        <td>management-console.oidcClientDefaultScopes</td>
        <td>string</td>
        <td>`&quot;&quot;`</td>
        <td>Overrides the OIDC Client Default Scopes when connecting to Identity Providers</td>
    </tr>
    <tr>
        <td>management-console.oidcClientIdOverride</td>
        <td>string</td>
        <td>`&quot;&quot;`</td>
        <td>Overrides the OIDC Client ID used by the Management Console</td>
    </tr>
    <tr>
        <td>management-console.openshiftRoute</td>
        <td>object</td>
        <td>`{&quot;annotations&quot;:{},&quot;enabled&quot;:false,&quot;host&quot;:&quot;management-console.{{ .Values.global.openshiftRouteDomain }}&quot;,&quot;path&quot;:&quot;&quot;,&quot;tls&quot;:{&quot;insecureEdgeTerminationPolicy&quot;:&quot;None&quot;,&quot;termination&quot;:&quot;edge&quot;}}`</td>
        <td>Management Console OpenShift Route configuration (https://docs.openshift.com/container-platform/4.14/networking/routes/route-configuration.html)</td>
    </tr>
    <tr>
        <td>management-console.service</td>
        <td>object</td>
        <td>`{&quot;nodePort&quot;:&quot;&quot;,&quot;port&quot;:8081,&quot;targetPort&quot;:8080,&quot;type&quot;:&quot;ClusterIP&quot;}`</td>
        <td>Management Console Service configuration (https://kubernetes.io/docs/concepts/services-networking/service/)</td>
    </tr>
    <tr>
        <td>management-console.serviceAccount</td>
        <td>object</td>
        <td>`{&quot;annotations&quot;:{},&quot;create&quot;:true,&quot;name&quot;:&quot;&quot;}`</td>
        <td>Management Console ServiceAccount configuration (https://kubernetes.io/docs/concepts/security/service-accounts/)</td>
    </tr>
</table>