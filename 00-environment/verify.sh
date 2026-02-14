#!/usr/bin/env bash
set -e

CLUSTER_NAME="k8s-lab"

echo "🔎 Verifying local Kubernetes lab environment..."
echo "----------------------------------------------"

check_cmd() {
  if command -v "$1" >/dev/null 2>&1; then
    echo "✔ $1 installed: $($1 --version 2>/dev/null | head -n1)"
  else
    echo "✖ $1 not installed"
  fi
}

echo ""
echo "📦 Checking required tools"
check_cmd docker
check_cmd kubectl
check_cmd kind

echo ""
echo "🐳 Checking Docker daemon"
if docker ps >/dev/null 2>&1; then
  echo "✔ Docker is running"
else
  echo "✖ Docker not accessible (try: newgrp docker or restart shell)"
fi

echo ""
echo "☸ Checking Kubernetes cluster"
if kind get clusters | grep -q "$CLUSTER_NAME"; then
  echo "✔ kind cluster '$CLUSTER_NAME' exists"
  kubectl get nodes
else
  echo "✖ kind cluster '$CLUSTER_NAME' not found"
fi

echo ""
echo "✅ Verification complete"

