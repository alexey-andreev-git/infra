# Main module

# Locals module called from locals.tf and define data structure in local.deployments_data
# if region undefined in var parameters, it will be defined in deployment.yaml as aws.region

# AWS provider with region defined in var.region or in deployment.yaml as aws.region

# VPC module called from aws-vpc.tf

# Subnets module called from aws-subnets.tf

# Security groups module called from aws-sg.tf

# Internet gateway module called from aws-igw.tf

# Route table module called from aws-route.tf

# EC2 module called from aws-ec2.tf

# Outputs in output.tf