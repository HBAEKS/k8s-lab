#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"

NAMESPACE="lab-core"

echo "🧹 Deleting core resources from namespace: ${NAMESPACE}"
kubectl delete -f manifests/03-service.yaml --ignore-not-found
kubectl delete -f manifests/02-deployment.yaml --ignore-not-found
kubectl delete -f manifests/01-pod.yaml --ignore-not-found
kubectl delete -f manifests/04-configmap.yaml --ignore-not-found
kubectl delete -f manifests/00-namespace.yaml --ignore-not-found

echo "✅ Done"
