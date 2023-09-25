# azure-devops-in-a-box

### Overview
A bit of a fun project, in which an Azure DevOps project is created using Terraform, of which can then be used to run more Terraform, or any code! The proper security controls and configurations have been put in place to ensure that only the required components are deployed, and only the appropriate permissions are provided to the project.

### Azure DevOps Repos vs GitHub Service Endpoint
I decided to use a native Azure DevOps repository for this mini-project, as it supports a more 'out-of-the-box' approach, rather than having to jump through the hoops for configuring GitHub access either via a Personal Access Token, which is a poor option, or OAuth, which can have hurdles to configure in an internal environment, depending on management and security controls.

### Azure Key Vault
Configuration to create an Azure Key Vault is in among the files, as a Key Vault will be used to store the access token for Azure DevOps.

### depends_on
Across the files, the depends_on option is configured on resources to ensure that these are not created in the incorrect order. This is especially in place to accommodate Terraform Cloud, which has a habit of not deploying sequentially, but having more of a haphazard approach, attempting to build resources (excuse the reference to a cracking film) in an 'Everything, Everywhere, All at Once' approach.

### Terrascan
Terrascan has been implemneted to ensure that any insecure configuration is captured pre-deployment. Before deploying to the cloud, the pipeline is configured to run a scan to ensure that no overly permissive principles or insecure resources will be deployed to the cloud.