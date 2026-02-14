# 01-core-concepts

Kubernetes 기본 오브젝트 이해

## 목표
- Namespace
- Pod
- Deployment
- Service

## 실습
1. Namespace 생성# 01 - Core Concepts

쿠버네티스의 기본 오브젝트 학습 구간입니다.

## 학습 목표

- Pod의 생명주기 이해
- ReplicaSet과 Deployment의 차이 이해
- Namespace를 통한 논리적 격리
- ConfigMap / Secret 구성 이해
- kubectl CLI 기반 운영 능력 강화

## 실습 순서

1. Pod 생성 및 삭제
2. ReplicaSet 스케일 조정
3. Deployment 롤링 업데이트
4. Namespace 격리 실습
5. ConfigMap/Secret 환경변수 주입

## 필수 명령어

```bash
kubectl apply -f
kubectl get all
kubectl describe
kubectl logs
kubectl exec -it
kubectl delete -f

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
