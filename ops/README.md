# ops
This directory is where you will manage terraform deployments. 

## Usage
When you want to create a new deployment, you will create a folder in `ops` to store the confuration files. 

### Examples
**Example Case #1**: 
Create a new VPC. *Note: Start in home directory `Eris/`*

```bash
# Create directory and copy template into created folder
mkdir ops/create-vpc
cp templates/create_vpc.tf ops/create-vpc

# Configure template
vim ops/create-vpc/create_vpc.tf

# Launch
cd ops/create-vpc
terraform init 
terraform plan 
terraform apply 
```
**Example Case #2**:
Create and provision base infrastructure for external penetration testing. *Note: Start in home directory `Eris/`*

```bash
# Create directory and copy template into created folder
mkdir ops/external-test
cp templates/external_basic.tf ops/external-test

# Configure template
vim ops/external-test/external_basic.tf

# Launch
cd ops/external-test
terraform init
terraform plan
terraform apply
```

## Potential Integrations
- Associated Workspaces
- Where to launch from 
