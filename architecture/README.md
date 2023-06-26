# CONFIGURATIONS

## VPC

- 10.10.10.0/24

## Public Subnet

- 10.10.10.128/26
- 10.10.10.192/26

## Private Subnet

- 10.10.10.0/26

## Instance Type (ASG Scaled)

- t3.micro (Frontend Server)
- t3.micro (Backend Server)
- t3.micro (Jump Server)

## SG Ports

- Jumpserver
  - ingress (ssh 22)
  - egress (ssh 22)
- Internal Servers
  - ingress (ssh 22), (http 80)
  - egress (ssh 22), (http 80)
- External Load Balancer
  - ingress (https 443), (http 80)
  - egress (https 443), (http 80)
- Internal Load Balancer
  - ingress (http 80)
  - egress (http 80)
