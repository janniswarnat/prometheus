#!/usr/bin/env bash

### Kubernetes in Docker Desktop does not come with cadvisor!!!! ###

set -ex

kubectl config use-context docker-desktop
kubectl delete deployments --ignore-not-found=true prometheus
kubectl delete clusterrolebindings --ignore-not-found=true prometheus
kubectl delete clusterrole --ignore-not-found=true prometheus
kubectl delete serviceaccounts --ignore-not-found=true prometheus

kubectl apply -f prometheus-yaml-configmap.yaml
kubectl apply -f prometheus-clusterrole.yaml
kubectl apply -f prometheus-serviceaccount.yaml
kubectl apply -f prometheus-clusterrolebinding.yaml
kubectl apply -f prometheus-service.yaml
kubectl apply -f prometheus-deployment.yaml
kubectl apply -f grafana-persistentvolumeclaim.yaml
kubectl apply -f grafana-service.yaml
kubectl apply -f grafana-deployment.yaml
kubectl apply -f ../foreman/ingress-local.yaml
