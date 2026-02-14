#!/usr/bin/env bash
set -e

CLUSTER_NAME="k8s-lab"

echo "🧹 Cleaning up Kubernetes lab environment..."
echo "-------------------------------------------"

if kind get clusters | grep -q "$CLUSTER_NAME"; then
  echo "Deleting kind cluster: $CLUSTER_NAME"
  kind delete cluster --name "$CLUSTER_NAME"
else
  echo "No cluster named '$CLUSTER_NAME' found"
fi

echo ""
echo "Removing dangling Docker resources (optional)"
docker system prune -f

echo ""
echo "✅ Cleanup complete"

