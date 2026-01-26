DEVOPS.md
DevOps Assessment – Setup, Deployment & Troubleshooting

1. Overview

This document describes how the DevOps Assessment application was containerized, deployed, and verified.
The goal was to create a production-ready setup using Docker, Docker Compose, CI/CD, and cloud infrastructure.

The same setup works consistently in both local and server environments.


2. Project Summary

Backend: Django REST API

Frontend: React (Vite)

Web Server: Nginx

Containerization: Docker & Docker Compose

CI/CD: GitHub Actions

Infrastructure: AWS EC2 (provisioned using Terraform)


3. Local Setup Guide

The application is designed to run entirely using Docker.
No local Python or Node installation is required.

3.1 Prerequisites

The following tools must be installed:

Git

Docker

Docker Compose

3.2 Running the Application Locally

Clone the repository:

git clone https://github.com/teerthrajbhatkande7/devops-assessment.git
cd devops-assessment


Start the application:

docker compose up --build


Verify:

Frontend: http://localhost

Backend API: http://localhost/api/hello/

Expected backend response:

{"message": "Hello World from Django Backend!"}



4. Server Deployment Overview

The same Docker Compose setup used locally is also used on the server.

Key points:

The application runs inside Docker containers

Frontend is served via Nginx

Backend runs using Gunicorn

Backend is accessed only through the reverse proxy

No application ports are exposed directly except HTTP

This ensures consistency between environments and avoids configuration drift.


5. CI/CD Pipeline

A CI/CD pipeline is implemented using GitHub Actions.

Pipeline behavior:

Triggers automatically on every push to the main branch

Builds Docker images for backend and frontend

Pushes images to a public Docker registry

This removes the need for manual image builds and ensures repeatable deployments.


6. Infrastructure as Code (Terraform)

Terraform is used to provision cloud infrastructure.

Included:

EC2 instance configuration

Security group allowing only required ports

Variables for environment flexibility

Excluded from version control:

Terraform state files

Provider binaries

Only configuration files (main.tf, variables.tf) are committed.


7. Troubleshooting & Issues Faced

Issue 1: Frontend could not communicate with backend

Problem:
Frontend API calls failed when using localhost.

Reason:
Inside Docker, containers cannot access services via localhost.

Solution:
Configured Nginx as a reverse proxy and routed /api requests internally using Docker service names.

Issue 2: Django DisallowedHost error

Problem:
Django rejected requests with invalid host headers.

Solution:
Updated ALLOWED_HOSTS to include valid container and server hosts.

Issue 3: GitHub push failed due to large Terraform files

Problem:
Terraform provider binaries and state files exceeded GitHub size limits.

Solution:
Removed .terraform directory and state files from Git tracking and added them to .gitignore.

Issue 4: GitHub authentication failure

Problem:
Git push failed due to deprecated password authentication.

Solution:
Repository access was configured correctly using GitHub authentication methods.


8. Application Control

Stop the application:

docker compose down


Start the application:

docker compose up -d


These commands work the same in all environments.


9. Repository & Deployment Details

GitHub Repository:
https://github.com/teerthrajbhatkande7/devops-assessment

Application deployed on cloud infrastructure using Docker

Screenshots of running application are provided separately as part of submission1
