# Application Deployment

This repository contains the infrastructure for deploying a React and Node Application on AWS using Terraform. The infrastructure consists of two Auto Scaling Group (ASG) with desired capacity set to 1, two load balancers and a jump server. The AWS external load balancer acts as the single entry point, terminating SSL and route handling.

## Task Overview

The task involves creating an infrastructure on AWS to host a React frontend Application and Node backend Application. The infrastructure should consider scalability, efficiency, and maintainability. Expected Deliverables include Documentation, Infrastructure-as-Code, Pipeline Configuration [emart-frontend](https://github.com/Einsteiniumeinsteinian/emart-frontend/tree/main/.github/workflows), Sample Application [emart-frontend](https://github.com/Einsteiniumeinsteinian/emart-frontend).

## Layout

The infrastructure layout consists of the following:

1. 2 Auto Scaling Groups:
   - FrontEnd ASG : Host Frontend App.
   - Backend ASG: Host Backend App.
2. Jump Server: Providing SSH access to all private servers.
3. Self-signed SSL: Generated SSL certificates using openssl.
4. External Load Balancer acting as the single entry point to the application with terminating SSL and route handling. It uses HTTP for internal communication and HTTPS for communication with customers and performs a permanent redirect from HTTP to HTTPS.
5. Internal Load Balancer to handle trafic to backend Server
6. Terraform is used for infrastructure setup on AWS.

## Technologies Used

### Server Tools Used

- Node
- Nginx
- Terraform
- Docker
- Docker Hub
- AWS

### AWS Cloud Tools Used

- Application Load Balancer
- Amazon Certificate Manager(ACM)
- EC2 instances
- VPC configurations
- Auto Scaling groups
- Launch templates

### Infrastructure as Code (IAC)

- The infrastructure is described using Terraform version 1.4.6. The linux_amd64 version is used, along with the Terraform AWS provider version 4.67.0.

## Installation

### Terraform

- Clone this Repo. ensure that your credentials are properly set for AWS. 

```bash
cd < directory >/install
chmod 700 install-terraform.sh 
./install-terraform.sh 
```

`N/B: Ensure that you check the variable files for values specific to your deployments*`

### Application URL

You can access the deployed Application at the following URL: <https://amorserv-frontend-alb-225337408.eu-north-1.elb.amazonaws.com/>

## Modifications

### The following Modifications where considered

1. Using a custom VPC module to allow control over the entire VPC network. Allowing for firewall limitations to be set.
2. Jump server to prevent direct access to the application and increase security.
3. ACM for certificate management.
4. http redirect on load balancer
5. Choice of Auto-scaling was used because:
    - it provides both native and container deployments strategy.
    - It provides more control over scaling strategy.

### The following modifications are out of scope but could be implemented to enhance the infrastructure

1. Indept Monitoring of servers, traffic and pipelines: This could be handled by various tools, including AWS's built-in monitoring tools or external tools like Zabbix, Prometheus, or Datadog.
2. Improved Instance user management.
3. Improved logs handling
4. Improved Scaling Policies.
5. Artifactory so as to manage server installation and protect against untrusted repos.
6. Proper version of Docker images.
7. Application firewalls and CDN to prevent DDOS attacks and improve reachability.
8. Security hardening of github actions
9. Custom tcp ports could be used to improve security
10. Notification handling.  
11. Impoved git management.
12. pipeline for infra deployment can be automated

**Please note that this readme provides an overview the full deployment. However, As of now, only the Frontend Infrastructure and application can be deployed.**
