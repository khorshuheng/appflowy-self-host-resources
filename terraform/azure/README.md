# Introduction
This is a terraform module for deploying AppFlowy Cloud on Azure. By default, the module will create all resources required for AppFlowy Cloud on a resource group named "appflowy", including network.

# Prerequisites
- Azure account with sufficient permission to create resource group, VM and network.
- An Azure Automation Account within the same subscription.
- A dockerhub token to access AppFlowy Premium Image

# AppFlowy Deployment
All services required by AppFlowy Cloud will be installed on a Linux Virtual Machine. The cloud-init script will be used to pull the AppFlowy Cloud repository, which contains the docker compose files and other configuration files required for the deployment. Nginx package will be installed on the VM. The installation directory will be /opt/appflowy.

The Linux Virtual Machine can be accessed via SSH. The private key will be stored on the terraform state file as one of the outputs. You can get the private key via:
```
terraform output generated_ssh_private_key
```
Alternatively, you can login to the VM using Azure CLI:
```
az vm ssh --resource-group appflowy --name appflowy --subscription-id <subscription_id>
```

Azure Automation will be created as part of the deployment. Once the terraform module created all the resources, Azure Automation will need to be run manually to setup the initial configuration and also starting the services.

Azure Vault are used to store all the configurations. This include the .env file used by the docker compose, and also the nginx site configuration.

# Step-by-step guide
1. Make sure that the terraform module is run on an environment which has proper permissions to create resources in Azure. On a local machine, you can login to Azure using the Azure CLI.

2. Make sure that the Azure user has the permission to create resource group on Azure, and also able to read and write to the Vault.

3. Initialize the terraform module by running the following command:

  ```bash
  terraform init
  ```

4. Create a local file named `local.tfvars`, or use the environment variables to override the default variables if you are running terraform on a CI environment. Minimally, the following variables must be set:

  ```bash
  subscription_id          = "<subscription id>"
  location                 = "<azure location>"
  automation_account_name = "appflowy"
  domain_name_label   = "azure-demo"
  smtp_host         = "<smtp host>"
  smtp_port         = 465
  smtp_user         = "postmaster@mail.com"
  smtp_password     = "12345"
  smtp_email        = "postmaster@mail.com"
  docker_hub_password = "dckr_pat_<12345>"
  ```

  For Azure Open AI, add the following:

  ```bash
  azure_openai_api_key = "<azure open ai api key>"
  azure_openai_api_endpoint = "<azure open ai api base>"
  azure_openai_api_version = "<azure open ai api version>"
  ```

5. Apply the terraform plan. If you have created `local.tfvars`, you can run the following command:

  ```bash
  terraform plan -var-file=local.tfvars
  terraform apply -var-file=local.tfvars
  ```

6. On Azure portal, look for `Automation`. In the account settings, add the new user assigned identity created by this terraform module to the identity, under `User assigned`. This is so that the runbook can read the secrets from the vault created, and also run shell script on the virtual machine.

7. Start the runbook named `CreateAppFlowyEnvFile`. You can find the runbook under `Managed runbook`
