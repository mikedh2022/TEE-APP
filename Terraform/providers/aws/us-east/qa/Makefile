help:
	@echo "--------------------------------"
	@echo "------ AWS US-EAST1/qa  ------"
	@echo "--------------------------------"
	@echo ""
	@echo "1- setup terraform env"
	@echo "    make setup"
	@echo ""
	@echo "3- initiate terraform for installing dependencies:"
	@echo "    make init"
	@echo ""
	@echo "4- plan and see the changes that's will be addded:"
	@echo "    make plan"
	@echo ""
	@echo "Other targets:"
	@echo "    make apply"
	@echo "    make output"
	@echo "    make refresh"
	@echo "    make pull_tfvars"
	@echo "    make push_tfvars"

init:
		@terraform init

plan:
	@terraform plan

apply:
	@terraform apply

output:
	@terraform output

refresh:
	@terraform refresh

pull_tfvars:
	aws --profile personnal s3 cp s3://terraform/aws/us-east1/qa/terraform.tfvars .

push_tfvars:
	aws --profile personnal s3 cp terraform.tfvars s3://terraform/aws/us-east1/qa/terraform.tfvars
