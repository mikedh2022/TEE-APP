## Continous Integration / Continous Deployment on AWS

the project is a simple hello world,  django rest application that will be deployed to AWS
using AWS CodeBuild and AWS Pipeline.


the project aims to give you a glimpse of Devops Practices:

- building a micro service that will be deployed to an ECS cluster
- write your infrastructure as a code
- enable continous integration
- enable continous Deployment based on Master / tags strategies


### Development
app folder contains the application:

just build it by running:


```
$ make build
$ make up
```

then visit `http://127.0.0.1:8000`



### Deployment

Terraform folder will provision:

- Network VPC, along with an ECS cluster, S3 buckets for caching, logging, artifacts

- AWS Codebuild project, and an AWS Copdepipeline, different webhooks based on github events

- ECS service, ECS task definition, ECR,  an Application load balancer

more info visit this Blog tutorial that walks you through the Terraform Code.