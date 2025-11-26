# gitops-1
first study project of github actions ci and argocd cd

For run this this project clone the two repos
1. https://github.com/Sidhin-kp/gitops-1
2. https://github.com/Sidhin-kp/gitops-2

then create new cluster if you want or create new name space

for create new cluster:
1. Check Your Current Kubernetes Cluster
Open your terminal (Command Prompt or PowerShell) and run:

$kubectl config get-contexts
This lists all available clusters and their contexts.

Check your active context:
$kubectl config current-context

Test cluster connection:
$kubectl get nodes

If you see nodes listed, you're connected to a working cluster.

Create a New Kubernetes Cluster (with KIND)
If you want to use KIND (Kubernetes IN Docker), ensure Docker and kind are installed.
Create a new KIND cluster:
$kind create cluster --name my-gitops-cluster

This creates a new local Kubernetes cluster named my-gitops-cluster.
Check the new cluster context:
$kubectl config use-context kind-my-gitops-cluster
$kubectl get nodes


For install argocd:

$kubectl create namespace argocd
$kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

For access argocd ui
$kubectl port-forward svc/argocd-server -n argocd 8080:443
Username: admin

For get the secret
kubectl -n argocd get secret argocd-initial-admin-secret \
  -o jsonpath="{.data.password}" | base64 -d

For create our cd app:
kubectl apply -f argocd/application.yaml -n argocd



Then you have to create repo secrets :
1. DOCKERHUB_USERNAME
2. DOCKERHUB_TOKEN (docker hub credentials for pushing image)
3. GITOPS_PAT (github pat for checkout and update the docker file tag automatically)


For accessing the app in local
$kubectl port-forward svc/nodejs-app-service 8080:80
