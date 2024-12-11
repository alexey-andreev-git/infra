## AWS Infrastructure Deployment

This document provides a description of the AWS infrastructure deployment using the `deployment.yaml` file.

### Overview

The `deployment.yaml` file defines the configuration for deploying AWS infrastructure. It includes details about regions, VPCs, subnets, internet gateways, security groups, route tables, and EC2 instances.

### Structure

- **aws**: The root element containing AWS-specific configuration.
  - **region**: The AWS region where the resources will be deployed.
  - **deployments**: A list of deployment configurations.

#### Deployment Configuration

Each deployment configuration includes the following elements:

- **id**: A unique identifier for the deployment.
- **vpc**: Configuration for the Virtual Private Cloud (VPC).
  - **cidr_block**: The CIDR block for the VPC.
  - **internet_gateways**: A list of internet gateways.
    - **tag_name**: A tag name for the internet gateway.
  - **subnets**: A list of subnets within the VPC.
    - **cidr_block**: The CIDR block for the subnet.
    - **availability_zone**: The availability zone for the subnet.
    - **map_public_ip_on_launch**: Whether to map public IPs on launch.
    - **tag_name**: A tag name for the subnet.
  - **security_groups**: A list of security groups.
    - **inbound_rules**: A list of inbound rules for the security group.
      - **name**: The name of the rule.
      - **protocol**: The protocol for the rule.
      - **ports**: The ports for the rule.
      - **source_ranges**: The source IP ranges for the rule.
    - **tag_name**: A tag name for the security group.
  - **routes**: A list of route table entries.
    - **destination_network**: The destination network for the route.
    - **target_gateway**: The target gateway for the route.
    - **tags_name**: A tag name for the route table.
  - **ec2**: A list of EC2 instance configurations.
    - **instances_count**: The number of instances to launch.
    - **instance_type**: The instance type.
    - **ami_id**: The AMI ID for the instance.
    - **key_name**: The key pair name for SSH access.
    - **disk_size**: The size of the root disk.
    - **security_groups**: A list of security group IDs to associate with the instance.
    - **subnet**: The subnet ID where the instance will be launched.
    - **associate_public_ip_address**: Whether to associate a public IP address.
    - **tag_name**: A tag name for the instance.

