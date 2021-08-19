## Create the EKS cluster
source aws credentails as env variables

set region, owner, and TTL variables in a terraform.tfvars file

    cd terraform-aws-eks
    terraform init
    terraform apply --auto-approve

configure kubectl

    aws eks --region $(terraform output -raw region) update-kubeconfig --name $(terraform output -raw cluster_name)

## Deploy Vault

the data source defined at line 7 of the file [kubernetes.tf](terraform-helm-vault/kubernetes.tf) will be the statefile of the k8s cluster you wish to deploy the chart to. example of remote state from S3 can be found [here](terraform-helm-vault/remote_state.example)

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



