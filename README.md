## Create the EKS cluster
source aws credentails as env variables and set region variable

    cd terraform-aws-eks
    terraform init
    terraform apply --auto-approve

configure kubectl

    aws eks --region $(terraform output -raw region) update-kubeconfig --name $(terraform output -raw cluster_name)

## Deploy Vault

    cd ../terraform-helm-vault
    terraform init
    terraform apply --auto-approve

Initialize and unseal vault

    VAULT_ADDR="http://$(kubectl get svc vault-ui -o json --namespace vault | jq -r '.status.loadBalancer.ingress[].hostname'):8200"
    
    vault operator init -key-shares=1 -key-threshold=1

take note of **unseal key** and **root token**

    vault operator unseal
    vault login

## Deply Consul

    cd ../terraform-helm-consul
    terraform init
    terraform apply --auto-approve



