# k8s-lab

Kubernetes / EKS 실습 기록 레포 (SRE/DevSecOps/Platform Engineering 관점)

## Structure
- 00-environment: 로컬/WSL/클러스터 세팅
- 01-core-concepts: 기본 오브젝트
- 02-workloads: HPA/Probe/리소스
- 03-networking: Service/Ingress/NetworkPolicy
- 04-storage: PV/PVC/StorageClass
- 05-security: RBAC/SA/PSA/Secrets
- 06-observability: Prometheus/Grafana/Logging
- 07-gitops: Argo CD
- 08-eks: EKS 실습
- 99-troubleshooting: 장애 재현/분석/복구

## Conventions
- 각 폴더에 README.md + manifests/ 형태로 정리
k8s-lab/
├── 00-environment/ # WSL / kind / EKS 세팅
├── 01-core-concepts/ # Pod, Deployment, Namespace
├── 02-workloads/ # HPA, Probes, Resource
├── 03-networking/ # Service, Ingress, NetworkPolicy
├── 04-storage/ # PV, PVC, StorageClass
├── 05-security/ # RBAC, SA, Secrets
├── 06-observability/ # Prometheus, Grafana
├── 07-gitops/ # ArgoCD
├── 08-eks/ # EKS 실습
├── 99-troubleshooting/ # 장애 재현 및 분석

---

## 🛠 Environment

- WSL2 + VSCode Remote
- kind (Local)
- AWS EKS
- kubectl / helm / kustomize

---

## 📊 Observability Stack

- Prometheus
- Grafana
- Metrics Server
- (추후) Loki

---

## 🔁 GitOps

- ArgoCD 기반 배포 자동화
- PR → Merge → 자동 배포 실습
- Rollback 시나리오 테스트

---

## 🧪 Troubleshooting Philosophy

- CrashLoopBackOff 재현
- OOMKilled 테스트
- 잘못된 ImagePullBackOff 대응
- DNS 장애 실험
- Node NotReady 복구 실험

운영 시나리오 기반 MTTR 개선 실험 포함.

---

## 🎯 Goal

단순 kubectl 실습이 아닌  
**Production Ready Kubernetes 운영 역량 강화**가 목표입니다.
