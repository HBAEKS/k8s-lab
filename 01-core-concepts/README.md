# 01-core-concepts

Kubernetes 기본 오브젝트 이해

## 목표
- Namespace
- Pod
- Deployment
- Service

## 실습
1. Namespace 생성
2. nginx Pod 배포
3. Deployment 생성
4. ClusterIP Service 생성

## 검증

```bash
kubectl get ns
kubectl get pods -A
kubectl describe pod <pod>
kubectl get svc
```

## 학습 포인트
- Desired State
- ReplicaSet 자동 생성 구조
- Controller 동작 원리
