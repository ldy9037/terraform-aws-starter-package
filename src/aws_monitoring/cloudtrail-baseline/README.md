## Table of Contents

- [소개](#소개)
- [참고](#참고)
- [제작자](#제작자)

## 소개
cloudtrail 구성을 위한 baseline 모듈

기본 모듈에서 일부 설정 변경
- 네이밍 컨벤션 snake case로 변경
- aws_kms_alias 추가
- management event만 수집하도록 변경

## 참고
- [terraform secure baseline](https://github.com/nozaq/terraform-aws-secure-baseline/tree/main/modules/cloudtrail-baseline)
