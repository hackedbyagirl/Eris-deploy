<p align="center">
  <a href="" rel="noopener">
 <img width=400px height=400px src="https://github.com/hackedbyagirl/Eris/blob/main/imgs/eris-goddess.png" alt="Eris Avatar"></a>
</p>

<h2 align="center">Eris-deploy</h2>

<div align="center">

  [![Status](https://img.shields.io/badge/status-in%20development-yellowgreen)](https://github.com/hackedbyagirl/Eris-deploy) 
  [![GitHub Issues](https://img.shields.io/github/issues/hackedbyagirl/kali-packer-ami)](https://github.com/hackedbyagirl/Eris-deploy/issues)

</div>

---

<p align="center"> Automating resilient, reusable, and disposable offensive infrastructure utilizing terraform and ansible. 
    <br> 
</p>

## Table of Contents
- [About](#about)
- [Getting Started](#getting_started)
- [Usage](#usage)
- [Acknowledgments](#acknowledgement)

## About <a name = "about"></a>
Eris utilizes a set of modules and third-party terraform providers to create resilient, reusable, and disposable offensive infrastructure.

### Repository Structure
```
Eris/
|__ templates/
|__ |__ create_vpc.tf
|__ |__ external_pentest.tf
|__ |__ *.tf
|__ data/
|__ |__ scripts/
|__ |__ ssh_configs/
|__ |__ ssh_keys/
|__ modules/
|__ |__ aws/
|__ |__ |__ create_vpc/
|__ |__ |__ kali_ec2/
|__ |__ digital_ocean/
|__ ops/
|__ |__ create_vpc/
|__ |__ test1/
|__ |__ test2/
```

Main Directories:
- `templates`: Configuration templates related to specific operations
- `data`: contains scripts, ssh data, and other data to be to be deployed to hosts
- `modules`: Modules related to providers that contain the terraform code
- `ops`: Directory to structure deployment

## Getting Started <a name = "getting_started"></a>
### Prerequisites
- AWS Account - [Create AWS Account](https://www.aws.amazon.com/free)
- [AWS CLI](https://aws.amazon.com/cli/) **
- [Terraform](https://www.terraform.io/)
- [Ansible](https://www.ansible.com/)

### Setup
Instructions on how to get Eris configured locally.

Clone the repository
```bash
#Download Repo and Navigate to Directory
git clone https://github.com/hackedbyagirl/Eris-deploy.git
cd Eris
```

Setup required Environmental Variables
```bash
# Export Required Keys
export AWS_ACCESS_KEY_ID="accesskey"
export AWS_SECRET_ACCESS_KEY="secretkey"
export AWS_DEFAULT_REGION="default region"
```

## Usage <a name="usage"></a>
TBD

## Acknowledgements <a name = "acknowledgement"></a>
Inspiration
- [Red Baron](https://github.com/byt3bl33d3r/Red-Baron)
- [CISAGOV](https://github.com/cisagov/kali-packer)

 
