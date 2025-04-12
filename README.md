# AWS Terraform Infrastructure

## Introduction
This repository contains Terraform configurations for setting up AWS infrastructure. It includes modules for various AWS services and aims to provide reusable and scalable infrastructure components.

## Project Structure
```
tf-aws-infra/ 
├── .github/ 
│ └── workflows/ 
│ └── terraform.yml 
├── .gitignore 
├── LICENSE 
├── main.tf 
├── outputs.tf 
├── README.md 
├── resources/ 
│ ├── internet_gateway/ 
│ │ ├── main.tf 
│ │ ├── outputs.tf 
│ │ └── variables.tf 
│ ├── route_table/ 
│ │ ├── main.tf 
│ │ ├── outputs.tf 
│ │ └── variables.tf 
│ ├── subnet/ 
│ │ ├── main.tf 
│ │ ├── outputs.tf 
│ │ └── variables.tf 
│ └── vpc/ 
│ ├── main.tf 
│ ├── outputs.tf 
│ └── variables.tf 
└── variables.tf
```

## Prerequisites
- Terraform v0.12 or later
- AWS CLI configured with appropriate credentials
- An AWS account

## Installation
1. Clone the repository:
    ```sh
    git clone https://github.com/yourusername/tf-aws-infra.git
    cd tf-aws-infra
    ```
2. Initialize Terraform:
    ```sh
    terraform init
    ```

## Usage
1. Customize the variables in the `variables.tf` file or create a `terraform.tfvars` file with your specific values.
2. Plan the infrastructure changes:
    ```sh
    terraform plan
    ```
3. Apply the changes to create the infrastructure:
    ```sh
    terraform apply
    ```

## SSL Certificate
- Run the below command on terminal to import certificate.

`aws acm import-certificate --certificate file://C:/Users/Sarthak/Downloads/demo_sarthakdeshmukh_me.crt --certificate-chain file://C:/Users/Sarthak/Downloads/demo_sarthakdeshmukh_me.ca-bundle --private-key file://C:/Users/Sarthak/.ssh/demo.sarthakdeshmukh.me.key`