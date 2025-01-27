## Unofficial AppFlowy Helm Chart
### Introduction
This is an unofficial helm chart for installing [AppFlowy Cloud](https://github.com/AppFlowy-IO/AppFlowy-Cloud) on Kubernetes.
Please report any bugs or issues to this repository instead of the offical AppFlowy repository.

### Quick Start With Minikube
1. Make sure you have the Nginx ingress controller installed. If you haven't, you can enabled it with
```bash
minikube addons enable ingress
```
2. Some of our services require headers with underscore. By default, Nginx ingress controller will block headers with underscore.
To allow headers with underscore, edit the ConfigMap of the Nginx ingress controller. It should look like this:
```yaml
apiVersion: v1
data:
  enable-underscores-in-headers: "true"
  # ...other configurations
kind: ConfigMap
metadata:
  name: ingress-nginx-controller
  namespace: ingress-nginx
# ...other fields
```
The ingress controller should be restarted after the ConfigMap is edited.

3. We have provided a sample values file for Minikube. You can find it at `charts/appflowy/example/values-minikube.yaml`.
If you wish to use magic link, modifies the SMTP related configurations. Otherwise, set up one of the OAuth providers.

4. Install the AppFlowy chart with the following commands:
```bash
helm repo add appflowy https://khorshuheng.github.io/appflowy-self-host-resources
helm upgrade --install appflowy appflowy/appflowy --values charts/appflowy/example/values-minikube.yaml
```
The default configuration assumes that AppFlowy will be accessible at `http://appflowy.minikube.com`.
Edit your hosts file to point `appflowy.minikube.com` to the IP address of your Minikube cluster.
To do so, first, get the IP address of your Minikube cluster with `minikube ip`. Then, add the following line to your hosts file:
```
<minikube-ip> appflowy.minikube.com
```

5. As some pods are dependent on others, it is expected that some pods will crash and restart until all services are up and running.
