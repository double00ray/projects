download
terraform init
terraform apply
need aws credentials

## Terraform Configuration Summary

### Resources Created

1. **AWS DB Parameter Group**
   - **Resource Name:** `aws_db_parameter_group.marcusdev-subnet-param`
   - **Description:** Creates a custom parameter group for a PostgreSQL 16 database.
   - **Parameters:**
     - `log_connections`: Set to `1` to enable logging of connections.

2. **AWS DB Instance**
   - **Resource Name:** `aws_db_instance.marcusdevrdsinstance`
   - **Description:** Creates a PostgreSQL RDS instance.
   - **Attributes:**
     - `identifier`: `marcusdev`
     - `instance_class`: `db.t3.micro`
     - `allocated_storage`: `5` GB
     - `engine`: `postgres`
     - `username`: `marcusdevadmin`
     - `password`: Retrieved from the variable `var.db_password`
     - `db_subnet_group_name`: References the subnet group created elsewhere in the configuration
     - `vpc_security_group_ids`: References the security group created elsewhere in the configuration
     - `parameter_group_name`: References the custom parameter group `aws_db_parameter_group.marcusdev-subnet-param`
     - `publicly_accessible`: Set to `false` to ensure the database is not publicly accessible
     - `skip_final_snapshot`: Set to `true` to skip the final snapshot when the database is deleted

3. **Terraform Backend Configuration**
   - **Backend Type:** S3
   - **Description:** Specifies that the Terraform state file will be stored in an S3 bucket.
   - **Attributes:**
     - `bucket`: `ardee-dev-terraform-state`
     - `key`: `./terraform.tfstate`
     - `region`: `us-east-2`

### Outputs

- **RDS Instance Endpoint**
  - **Description:** The endpoint of the RDS instance.
  - **Value:** `aws_db_instance.marcusdevrdsinstance.endpoint`

- **RDS Instance ID**
  - **Description:** The ID of the RDS instance.
  - **Value:** `aws_db_instance.marcusdevrdsinstance.id`


# Terraform AWS Setup Guide

## How to Create a User for Terraform and Access AWS Resources in an Account

1. Go to IAM.
2. Create a user called `terraform`.
3. Click `Next`.
4. Leave `Add user to a group` checked.
5. Create a group called `admins`.
6. Check `AdministratorAccess`.
7. Click `Create user group`.
8. Check `Admins` group.
9. Click `Next`.
10. Click `Create user`.
11. Click on the `terraform` user.
12. Go to `Security credentials`.
13. Click `Create access key`.
14. Select `Other`.
15. Click `Next`.
16. Click `Create access key`.
17. Copy the access key and secret access key:
    - Access key: `YOUR_ACCESS_KEY`
    - Secret access key: `YOUR_SECRET_ACCESS_KEY`
18. Click `Done`.

## Setting Up AWS Credentials

### On Mac

Open terminal and run the following commands:

```sh
export AWS_ACCESS_KEY_ID="YOUR_ACCESS_KEY"
export AWS_SECRET_ACCESS_KEY="YOUR_SECRET_ACCESS_KEY"
export AWS_DEFAULT_REGION="us-east-1"


