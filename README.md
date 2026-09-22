# 🚀 DevOps E-Commerce Project

A hands-on DevOps project that uses Terraform, AWS, Docker, Amazon ECR, Amazon EKS, Kubernetes, Git, and GitHub to deploy an e-commerce application.

## 📌 About

This project is focused on learning and implementing a real cloud-native DevOps workflow. The infrastructure is provisioned with Terraform, the application is containerized with Docker, the image is stored in Amazon ECR, and Kubernetes is used to deploy the application on Amazon EKS.

## 🏗️ Architecture

```text
                 🌍 INTERNET
                      │
                      ▼
              ┌───────────────┐
              │    Ingress    │
              └───────┬───────┘
                      │
                      ▼
              ┌───────────────┐
              │ Kubernetes    │
              │    Service    │
              └───────┬───────┘
                      │
                      ▼
       ┌────────────────────────────┐
       │        Amazon EKS          │
       │                            │
       │   ┌────────────────────┐   │
       │   │ Kubernetes Pods    │   │
       │   │ E-Commerce App    │   │
       │   └────────────────────┘   │
       └─────────────┬──────────────┘
                     │
                     ▼
              ┌───────────────┐
              │  Amazon ECR   │
              │ Docker Image  │
              └───────────────┘

Terraform provisions the VPC, subnets, gateways,
route tables, security groups, and EKS resources.
```

## ☁️ AWS Resources

| Resource         | Purpose                                                         |
| ---------------- | --------------------------------------------------------------- |
| VPC              | Main AWS network for the project                                |
| Public Subnets   | Internet-facing networking resources                            |
| Private Subnets  | Private resources and worker-node networking                    |
| Internet Gateway | Enables public internet connectivity                            |
| NAT Gateway      | Allows private subnet resources to access the internet outbound |
| Route Tables     | Control traffic routing between subnets and gateways            |
| Elastic IP       | Public IP address used by the NAT Gateway                       |
| Security Groups  | Control inbound and outbound traffic                            |
| Amazon EKS       | Managed Kubernetes cluster                                      |
| EKS Node Group   | Worker nodes that run application pods                          |
| Amazon ECR       | Stores the Docker image                                         |

## 🌐 Network Design

The Terraform configuration builds a secure AWS network with:

- Public and private subnets
- Internet Gateway for public traffic
- NAT Gateway for outbound traffic from private resources
- Route tables and subnet associations
- Security groups for controlled network access
- Amazon EKS cluster and worker nodes

## 🛠️ Technologies

- ☁️ AWS
- 🏗️ Terraform
- 🐳 Docker
- 📦 Amazon ECR
- ☸️ Kubernetes
- 🚀 Amazon EKS
- 🐍 Python
- 🔀 Git
- 🐙 GitHub
- 🐧 Linux / WSL

## 📂 Project Structure

```text
devops-ecommerce-project/
│
├── application/
│   ├── app.py
│   └── Dockerfile
│
├── kubernetes/
│   ├── deployment.yaml
│   ├── service.yaml
│   ├── ingress.yaml
│   ├── iam_policy.json
│   ├── iam_policy_new.json
│   └── extra-permissions.json
│
├── terraform/
│   ├── provider.tf
│   ├── versions.tf
│   ├── vpc.tf
│   ├── subnets.tf
│   ├── internet-gateway.tf
│   ├── nat-gateway.tf
│   ├── elastic-ip.tf
│   ├── route-tables.tf
│   ├── private-route-tables.tf
│   ├── security-groups.tf
│   ├── eks.tf
│   └── .terraform.lock.hcl
│
├── .gitignore
└── README.md
```

## 🚀 Terraform Workflow

```bash
cd terraform

terraform init
terraform fmt
terraform validate
terraform plan
terraform apply
```

To remove Terraform-managed infrastructure when you are finished:

```bash
terraform destroy
```

> Be careful: `terraform destroy` deletes the AWS resources managed by this project.

## 🐳 Docker Workflow

Build the application image:

```bash
docker build -t ecommerce-app ./application
```

Tag and push the image to Amazon ECR, then use that image in the Kubernetes deployment manifest.

## ☸️ Kubernetes Deployment

After configuring `kubectl` for the EKS cluster:

```bash
kubectl apply -f kubernetes/deployment.yaml
kubectl apply -f kubernetes/service.yaml
kubectl apply -f kubernetes/ingress.yaml
```

Verify the deployment:

```bash
kubectl get pods
kubectl get services
kubectl get ingress
```

## 📈 Progress

- [x] Terraform project setup
- [x] AWS provider configuration
- [x] VPC and subnet configuration
- [x] Internet Gateway and NAT Gateway
- [x] Route tables and associations
- [x] Security groups
- [x] Amazon EKS configuration
- [x] Docker application setup
- [x] Kubernetes Deployment, Service, and Ingress manifests
- [x] GitHub repository setup
- [x] Configure `kubectl` access to EKS
- [x] Deploy the application to EKS
- [x] Verify public access through Ingress

## ⚠️ Security

The following files are intentionally excluded from GitHub:

- Terraform state files and backups
- Terraform variable files
- AWS credentials
- Environment files
- PEM/private-key files
- Kubernetes credentials
- Docker credentials

Never commit AWS access keys, passwords, tokens, or Terraform state files.

## 🎯 Goal

Build practical experience with:

```text
AWS → Terraform → Docker → ECR → EKS → Kubernetes → GitHub → DevOps
```

**Learn it → Build it → Deploy it → Version it → Improve it**

## 👤 Author

**Raghul Dharuman**
