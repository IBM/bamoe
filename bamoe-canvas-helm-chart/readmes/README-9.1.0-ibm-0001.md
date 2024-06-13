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
helm install bamoe-canvas oci://quay.io/bamoe/canvas-helm-chart --version=9.1.0-ibm-0001
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
$ helm pull oci://quay.io/bamoe/canvas-helm-chart --version=9.1.0-ibm-0001 --untar
$ helm install bamoe-canvas ./canvas-helm-chart --values ./canvas-helm-chart/values-minikube-nginx.yaml
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
$ helm pull oci://quay.io/bamoe/canvas-helm-chart --version=9.1.0-ibm-0001 --untar
$ helm install bamoe-canvas ./canvas-helm-chart --values ./canvas-helm-chart/values-kubernetes.yaml --set global.kubernetesClusterDomain="<YOUR_KUBERNETES_CLUSTER_DOMAIN>" --set global.kubernetesIngressClass="<YOUR_KUBERNETES_INGRESS_CLASS>"
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
$ oc get ingresses.config cluster --output jsonpath={.spec.domain}
```

If you don't have access rigths to this config, try creating a dummy Route resource and checking its domain.

To install the chart with the release name `bamoe-canvas`:

```console
$ helm pull oci://quay.io/bamoe/canvas-helm-chart --version=9.1.0-ibm-0001 --untar
$ helm install bamoe-canvas ./canvas-helm-chart --values ./canvas-helm-chart/values-openshift.yaml --set global.openshiftRouteDomain="<YOUR_OCP_ROUTE_DOMAIN>"
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
1. Extended Services available at:
  https://extended-services.<YOUR_OCP_ROUTE_DOMAIN>
1. BAMOE Canvas available at:
  https://bamoe-canvas.<YOUR_OCP_ROUTE_DOMAIN>
```

No need to run any commands. BAMOE Canvas should be accessible via https://bamoe-canvas.<YOUR_OCP_ROUTE_DOMAIN>

## Uninstalling the Chart

To uninstall the `bamoe-canvas` deployment:

```console
$ helm uninstall bamoe-canvas
```
