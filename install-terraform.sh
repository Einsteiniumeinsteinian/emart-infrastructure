#!/bin/bash
terraform init
terraform validate && terraform plan -out=emart.out && terraform apply emart.out