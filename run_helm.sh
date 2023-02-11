#!/usr/bin/env sh

set -e

for DIR in ./* ; do
  [ ! -d "${DIR}" ] && continue
  echo "Helm building dependencies"
  helm dependency update "${DIR}"

  echo "Looking for subcharts"
  for SUB_DIR in ${DIR}/charts/* ; do
    [ ! -d "${SUB_DIR}" ] && continue
    echo "Helm building dependencies"
    helm dependency update "${SUB_DIR}"
  done
  
done

helm repo add bitnami https://charts.bitnami.com/bitnami
kubectl create namespace messaging
kubectl apply -f ./rabbitmq/secret.yaml --namespace messaging 
helm upgrade -i --atomic --create-namespace --namespace messaging -f ./rabbitmq/values.yaml rabbitmq bitnami/rabbitmq --version 11.9.0

helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm upgrade -i --atomic --create-namespace --namespace monitoring -f ./kube-prometheus-stack/values.yaml kube-prometheus-stack prometheus-community/kube-prometheus-stack --version 45.0.0

helm repo add cert-manager https://charts.jetstack.io
helm upgrade -i --atomic --create-namespace --namespace cert-manager -f ./cert-manager/values.yaml cert-manager/cert-manager --version 1.11.0

helm repo add grafana https://grafana.github.io/helm-charts
helm upgrade -i --atomic --create-namespace --namespace logging -f ./loki/values.yaml loki grafana/loki --version 4.6.0