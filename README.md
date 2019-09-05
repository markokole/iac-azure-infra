# Provision the infrastructure on Azure to be able to use services

This repository provisions the following services in Azure to make provisioning of VMs possible:

* Resource Group
* Virtual Network
* Subnet

This is a long live provisioning service. The Azure services provisioned can be used for various projects where the above mentioned services are needed.
After the provisioning is done, the outputs are stored to Consul. The following keys in Consul are outputs to the above services:

> test/master/azure/generated/network_interface_id
> test/master/azure/generated/resource_group_name
> test/master/azure/generated/subnet_id
> test/master/azure/generated/virtual_network_id

More can be added by altering *modules/infra/write_to_consul.tf*.

These keys in Consul can be picked up in any other project and used to build on.

## Enter Docker container

The DockerFile to build the container can be found [here](https://github.com/markokole/iac-azure-test).

```bash
cd docker
docker build . --tag=azure-image
docker run -itd --rm --name azure --hostname azure -v C:\marko\GitHub\:/local-git azure-image
docker exec -it azure bash
```

## Azure authentication

When in Docker, execute:

```bash
az login
```

The following message appears:

*To sign in, use a web browser to open the page <https://microsoft.com/devicelogin> and enter the code ABC123 to authenticate.*

Click on the account in the browser and close the page.

If authenticated a JSON output shows up in the Docker.

## Export Azure environment variables

Execute the following commands:

```bash
ARM_SUBSCRIPTION_ID=$(az account show --query "{subscriptionId:id}" --output tsv)

ARM_CLIENT_SECRET=$(az ad sp create-for-rbac --name http://ServicePrincipalName --role="Contributor" --scopes="/subscriptions/${ARM_SUBSCRIPTION_ID}" | jq -r ".password")

ARM_CLIENT_ID=$(az account show --query "{appId:id}" --output tsv)

ARM_TENANT_ID=$(az account show | jq -r ".tenantId")

```

The environment is now ready for provisioning Azure services with Terraform. Step into `/local-git/iac-azure-infra/modules/infra` folder and start provisioning services.

## Provision Services

1. Initialize

```bash
terraform init
```

to initialize the Azure plugins.

2. Check

```bash
terraform plan
```

to check the plan Terraform has for provisioning.

3. Apply

```bash
terraform apply -auto-approve
```

to start provisioning.

## Destroy the provisioned services

```bash
terraform destroy -auto-approve
```
