# 01-core-concepts

Kubernetes 기본 오브젝트를 실습합니다.

## 구조

    01-core-concepts/
      ├── manifests/    # 리소스 정의(YAML)
      ├── exercises/    # 실습 시나리오(작성 예정)
      ├── outputs/      # 결과 기록(선택)
      ├── apply.sh      # 리소스 생성
      └── delete.sh     # 리소스 삭제

## 사용법

리소스 생성:

    ./apply.sh

리소스 확인:

    kubectl get all -n lab-core

리소스 삭제:

    ./delete.sh
