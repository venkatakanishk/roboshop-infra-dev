## About creation of Terraform VPC and Security group by storing ID's in AWS SSM Parameter store


Using AWS SSM Parameter Store to Share VPC and Security Group IDs
Overview

In this project, I used AWS Systems Manager Parameter Store (SSM) to share infrastructure values between Terraform modules.

Instead of hardcoding resource IDs, important values such as VPC ID and Security Group ID are stored in Parameter Store.
Other modules can then retrieve these values whenever they need them.

This makes the Terraform code more modular, reusable, and easier to maintain.

Simple Architecture
Terraform VPC Module
        │
        ▼
Create VPC
        │
        ▼
Store VPC ID in AWS SSM Parameter Store
        │
        ▼
Security Group Module
        │
        ▼
Retrieve VPC ID from SSM
        │
        ▼
Create Security Group
        │
        ▼
Store Security Group ID in SSM
Implementation Steps
1. Create the VPC

The VPC is created using Terraform in the VPC module.

2. Export the VPC ID

After creating the VPC, the VPC ID is exported using outputs.tf so it can be referenced.

Example:

output "vpc_id" {
  value = aws_vpc.main.id
}
3. Store the VPC ID in Parameter Store

The VPC ID is then stored in AWS SSM Parameter Store using a Terraform resource.

Example parameter name:

/roboshop/dev/vpc_id

This allows other modules to access the VPC ID without depending directly on the VPC module.

4. Retrieve the VPC ID in the Security Group Module

Inside the Security Group module, the VPC ID is retrieved from Parameter Store using a Terraform data source.

Example:

data "aws_ssm_parameter" "vpc_id" {
  name = "/${var.project}/${var.environment}/vpc_id"
}
5. Store the Value in locals.tf

The retrieved value is stored in locals.tf so it can be easily used within the module.

Example:

locals {
  vpc_id = data.aws_ssm_parameter.vpc_id.value
}
6. Create the Security Group

The VPC ID stored in locals is passed to the security group resource to create the security group in the correct VPC.

7. Export the Security Group ID

Once the security group is created, its ID is exported using outputs.tf.

Example:

output "sg_id" {
  value = aws_security_group.main.id
}
8. Store the Security Group ID in Parameter Store

Finally, the Security Group ID is stored in SSM Parameter Store so other modules (like EC2 or Load Balancers) can reuse it.

Example parameter:

/roboshop/dev/mongodb_sg_id
Benefits of This Approach

Avoids hardcoding infrastructure IDs

Makes Terraform modules reusable

Allows different modules to share infrastructure values

Keeps configuration centralized

Follows real-world DevOps infrastructure practices