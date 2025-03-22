# Automatic Deployment of a Scalable Application on OpenStack with Terraform

## Description
This project automates the deployment of a scalable application in an OpenStack cloud using Terraform as an orchestration tool. The environment consists of several essential services, including web servers, a database, load balancers, and firewalls.

## Features
- Full automation of deployment on OpenStack using Terraform.
- Modular infrastructure, structured in different Terraform files.
- Network configuration with multiple subnets and security rules.
- Load balancing using OpenStack LBaaS (Octavia).
- Custom firewall using OpenStack FWaaS.
- Dynamic scaling of web servers.

## Project Architecture
The application environment consists of:
- Three web servers with Nginx installed automatically.
- A database deployed in a dedicated instance.
- An administration server accessible via SSH.
- A load balancer to distribute web traffic.
- A firewall that restricts unauthorized access.

## Requirements
- OpenStack with administrative access (version >= 1.53.0).
- OpenStack credentials properly configured.
- Terraform installed (version >= 0.14.0).

## Installation and Usage
1. Clone the repository:

  ```sh
  git clone https://github.com/Alejandro-Fdez-Gon/terraform-openstack-network.git
  ```
   
2. Initialize Terraform:

  ```sh
  terraform init
  ```

3. Preview changes:

  ```sh
  terraform plan
  ```

4. Apply the configuration:
  
  ```sh
  terraform apply
  ```

To use variables with values other than the defaults, modify the `terraform.tfvars` file or directly via the command line. Example command-line usage for the variable associated with the number of servers:

  ```sh
  terraform apply -var="num_servers=6" 
  ```

4. To destroy the environment:
  
  ```sh
  terraform destroy
  ```
---

This project was developed as the final project for the Cloud Computing, Network Virtualization, and Services course within the Master's Degree in Telecommunication Engineering.
