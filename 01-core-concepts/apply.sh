#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"

NAMESPACE="lab-core"

echo "🚀 Applying core resources into namespace: ${NAMESPACE}"
kubectl apply -f manifests/00-namespace.yaml
kubectl apply -f manifests/01-pod.yaml
kubectl apply -f manifests/02-deployment.yaml
kubectl apply -f manifests/03-service.yaml
kubectl apply -f manifests/04-configmap.yaml

echo ""
kubectl get all -n "${NAMESPACE}"
echo "✅ Done"
