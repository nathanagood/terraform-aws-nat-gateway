#!/usr/bin/env bash
SCRIPT_DIR=$(cd $(dirname "$0"); pwd -P)
echo "SCRIPT_DIR: ${SCRIPT_DIR}"

#Add this to resolve  jq cmd not found error at runtime
BIN_DIR=$(cat .bin_dir)
cat .bin_dir

REGION=$(cat terraform.tfvars | grep -E "^region" | sed "s/region=//g" | sed 's/"//g')
export VPC_ID=$(terraform output -json | ${BIN_DIR}/jq -r ."vpc_id".value)

export PUB_NGW_SN_ID=$(terraform output -json | ${BIN_DIR}/jq -r  ."pub_ngw_subnet_id".value)
export PUB_NGW_ID=$(terraform output -json | ${BIN_DIR}/jq -r  ."pub_ngw_id".value[0])

export PRI_NGW_SN_ID=$(terraform output -json | ${BIN_DIR}/jq -r  ."priv_ngw_subnet_id".value)
export PRI_NGW_ID=$(terraform output -json | ${BIN_DIR}/jq -r  ."priv_ngw_id".value[0])

echo "VPC_ID: ${VPC_ID}"
echo "PUB_NGW_ID: ${PUB_NGW_ID}"
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

NGW_FOUND=true

# NGW_ID_OUT=$(aws ec2 describe-internet-gateways --filters "Name=attachment.vpc-id,Values=$VPC_ID" --query 'InternetGateways[0].InternetGatewayId' --output=text --no-paginate)
PUB_NGW_ID_OUT=$(aws ec2 describe-nat-gateways --filter "Name=vpc-id,Values=$VPC_ID" --filter "Name=subnet-id,Values=$PUB_NGW_SN_ID" --query 'NatGateways[0].NatGatewayId' --output=text --no-paginate)
echo "PUB_NGW_ID_OUT: $PUB_NGW_ID_OUT"

if [[ ( $PUB_NGW_ID_OUT == $PUB_NGW_ID) ]]; then
  echo "Pub Nat Gateway  found: ${PUB_NGW_ID_OUT} "
     
else
    echo "Pub Nat Gateway Not Found"
    NGW_FOUND=false
fi

PRI_NGW_ID_OUT=$(aws ec2 describe-nat-gateways --filter "Name=vpc-id,Values=$VPC_ID" --filter "Name=subnet-id,Values=$PRI_NGW_SN_ID" --query 'NatGateways[0].NatGatewayId' --output=text --no-paginate)
echo "PRI_NGW_ID_OUT: $PRI_NGW_ID_OUT"

if [[ ( $PRI_NGW_ID_OUT == $PRI_NGW_ID) ]]; then
  echo "Private Nat Gateway  found: ${PRI_NGW_ID_OUT} "
    
else
    echo "Pub Nat Gateway Not Found"
    NGW_FOUND=false
fi

if [[ ($NGW_FOUND == false)]]; then
  exit 1
fi  
