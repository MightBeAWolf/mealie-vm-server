# Mealie VM Server Deployment

This project provisions and configures a VM to run the
[Mealie](https://mealie.io) recipe management service using OpenTofu (Terraform
fork), Ansible, and Podman. The deployment includes log reporting (Alloy), LDAP
authentication, SSL with Certbot + Cloudflare DNS, and container orchestration.

---

## ⚙️ Environment Setup

This project uses [mise](https://mise.jdx.dev) for tool management and
reproducible task automation.

### 📦 Prerequisites

* [Mise](https://mise.jdx.dev)
* [1Password CLI (`op`)](https://developer.1password.com/docs/cli)
* Access to the secrets defined in `secrets.env`
* OpenTofu

---

## 🧰 Mise Tasks

All tasks are defined in [`mise.toml`](./mise.toml):

| Task                       | Description                                          |
| -------------------------- | ---------------------------------------------------- |
| `mise run setup:venv`      | Creates and installs Python virtualenv requirements  |
| `mise run setup:inventory` | Creates `deployment.tfvars` from Ansible templates   |
| `mise run setup:tofu`      | Initializes OpenTofu from `main.tf`                  |
| `mise run setup:ansible`   | Installs Ansible roles from `requirements.yml`       |
| `mise run deploy`          | Runs `tofu apply` with secrets injected via `op run` |
| `mise run provision`       | Runs `ansible-playbook playbooks/main.yml`           |

---

## 🚀 Usage

```bash
# Step 1: Install the dev tools
mise install

# Step 2: Bootstrap environment
mise run setup:venv

# Step 3: Generate Terraform vars
mise run setup:inventory

# Step 4: Initialize OpenTofu
mise run setup:tofu

# Step 5: Apply infrastructure (Note this will also kick off an asible run.)
mise run deploy

# Later update the configuration defined by ansible, run
mise run provision
```

---

## 📄 License

This project is licensed internally. Not intended for public redistribution.

