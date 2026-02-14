cat > 00-environment/README.md <<'EOF'
# 00-environment

> This layer bootstraps the local Kubernetes lab environment.

로컬 Kubernetes 실습을 위한 기반 인프라 환경(WSL2 + Docker + kind)을 구성합니다.

## 목표

- WSL2 기반 실습 환경 구성
- Docker, kubectl, kind 자동 설치
- 멀티노드 kind 클러스터 생성
- 환경 검증 및 초기화 스크립트 제공

## 구성 구조

    00-environment/
      ├── tools-install.sh   # 도구 설치 자동화
      ├── kind-config.yaml   # 클러스터 정의
      ├── verify.sh          # 환경 점검
      ├── cleanup.sh         # 클러스터 및 리소스 정리
      └── README.md

## Architecture Overview

    Windows
     └── WSL2 (Ubuntu)
           ├── Docker
           ├── kind
           ├── kubectl
           └── Kubernetes Cluster (in Docker)

## 1. 도구 설치

    chmod +x 00-environment/tools-install.sh
    ./00-environment/tools-install.sh

설치 확인:

    docker --version
    kubectl version --client
    kind --version

## 2. 클러스터 생성

    kind create cluster --config 00-environment/kind-config.yaml

클러스터 확인:

    kind get clusters
    kubectl get nodes

## 3. 환경 검증

    chmod +x 00-environment/verify.sh
    ./00-environment/verify.sh

## 4. 환경 정리

    chmod +x 00-environment/cleanup.sh
    ./00-environment/cleanup.sh

## 클러스터 이름

kind-config.yaml 기준:

    name: k8s-lab

verify.sh와 동일한 이름을 사용합니다.

## 설계 의도

이 디렉토리는 Kubernetes 실습 이전 단계인
Bootstrap Layer (Infrastructure Setup Layer) 입니다.

이후 디렉토리(01-core-concepts ~)는
Kubernetes 리소스 실습 계층입니다.
EOF

