#!/usr/bin/env bash

set -ex

kubectl config use-context gke_silicon-keel-346311_europe-central2_jannis2
kubectl delete deployments --ignore-not-found=true prometheus grafana ingress-nginx-controller
#kubectl delete clusterrolebindings --ignore-not-found=true --all
#kubectl delete clusterrole --ignore-not-found=true --all
#kubectl delete serviceaccounts --ignore-not-found=true --all
kubectl delete services --ignore-not-found=true prometheus grafana

kubectl apply -f prometheus-yaml-configmap.yaml
kubectl apply -f prometheus-clusterrole.yaml
kubectl apply -f prometheus-serviceaccount.yaml
kubectl apply -f prometheus-clusterrolebinding.yaml
kubectl apply -f prometheus-service.yaml
kubectl apply -f prometheus-deployment.yaml
kubectl apply -f grafana-service.yaml
kubectl apply -f grafana-deployment.yaml
kubectl apply -f ../foreman/ingress-nginx-controller-deployment.yaml
kubectl wait --for=condition=available --timeout=300s deployment/ingress-nginx-controller -n ingress-nginx
kubectl apply -f ingress-gke.yaml
t=4506 listenaddress=0.0.0.0 connectport=4506 connectaddress=192.168.148.113