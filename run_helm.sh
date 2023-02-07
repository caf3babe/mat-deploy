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


helm repo add ygqygq2 https://ygqygq2.github.io/charts/
helm upgrade -i --atomic --create-namespace --namespace tracing -f ./zipkin/values.yaml zipkin ygqygq2/zipkin 
# zipkin helm chart needs a patch to work with elasticsearch, provide the correct servicename of elasticsearch node as ES_HOSTS variable in deploymentset

helm repo add bitnami https://charts.bitnami.com/bitnami
kubectl create namespace messaging
kubectl apply -f ./rabbitmq/secret.yaml --namespace messaging 
helm upgrade -i --atomic --create-namespace --namespace messaging -f ./rabbitmq/values.yaml rabbitmq bitnami/rabbitmq # messaging

helm repo add elastic https://helm.elastic.co

helm upgrade -i --atomic --create-namespace --namespace elastic -f ./elasticsearch/values.yaml elasticsearch elastic/elasticsearch 
helm upgrade -i --atomic --create-namespace --namespace elastic -f ./kibana/values.yaml kibana elastic/kibana 
helm upgrade -i --atomic --create-namespace --namespace elastic -f ./logstash/values.yaml logstash elastic/logstash 

helm upgrade -i --atomic --create-namespace --namespace monitoring kube-prometheus-stack ./kube-prometheus-stack 
helm upgrade -i --atomic --create-namespace --namespace cert-manager ./cert-manager 
