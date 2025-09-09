# devpod sample: terraform

this repo contains a sample devcontainer, for using terraform wit aws...
used by the a demo, presented

---

## Development Container

This project includes a [devcontainer configuration](.devcontainer/devcontainer.json) for a ready-to-use Terraform development environment in Visual Studio Code.

**Features:**

- Based on Ubuntu Jammy image
- Pre-installs:
  - Terraform CLI
  - terraform-docs
  - tfsec (Terraform security scanner)
- Mounts your local AWS credentials into the container for seamless AWS access
- Runs a post-create check for tool versions
- Recommends useful VS Code extensions for Terraform development

**Usage:**

1. Open the project in VS Code.
2. When prompted, reopen in the container.
3. The environment will be set up automatically with all tools and extensions.

For more details, see the [`devcontainer.json`](.devcontainer/devcontainer.json)

**See also**

- [containers.dev](https://containers.dev/)
- [devpod.sh](https://devpod.sh)
