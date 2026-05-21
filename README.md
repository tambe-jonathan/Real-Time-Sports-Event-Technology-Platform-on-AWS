
#  Enterprise Real-Time Sports Event Technology Platform

<p align="center">

![AWS](https://img.shields.io/badge/AWS-Cloud-orange)
![Terraform](https://img.shields.io/badge/Terraform-IaC-purple)
![Jenkins](https://img.shields.io/badge/Jenkins-CI/CD-red)
![SonarQube](https://img.shields.io/badge/SonarQube-Code_Quality-blue)
![Docker](https://img.shields.io/badge/Docker-Containers-blue)
![ECS](https://img.shields.io/badge/ECS-Fargate-green)
![Kinesis](https://img.shields.io/badge/Kinesis-Streaming-orange)
![Lambda](https://img.shields.io/badge/Lambda-Serverless-yellow)
![CloudWatch](https://img.shields.io/badge/CloudWatch-Monitoring-blue)

</p>

---

# Executive Summary

EventPulse is an enterprise-grade event-driven sports technology platform inspired by infrastructure powering large-scale sporting events.

The platform simulates production systems used to process:

- Real-time score ingestion
- Athlete information
- Leaderboards
- Event processing
- Dynamic updates
- Monitoring
- Auto scaling

The architecture emphasizes:

- High availability
- Low latency
- Fault tolerance
- Scalability
- Infrastructure as Code
- DevSecOps practices
- Observability

---

# Business Problem

Major sporting events generate massive volumes of data in real time.

Examples:

- Athlete registrations
- Match statistics
- Scores
- Timing data
- Broadcast data
- User traffic spikes

Challenges:

- Sudden traffic growth
- Processing latency
- Infrastructure failures
- Limited observability
- Deployment risks

EventPulse addresses these problems through:

- Event-driven architecture
- Container orchestration
- Streaming services
- Infrastructure automation
- Monitoring and alerting

---

# Architecture

![Architecture](docs/architecture/architecture-diagram.png)

---

# High-Level Architecture

```text
Users

↓

CloudFront

↓

AWS WAF

↓

Application Load Balancer

↓

ECS Fargate Cluster

├── Score Service
├── Athlete Service
└── Leaderboard Service

↓

Kinesis Data Streams

↓

Lambda Event Processor

↓

DynamoDB

↓

EventBridge

↓

Leaderboard Updates

────────────────────────

Monitoring Layer

CloudWatch
SNS
Grafana

────────────────────────

Security Layer

IAM
Secrets Manager
KMS
Security Groups
```

---

# End-to-End Event Flow

```text
Score Submission

↓

Score Service

↓

Kinesis Stream

↓

Lambda Processing

↓

DynamoDB Storage

↓

EventBridge Trigger

↓

Leaderboard Service

↓

CloudWatch Metrics

↓

Dashboard Visualization
```

---

# Repository Structure

```text
EventPulse/

├── applications/
│   ├── score-service/
│   ├── athlete-service/
│   └── leaderboard-service/
│
├── infrastructure/
│   ├── environments/
│   │   ├── dev/
│   │   ├── staging/
│   │   └── prod/
│   │
│   └── modules/
│       ├── vpc/
│       ├── ecs/
│       ├── ecr/
│       ├── alb/
│       ├── cloudfront/
│       ├── lambda/
│       ├── kinesis/
│       ├── dynamodb/
│       ├── eventbridge/
│       ├── monitoring/
│       ├── security/
│       ├── iam/
│       └── s3/
│
├── jenkins/
│   ├── Jenkinsfile-infra
│   └── Jenkinsfile-services
│
├── docs/
│   ├── screenshots/
│   ├── architecture/
│   └── demo/
│
└── README.md
```

---

# Technology Stack

Infrastructure:

- AWS
- Terraform
- ECS Fargate
- CloudFront
- ALB
- Kinesis
- Lambda
- DynamoDB
- EventBridge

DevOps:

- Jenkins
- SonarQube
- Docker
- Trivy
- GitHub

Monitoring:

- CloudWatch
- SNS
- Grafana

---

# Initial Environment Setup

## Clone Repository

```bash
git clone https://github.com/tambe-jonathan/Real-Time-Sports-Event-Technology-Platform-on-AWS.git

cd Real-Time-Sports-Event-Technology-Platform-on-AWS
```

---

## Configure AWS CLI

```bash
aws configure
```

Provide:

```bash
AWS Access Key
AWS Secret Key
Region: us-east-1
Output: json
```

Verify:

```bash
aws sts get-caller-identity
```

---

## Create Jenkins IAM User

AWS:

```text
IAM

↓

Users

↓

Create User

↓

jenkins-eventpulse
```

Attach:

```text
AdministratorAccess
```

Generate:

```text
Access Key
Secret Key
```

---

# Jenkins Configuration

Install Jenkins:

```bash
docker run -d \
--name jenkins \
-p 8080:8080 \
-p 50000:50000 \
-v ~/jenkins-data:/var/jenkins_home \
-v /var/run/docker.sock:/var/run/docker.sock \
jenkins/jenkins:lts
```

Access:

```text
http://localhost:8080
```

---

## Install Plugins

Install:

- Docker Pipeline
- Terraform
- AWS Credentials
- SonarQube Scanner
- GitHub Integration
- Blue Ocean
- Pipeline
- Credentials Binding

---

## Configure Credentials

Add:

| Type | ID |
|--------|--------|
| Secret Text | aws-access-key |
| Secret Text | aws-secret-key |
| Secret Text | github-token |
| Secret Text | sonarqube-token |

---

# SonarQube Setup

Run:

```bash
docker run -d \
--name sonarqube \
-p 9000:9000 \
sonarqube:lts-community
```

Open:

```text
http://localhost:9000
```

Generate token:

```text
My Account

↓

Security

↓

Generate Token
```

Configure in Jenkins:

```text
Manage Jenkins

↓

System

↓

SonarQube Servers
```

---

# CI/CD Pipeline

Infrastructure Pipeline:

```text
Checkout

↓

Terraform fmt

↓

Terraform validate

↓

Terraform plan

↓

Terraform apply
```

Application Pipeline:

```text
Checkout

↓

Unit Tests

↓

SonarQube Analysis

↓

Trivy Scan

↓

Docker Build

↓

Push To ECR

↓

Deploy ECS Services

↓

Smoke Tests
```

---

# Deploy Project

Run:

Infrastructure pipeline:

```text
eventpulse-infrastructure

↓

Build Now
```

After completion:

```text
eventpulse-services

↓

Build Now
```

---

# API Testing

Replace:

```text
ALB_URL
```

with your deployed load balancer URL.

## Submit Score

```bash
curl -X POST \
http://ALB_URL/score \
-H "Content-Type: application/json" \
-d '{
"athlete":"Mbappe",
"sport":"Football",
"score":"3"
}'
```

Expected:

```json
{
"message":"score received"
}
```

---

## Get Athletes

```bash
curl http://ALB_URL/athletes
```

---

## Get Leaderboard

```bash
curl http://ALB_URL/leaderboard
```

---

# Validate Event Flow

Expected sequence:

```text
Score Request

↓

Score Service

↓

Kinesis

↓

Lambda

↓

DynamoDB

↓

EventBridge

↓

Leaderboard Service
```

Validate:

- Kinesis metrics
- Lambda logs
- DynamoDB records
- ECS logs
- CloudWatch metrics

---

# Load Testing

Install:

```bash
sudo apt install apache2-utils
```

Run:

```bash
ab -n 10000 -c 100 http://ALB_URL/score
```

Observe:

```text
ECS

↓

Services

Desired Tasks:
2

↓

10+
```

---

# Evidence Collection

CI/CD:

- Infrastructure Pipeline Success
- Service Pipeline Success
- SonarQube Quality Gate Passed
- Trivy Scan Success

Infrastructure:

- ECS Cluster
- ALB
- ECR
- CloudFront
- Lambda
- DynamoDB
- Kinesis

Application:

- API responses
- Leaderboard updates
- Lambda logs

Monitoring:

- CloudWatch Dashboard
- ECS Scaling
- Kinesis Metrics

---

# Demo Flow

1. Architecture Diagram
2. Jenkins Pipelines
3. SonarQube Dashboard
4. ECS Services
5. API Request
6. Kinesis Metrics
7. Lambda Logs
8. DynamoDB Records
9. CloudWatch Dashboard
10. ECS Auto Scaling

---

# Resume Highlights

- Designed enterprise-grade event-driven AWS architecture
- Built reusable Terraform modules
- Implemented CI/CD pipelines using Jenkins
- Integrated SonarQube and Trivy into DevSecOps workflows
- Built ECS Fargate microservice architecture
- Implemented real-time event processing using Kinesis and Lambda
- Configured monitoring and observability

---

# Author

Jonathan Tambe

DevOps | Cloud | Platform Engineering

LinkedIn:
https://www.linkedin.com/in/agbor

GitHub:
https://github.com/tambe-jonathan
