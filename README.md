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