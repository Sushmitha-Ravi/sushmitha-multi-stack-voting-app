# Multi-Stack Voting Application - DevOps Infrastructure Project

## Project Overview

This project is a multi-stack microservices voting application deployed using Docker, DockerHub, Terraform, AWS, and Ansible.

The goal was to take a microservices application, test it locally, build custom Docker images, provision AWS infrastructure with Terraform, and deploy the containers to EC2 instances using Ansible.

DevOps work completed by: Sushmitha Ravi

---

## Application Services

| Service | Technology | Purpose |
|---|---|---|
| Vote | Python / Flask | Web page where users submit votes |
| Redis | Redis | Temporary queue for votes |
| Worker | .NET | Moves votes from Redis to Postgres |
| Postgres | PostgreSQL | Stores votes permanently |
| Result | Node.js / Express | Shows voting results |

Application flow:

Vote → Redis → Worker → Postgres → Result

---

## Tools Used

| Area | Tools |
|---|---|
| Version control | Git, GitHub |
| Containers | Docker, Docker Compose |
| Registry | DockerHub |
| Infrastructure as Code | Terraform |
| Cloud provider | AWS |
| Configuration management | Ansible |
| AWS services | VPC, EC2, public/private subnets, Internet Gateway, NAT Gateway, Security Groups, S3, DynamoDB |

---

## Docker and DockerHub

I built and pushed my own Docker images for the main application services:

- rsushmitha/sushmitha-voting-vote:latest
- rsushmitha/sushmitha-voting-result:latest
- rsushmitha/sushmitha-voting-worker:latest

The images were built for both linux/amd64 and linux/arm64.

This is important because my Mac uses ARM architecture, while AWS EC2 may use AMD64. Docker can pull the correct image for the target machine.

---

## Local Docker Compose Test

Before deploying to AWS, I tested the full application locally using Docker Compose.

Local URLs:

- Vote page: http://localhost:8080
- Result page: http://localhost:8081

This confirmed that the services worked together before cloud deployment.

---

## AWS Infrastructure with Terraform

Terraform was used to create the AWS infrastructure.

Main resources created:

- VPC
- Public subnet
- Private subnet
- Internet Gateway
- NAT Gateway
- Route tables
- Security groups
- Frontend EC2 instance
- Backend EC2 instance
- Database EC2 instance
- S3 backend for Terraform state
- DynamoDB table for locking/support

Architecture:

Internet  
↓  
Frontend EC2 in public subnet  
Runs: vote + result  
Also used as bastion host  
↓  
Backend EC2 in private subnet  
Runs: redis + worker  
↓  
Database EC2 in private subnet  
Runs: postgres

---

## Security Design

The frontend EC2 instance is public because users need to access the vote and result pages.

The backend and database EC2 instances are private because Redis, Worker, and Postgres should not be directly exposed to the internet.

Private instances are accessed through the frontend instance as a bastion/jump host.

---

## Ansible Deployment

Ansible was used to configure the EC2 instances and deploy the containers.

Container placement:

| EC2 Instance | Containers |
|---|---|
| Frontend | vote, result |
| Backend | redis, worker |
| Database | postgres |

Ansible completed:

- Connected to frontend directly
- Connected to backend and database through bastion
- Installed Docker on all EC2 instances
- Pulled Docker images
- Started containers
- Verified containers with docker ps

---

## Add-ons Completed

The following safe add-ons were completed:

- Terraform remote state using S3
- DynamoDB table for locking/support
- PostgreSQL Docker volume
- Security group separation

Larger add-ons like Load Balancer and Monitoring were left as future improvements to keep the demo stable.

---

## What I Learned

Through this project, I learned:

- How microservices communicate
- How Docker images and containers work
- How Docker Compose runs services locally
- How to push multi-architecture images to DockerHub
- How Terraform creates AWS infrastructure
- Why public and private subnets are used
- Why NAT Gateway is needed
- How a bastion host works
- How Ansible automates deployment
- How to test and debug containers on EC2

---

## Future Improvements

Possible future improvements:

- Use AWS RDS instead of running Postgres in a container
- Use ElastiCache instead of running Redis in a container
- Use AWS ECR instead of DockerHub
- Add an Application Load Balancer
- Add CloudWatch monitoring and alarms
- Use AWS Secrets Manager or SSM Parameter Store for passwords
- Add a CI/CD pipeline

---

## Cleanup

To avoid AWS costs after the demo:

cd terraform
terraform destroy

Do not run terraform destroy before the final presentation or live demo.