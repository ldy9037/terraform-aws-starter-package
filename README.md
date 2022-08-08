# ldy9037/terraform-aws-starter-package

[![standard-readme compliant](https://img.shields.io/badge/readme%20style-standard-brightgreen.svg?style=flat-square)](https://github.com/RichardLitt/standard-readme)

##### 좋은 commit message 작성을 위한 참고자료

- [commit message 작성 규칙](https://udacity.github.io/git-styleguide/)


## Table of Contents

- [소개](#소개)
- [시작하기](#시작하기)
- [주의사항](#주의사항)
- [참고](#참고)
- [제작자](#제작자)

## 소개

  AWS 계정의 초기 설정들을 쉽게 구성하고 이후에 추가될 리소스들을 쉽게 관리할 수 있도록 확장성을 확보하는 것이 프로젝트의 목표입니다. 이 프로젝트는 조직 규모와 상관없이 적용할 수 있도록 설계되었지만 조직 구성에 따라 일부 구성을 변경해야 할 수 있습니다. 

  ![예시](./readme_img/ex1.png)
 
 먼저 조직 규모가 작아 AWS를 사용하는 팀이 단일 팀이라면 위처럼 관리하게 됩니다. 한 Repository 내에는 아래와 같은 Resource들이 구성되어 있습니다. 
 - Terraform Cloud의 상태를 관리하는 Backend S3 
 - AWS Resource들을 Working Directory 별로 분류해서 관리하는 Terraform Cloud의 Workspace
 - 관련 Resource끼리 분류(Working Directory)되어 생성된 AWS Resource 

  ![예시](./readme_img/ex2.png)

조직 규모가 커져 Organization을 도입해 여러 AWS 계정을 사용하게 된다면 위 그림처럼 계정 별로 Repository를 분리해 관리할 수 있습니다. 즉 AWS 계정이 두 개라면 이 Repository도 두 개를 사용해야 합니다. 하지만 공통적인 리소스에 대한 부분은 별도의 AWS 계정으로 분리하는 것을 권장하기 때문에 Organization 도입 시 계정의 수는 3개 이상이 될 가능성이 높으며 공통적인 리소스를 관리하는 계정에서 다른 AWS 계정에 대한 Terraform Cloud의 Backend를 관리하는 것을 권장합니다.(아래 그림 참고)

![예시](./readme_img/ex3.png)

 
 ##### 기술 스택
 - terraform v1.1.7
 - terraform cloud
 - [aws provider](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)


## 시작하기
- [AWS CLI 가이드](https://docs.aws.amazon.com/ko_kr/cli/latest/userguide/cli-configure-files.html)를 참고해서 인증 정보를 먼저 등록해주세요.

- 초기 설정 순서는 backend > workspace > iam > monitoring 입니다.  
- 위 순서 맞게 디렉토리로 이동해서 README.md를 읽고 시작하기를 따라해주시면 됩니다.
- 초기 세팅 이후 작업에 대한 가이드는 각 디렉토리의 README.md를 참고해주세요.

## 주의사항
- [시작하기](#시작하기)에 작성되어 있는 순서대로 실행시키지 않으면 정상동작 하지 않습니다.

## 참고
- [Terraform AWS Provider](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- [Terraform tfe Provider](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs)
- [Standard Module Structure](https://www.terraform.io/language/modules/develop/structure)

## 제작자
[ldy9037@naver.com](ldy9037@naver.com)
