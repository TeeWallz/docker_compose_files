#!/bin/bash -v

export AWS_PROFILE=home_aws
stack_name=docker

cd "$(dirname "$0")"

aws s3 cp ./cloudFormation-docker.yml s3://tomw-cf-templates/cloudFormation-docker.yml
aws cloudformation delete-stack --stack-name $stack_name
aws cloudformation wait stack-delete-complete --stack-name $stack_name
aws cloudformation create-stack --stack-name $stack_name \
                                --template-url https://tomw-cf-templates.s3.ap-southeast-2.amazonaws.com/cloudFormation-docker.yml \
                                --capabilities CAPABILITY_NAMED_IAM