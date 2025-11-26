GitOps CI/CD with GitHub Actions + Argo CD


🚀 Project Overview

This project demonstrates a complete GitOps workflow using:

GitHub Actions for Continuous Integration (CI)

Argo CD for Continuous Deployment (CD)

Kubernetes (Kind or any cluster) for application hosting



Two Git repositories:


gitops-1 → App source code + Dockerfile + GitHub Actions CI

gitops-2 → Kubernetes manifests + Argo CD application definition (GitOps repo)



Argo CD continuously watches the GitOps repository and automatically synchronizes any changes (such as updated Docker image tags) into the Kubernetes cluster.



📂 Repositories



Application + Docker + GitHub Actions (CI)	https://github.com/Sidhin-kp/gitops-1

Kubernetes Manifests + Argo CD Config (CD)	https://github.com/Sidhin-kp/gitops-2

Clone both repositories before starting.




🔄 CI/CD Workflow Summary



* CI — GitHub Actions

* Build Node.js application

* Build Docker image

* Push image to Docker Hub

* Update Kubernetes deployment image tag inside gitops-2 repo

* Commit + push the updated tag



CD — Argo CD

* Watches the gitops-2 repo

* Detects updated manifest (image tag changed)

* Automatically applies changes to the cluster

* Continuously reconciles cluster with GitHub source of truth



🛠 Prerequisites

Ensure you have the following installed:

* Docker
* kubectl
* kind
* Git


  

🌐 1. Clone the Repositories

git clone https://github.com/Sidhin-kp/gitops-1

git clone https://github.com/Sidhin-kp/gitops-2





☸️ 2. Kubernetes Cluster Setup

Check existing clusters:

$ kubectl config get-contexts

$ kubectl config current-context

$ kubectl get nodes



If nodes appear, you already have a working cluster.

Create a new cluster with KIND

$ kind create cluster --name my-gitops-cluster

$ kubectl config use-context kind-my-gitops-cluster

kubectl get nodes




🎯 3. Install Argo CD

Create namespace:

kubectl create namespace argocd

Install Argo CD:

kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml



🎛 4. Access Argo CD UI

Port-forward Argo CD server:

$ kubectl port-forward svc/argocd-server -n argocd 8080:443



Login credentials

Username: admin

Password:



$ kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d


Open:

https://localhost:8080



📦 5. Deploy the Argo CD Application

From inside the gitops-2 repo:

$ kubectl apply -f argocd/application.yaml -n argocd

This tells Argo CD to watch the GitOps repo and apply changes automatically.




🔐 6. Configure GitHub Secrets for CI Pipeline

Add these secrets in:

➡ GitHub Repo Settings → Secrets → Actions




Secret Name	Description

* DOCKERHUB_USERNAME :	Docker Hub username

* DOCKERHUB_TOKEN	: Docker Hub access token

* GITOPS_PAT	: GitHub PAT for pushing manifest updates




These allow the CI pipeline to:


* Build & push Docker image

* Update Kubernetes manifest in gitops-2 repo

  


🌍 7. Access the Application (Local Port-Forward)


$ kubectl port-forward svc/nodejs-app-service 8080:80


Open the app:

http://localhost:8080



🎉 GitOps Workflow is Ready


* Commit → CI builds & pushes image
* CI updates manifest in gitops-2
* Argo CD syncs Kubernetes cluster
* Your application updates automatically
