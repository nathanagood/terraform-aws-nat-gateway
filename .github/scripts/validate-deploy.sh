#!/usr/bin/env bash
SCRIPT_DIR=$(cd $(dirname "$0"); pwd -P)
echo "SCRIPT_DIR: ${SCRIPT_DIR}"

#Add this to resolve  jq cmd not found error at runtime
BIN_DIR=$(cat .bin_dir)
cat .bin_dir


#export VPC_ID=$(terraform output -json | jq -r '."vpc_id".value')
#export NGW_ID=$(terraform output -json | jq -r '.ngw_id".value')
export VPC_ID=$(terraform output -json | ${BIN_DIR}/jq -r ."vpc_id".value)
export NGW_ID=$(terraform output -json | ${BIN_DIR}/jq -r  ."ngw_id".value)
export SUBNET_ID=$(terraform output -json | ${BIN_DIR}/jq -r  ."subnet_id".value)
REGION=$(cat terraform.tfvars | grep -E "^region" | sed "s/region=//g" | sed 's/"//g')

echo "VPC_ID: ${VPC_ID}"
echo "NGW_ID: ${NGW_ID}"
echo "REGION: ${REGION}"

aws configure set region ${REGION}
aws configure set aws_access_key_id ${AWS_ACCESS_KEY_ID}
aws configure set aws_secret_access_key ${AWS_SECRET_ACCESS_KEY}

echo "Checking VPC exists with ID in AWS: ${VPC_ID}"
VPC_ID_OUT=$(aws ec2 describe-vpcs --vpc-ids $VPC_ID --query 'Vpcs[0].VpcId' --output=text) 

echo "VPC_ID_OUT: $VPC_ID_OUT"
if [[ ( $VPC_ID_OUT == $VPC_ID) ]]; then
  echo "VPC id found: ${VPC_ID_OUT}"
   
else
    echo "VPC Not Found"
    exit 1
fi

# NGW_ID_OUT=$(aws ec2 describe-internet-gateways --filters "Name=attachment.vpc-id,Values=$VPC_ID" --query 'InternetGateways[0].InternetGatewayId' --output=text --no-paginate)
NGW_ID_OUT=$(aws ec2 describe-nat-gateways --filter "Name=vpc-id,Values=$VPC_ID" --filter "Name=subnet-id,Values=$SUBNET_ID" --query 'NatGateways[0].NatGatewayId' --output=text --no-paginate)
echo "NGW_ID_OUT: $NGW_ID_OUT"

if [[ ( $NGW_ID_OUT == $NGW_ID) ]]; then
  echo "Nat Gateway  found: ${NGW_ID_OUT} "
    exit 0  
else
    echo "Nat Gateway Not Found"
fi

exit 1
