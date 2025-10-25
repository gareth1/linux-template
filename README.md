```markdown
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=1.6 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_instance.i-ubuntu-linux-template](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_security_group.all](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/security_group) | data source |
| [aws_subnet_ids.name_of_subnets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet_ids) | data source |
| [aws_vpc.vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_key_name"></a> [key\_name](#input\_key_name) | SSH key to be used to create instance with | `string` | `"name_ssh_key"` | no |
| <a name="input_region"></a> [region](#input\_region) | which AWS region to place instance in | `string` | `"us-west-2"` | no |
| <a name="input_subnet_tier"></a> [subnet\_tier](#input\_subnet_tier) | internal or external | `string` | `"internal"` | no |
| <a name="input_vpc_name"></a> [vpc\_name](#input\_vpc_name) | the name of the vpc these resources  are placeed into. Used by a data source to lookup VPC ID's | `string` | `"vpc_value"` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
```

## Terraform usage

Quick guide to validate and apply this template. Commands assume macOS / zsh.

Initialize for local validation (no remote state):

```bash
terraform init -backend=false
```

Validate configuration:

```bash
terraform validate
```

Plan / apply using a tfvars file (we include an example at `env/example.tfvars`):

```bash
terraform plan -var-file=env/example.tfvars
terraform apply -var-file=env/example.tfvars
```

To enable the S3 backend declared in `provider.tf` (recommended for real runs):

1. Ensure AWS credentials or an assumable role are available to your environment (e.g. `~/.aws/credentials`, environment variables, or an EC2/EKS IAM role).
2. Confirm the S3 backend settings (bucket/key/region/role_arn) in `provider.tf` are correct for your account.
3. Run:

```bash
terraform init
```

Notes / repo-specific gotchas:

- `env/example.tfvars` shows variables you should set: `ami` (required for `terraform apply`), `key_name`, and optionally `instance_count` and `instance_type`.
- The configuration locates a VPC by tag: `tag:name = var.vpc_name`. If you see missing VPC/subnet errors, verify the `vpc_name` value matches the VPC tag in your account/region.
- Instances use `var.instance_count` and are distributed across discovered subnets (round-robin). If `instance_count` > number of subnets, instances will be assigned by index modulo subnet count.
- For quick offline checks, `terraform init -backend=false` + `terraform validate` requires no AWS credentials. To create resources you must run `terraform init` and `terraform apply` with valid credentials and backend access.

If you'd like, I can add a short `Makefile` or `scripts/` helper to wrap these commands.
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=0.12 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_instance.i-ubuntu-linux-template](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_security_group.all](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/security_group) | data source |
| [aws_subnet_ids.name_of_subnets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet_ids) | data source |
| [aws_vpc.vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_key_name"></a> [key\_name](#input\_key\_name) | SSH key to be used to create instance with | `string` | `"name_ssh_key"` | no |
| <a name="input_region"></a> [region](#input\_region) | which AWS region to place instance in | `string` | `"us-west-2"` | no |
| <a name="input_subnet_tier"></a> [subnet\_tier](#input\_subnet\_tier) | internal or external | `string` | `"internal"` | no |
| <a name="input_vpc_name"></a> [vpc\_name](#input\_vpc\_name) | the name of the vpc these resources  are placeed into. Used by a data source to lookup VPC ID's | `string` | `"vpc_value"` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->