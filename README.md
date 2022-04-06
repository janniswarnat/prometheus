# Prometheus and Grafana running in Google Kubernetes Engine (GKE)

## Google Cloud init in WSL without browser access

```
gcloud init --no-launch-browser
```

## Create secret for Ingress Basic Auth

https://kubernetes.github.io/ingress-nginx/examples/auth/basic/

## Ingress needs a global IP

```
gcloud compute addresses create grafana-ip --global
gcloud compute addresses describe grafana-ip --global
```

This is being retrieved as `kubernetes.io/ingress.global-static-ip-name: grafana-ip` in `ingress-gke.yaml`. 

## Nginx IP

Check `kubectl get ingress` for the external IP:

http://<IP>/?orgId=1

## Grafana dashboard (works partly)

https://grafana.com/grafana/dashboards/315
