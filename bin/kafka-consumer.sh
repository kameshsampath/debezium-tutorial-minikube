#!/bin/bash
set -e 

trap '{ echo "" ; exit 1; }' INT

KAFKA_TOPIC=${1:-'my-topic'}
KAFKA_CLUSTER_NS=${2:-'kafka'}
KAFKA_CLUSTER_NAME=${3:-'my-cluster'}

kubectl -n $KAFKA_CLUSTER_NS run kafka-consumer -ti \
  --image=docker.io/strimzi/kafka:latest-kafka-2.5.0 \
  --rm=true --restart=Never \
  -- bin/kafka-console-consumer.sh \
  --bootstrap-server $KAFKA_CLUSTER_NAME-kafka-bootstrap.$KAFKA_CLUSTER_NS:9092 \
  --topic $KAFKA_TOPIC \
  --property print.key=true \
  --from-beginning
