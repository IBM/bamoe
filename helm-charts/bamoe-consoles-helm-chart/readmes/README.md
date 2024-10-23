# BAMOE Consoles Helm Chart

BAMOE Consoles is a Helm chart based on the opensource KIE Runtime Tools Consoles Helm Chart that can be used to deploy BAMOE Task and Management Console images on a [Kubernetes](https://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

## Additional requirements

- Podman (for Linux)
- Docker (for macOS)
- Minikube

## Components

- Management Console

## Installing the Chart

### Default install

To install the chart with the release name `bamoe-consoles`:

```console
$ helm install bamoe-consoles oci://quay.io/bamoe/consoles-helm-chart --version=x.x.x
```

Following message should be displayed on your console.

```console
NAME: bamoe-consoles
LAST DEPLOYED: Wed Aug 7 17:09:04 2024
NAMESPACE: default
STATUS: deployed
REVISION: 1
NOTES:
In order to get BAMOE Consoles running you need to run these commands:

1. Run the following commands in a separate terminal to port-forward Management Console application:
  export POD_NAME=$(kubectl get pods --namespace default -l "app.kubernetes.io/component=management-console,app.kubernetes.io/instance=bamoe-consoles" -o jsonpath="{.items[0].metadata.name}")
  export CONTAINER_PORT=$(kubectl get pod --namespace default $POD_NAME -o jsonpath="{.spec.containers[0].ports[0].containerPort}")
  echo "Management Console URL: http://127.0.0.1:8081"
  kubectl --namespace default port-forward $POD_NAME 8081:$CONTAINER_PORT
```

Run above commands to forward container ports to your system ports. After this, BAMOE Canvas should be accessible via http://127.0.0.1:8080

### Minikube install

To install the chart with the release name `bamoe-consoles`:

```console
$ helm pull oci://quay.io/bamoe/consoles-helm-chart --version=x.x.x --untar
$ helm install bamoe-consoles ./consoles-helm-chart --values ./consoles-helm-chart/values-minikube-nginx.yaml --set global.dataIndexUrl="<DATA_INDEX_SERVICE_URL>"
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
$ helm pull oci://quay.io/bamoe/consoles-helm-chart --version=x.x.x --untar
$ helm install bamoe-consoles ./consoles-helm-chart --values ./consoles-helm-chart/values-kubernetes.yaml --set global.dataIndexUrl="<DATA_INDEX_SERVICE_URL>" --set global.kubernetesClusterDomain="<YOUR_KUBERNETES_CLUSTER_DOMAIN>" --set global.kubernetesIngressClass="<YOUR_KUBERNETES_INGRESS_CLASS>"
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
$ oc get ingresses.config cluster --output jsonpath={.spec.domain}
```

If you don't have access rigths to this config, try creating a dummy Route resource and checking its domain.

To install the chart with the release name `bamoe-consoles`:

```console
$ helm pull oci://quay.io/bamoe/consoles-helm-chart --version=x.x.x --untar
$ helm install bamoe-consoles ./consoles-helm-chart --values ./consoles-helm-chart/values-openshift.yaml --set global.dataIndexUrl="<DATA_INDEX_SERVICE_URL>" --set global.openshiftRouteDomain="<YOUR_OCP_ROUTE_DOMAIN>"
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
$ helm uninstall bamoe-consoles
```
