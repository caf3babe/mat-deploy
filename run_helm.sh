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

helm install --atomic --create-namespace --namespace tracing zipkin ./zipkin # distributed tracing
helm install --atomic --create-namespace --namespace messaging rabbitmq ./rabbitmq # messaging
helm install --atomic --create-namespace --namespace logging logstash ./logstash # from elk stack
helm install --atomic --create-namespace --namespace monitoring kube-prometheus-stack ./kube-prometheus-stack 
helm install --atomic --create-namespace --namespace cert-manager ./cert-manager 
helm upgrade -i --atomic --create-namespace --namespace apps --timeout 15m0s car-rental ./car-rental