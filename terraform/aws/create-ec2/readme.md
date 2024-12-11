# AWS EC2 Terraform Project

This project uses Terraform to create and manage AWS EC2 instances. It provides a simple and efficient way to deploy and configure EC2 instances in your AWS environment.

## Features

- Automated EC2 instance creation
- Configurable instance types and sizes
- Support for multiple regions
- Easy integration with existing AWS infrastructure

## Prerequisites

- Terraform installed on your local machine
- AWS CLI configured with appropriate credentials
- An AWS account with necessary permissions

## Usage

1. Clone the repository:
    ```sh
    git clone https://github.com/alexey-andreev-git/infra/terraform/aws/create-ec2.git
    ```
2. Navigate to the project directory:
    ```sh
    cd create-ec2
    ```
3. Initialize Terraform:
    ```sh
    terraform init
    ```
4. Apply the Terraform configuration:
    ```sh
    terraform apply
    ```

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.