### Hexlet tests and linter status:
[![Actions Status](https://github.com/thaidem/devops-for-programmers-project-77/actions/workflows/hexlet-check.yml/badge.svg)](https://github.com/thaidem/devops-for-programmers-project-77/actions)
[![hexlet-check](https://github.com/thaidem/devops-for-programmers-project-77/actions/workflows/hexlet-check.yml/badge.svg)](https://github.com/thaidem/devops-for-programmers-project-77/actions/workflows/hexlet-check.yml)

### Upmon

![Upmon](https://app.upmon.com/badge/e3ac062e-2c3c-47c4-99d8-aca6ef/hfpOwBHk-2.svg)

### Trivia

Automated creation of Yandex Cloud resource architecture using Terraform. Automated deployment of a Redmine Docker container on a virtual machine cluster in Yandex Cloud using Ansible. DataDog agent is used to monitor the status of servers with the application.

**key components:**

- 2 Compute Cloud virtual machines (Ubuntu 22.04 LTS)
- Application Load Balancer
- Managed Service for PostgreSQL cluster

### Preparation

#### 1. clone repo

```bash
git clone https://github.com/thaidem/devops-for-programmers-project-77.git
cd devops-for-programmers-project-77
```

#### 2. Yandex Cloud

- Sign up for Yandex Cloud
- Get an OAuth token, create a working directory and a service account in the cloud
- Copy the template `terraform/template.secret.auto.tfvars`:

   ```bash
   cp terraform/template.secret.auto.tfvars terraform/secret.auto.tfvars
   ```

- Add the data obtained from the cloud to `terraform/secret.auto.tfvars` in the `yc_*` variables
- Create a Backend Storage in the cloud to store the infrastructure state
- Copy the template terraform/template.secret.backend.tfvars:

   ```bash
   cp terraform/template.secret.backend.tfvars terraform/secret.backend.tfvars
   ```
- Add the data obtained from the cloud to  `terraform/secret.backend.tfvars`

### Setup

#### 1. Terraform

[https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)

#### 2. Ansible setup

```bash
sudo apt update
sudo apt install -y ansible python3-pip
pip3 install docker ansible-vault
make a-install-deps
```

#### 3. Configure

- Add the missing private data to `terraform/secret.auto.tfvars`

### Infrastructure (Terraform)

- Perform the initialization of the working directory with configuration files:

  ```bash
  make t-init
  ```

- Propagade infrastructure:

  ```bash
  make t-apply
  ```

### Deploy (Ansible)

- single command:

```bash
make a-deploy
```

### Data security

- Create a password file (for temporary use):

  ```bash
  echo "your_vault_password" >> .vault-password
  ```

- To decrypt files with sensitive data, use the command:

  ```bash
  make decrypt
  ```

- To encrypt files with sensitive data, use the command:

  ```bash
  make encrypt
  ```

- After configuration, architecture setup, and deployment, it is recommended to encrypt the data, remember or record the password in a secure location, and delete the temporary password file.

#### :link: [Ссылка](https://devops-check.ru/) на задеплоенное приложение
