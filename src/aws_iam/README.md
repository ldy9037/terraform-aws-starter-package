## Table of Contents

- [소개](#소개)
- [시작하기](#시작하기)
- [주의사항](#주의사항)
- [참고](#참고)
- [제작자](#제작자)

## 소개

 AWS Starter Package 중 IAM resource들을 모아놓은 Directory  
 모든 IAM을 여기서 설정하는 것은 아닙니다. 공통으로 사용되는 Group이나 내/외부 사용자들을 구성합니다. 각 Resource 별로 사용되는 role이나 policy들은 해당 resource 생성 시 같이 작성해주시면 됩니다
 
 ##### 기술 스택
 - terraform v1.1.7
 - [aws provider](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
 
## 시작하기
### 초기 세팅
main.tf에서 아래 값을 변경해줍니다.
```sh
# main.tf
terraform {
  ...

  cloud {
    organization = "<AWS_ACCOUNT>"
    workspaces {
      name = "iam"
    }
  }

  required_version = ">= 1.1.7"
}

...
```
- AWS_ACCOUNT: 이메일 형식의 AWS root account에서 계정 부분  
(ex ldy9037@naver.com 에서 ldy9037)    

terraform.tfvars에서도 아래 값을 변경해줍니다.
```sh
# terraform.tfvars
iam_account_alias = "<ALIAS>"

...
```
- ALIAS: <최상위 조직>-<부서>-<환경>  

그 다음 Terraform을 초기화합니다.
```sh
terraform init
```

Terraform 구성 적용은 Terraform Cloud에서만 가능합니다. 로컬에서는 plan으로 구성 확인만 할 수 있습니다. 
```sh
terraform plan
```

## 주의사항
- Monitoring 보다 먼저 실행되어야 합니다.

## 참고
- [Terraform aws Provider](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)

## 제작자
[ldy9037@naver.com](https://github.com/ldy9037)
