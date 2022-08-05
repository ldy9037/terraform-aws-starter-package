## Table of Contents

- [소개](#소개)
- [시작하기](#시작하기)
- [주의사항](#주의사항)
- [참고](#참고)
- [제작자](#제작자)

## 소개

 AWS stater package 중 Terraform Backend 설정에 대한 Directory
 여기서 생성한 S3 Backend에는 tfe Provider로 생성한 Terraform Cloud resource의 상태가 저장됩니다.
 
 ##### 기술 스택
 - terraform v1.1.7
 - [aws provider](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
 
## 시작하기
Backend는 초기에 한 번만 설정하면 이후에 다시 설정 할 일이 거의 없습니다.

Terraform state resource 용 환경 변수를 지정합니다. 여기서 지정한 환경변수는 Terraform 변수로도 사용됩니다.    
[direnv](https://harmonious-lan-9d2.notion.site/direnv-89499a72674348ad893c79e87cf2a878)를 사용하면 매번 변수를 export 하지않아도 됩니다. 
```sh
export TF_VAR_region=ap-northeast-2

export TF_VAR_organization=<ORGANIZATION>
export TF_VAR_s3_tfstate_bucket_name=s3-tfstate-management-$TF_VAR_organization
export TF_VAR_s3_tfstate_bucket_encryt=true
export TF_VAR_s3_tfstate_bucket_acl=private
export TF_VAR_s3_tfstate_bucket_key=backend/terraform.tfstate

export TF_VAR_dynamodb_tfstate_lock_table_name=TerraformStateLock
```
위 값들은 반드시 환경변수로 설정해주세요. Backend 설정 시 사용됩니다.

ORGANIZATION은 조직/부서 명을 입력해주세요. AWS 계정의 용도를 적어주셔도 좋습니다. 
이 값은 ep, ot, tc 처럼 부서 이니셜이 될수도 있고 kakao, naver 처럼 회사명이 될 수도 있습니다.

Terraform을 초기화 하고 구성을 적용합니다.

```sh
terraform init
terraform apply
```

구성이 적용됐다면 main.tf로 이동해 아래와 같은 코드 블럭에서 주석을 제거합니다.
```
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.11.0"
    }
  }

  # 이 부분 주석 제거
  backend "s3" {
  }

  required_version = ">= 1.1.7"
}
...
```

주석을 제거 했다면 이번엔 위에서 작성한 환경 변수를 사용해 다시 초기화 합니다.  
초기화 시 Backend 정보로 환경변수들을 사용하며, 중간에 Backend를 s3로 지정할 것이냐고 묻는 메세지가 출력되는데 yes를 입력해서 계속 진행합니다.
```sh
terraform init \
-backend-config="bucket=$TF_VAR_s3_tfstate_bucket_name" \
-backend-config="key=$TF_VAR_s3_tfstate_bucket_key" \
-backend-config="region=$TF_VAR_region" \
-backend-config="encrypt=$TF_VAR_s3_tfstate_bucket_encryt" \
-backend-config="acl=$TF_VAR_s3_tfstate_bucket_acl" \
-backend-config="dynamodb_table=$TF_VAR_dynamodb_tfstate_lock_table_name"
```

## 주의사항
- Resource를 한 번 생성 후 Backend를 설정하는 이유는 Backend 설정 시 이미 생성되어 있는 S3 저장소를 지정해주어야 하기 때문입니다. 꼭 S3 생성 후 Backend를 지정해주세요.

## 참고
- [Terraform AWS Provider](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- [Terraform Backend Type: S3](https://www.terraform.io/language/settings/backends/s3)
- [Terraform State 정리](https://harmonious-lan-9d2.notion.site/Terraform-State-79a2e5707e944055a07b3386da9b6491)

## 제작자
[ldy9037@naver.com](https://github.com/ldy9037)
