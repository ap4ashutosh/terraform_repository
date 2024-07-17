# Lab3: Terraform plugin Based architecture

Terraform offers to expand into many remote systems all of which have an API. The way we can do this using the plugable architecture namely the terraform providers

- Plugins are nothing but the providers.
- Using these providers Terraform calls their API and configures remote architecture.
- These providers allow terraform to interract with remote systems like cloud, or any possible platforms.
- The providers may be cloud platforms, services, or other for further details visit [registry](https://registry.terraform.io).

## Tasks to be performed

Here in this section we will see how to use the terraform settings block to install the required providers for the plugin based architecture configuration. 

### 1. check for the available providers
You can checkout for available providers from the above provided link of *registry*. Explore different providers and the blocks of code to access them. There are different providers coming from different sources like official, community and other. But always try to go with the official ones.

### 2. Use the HCL to download the provider
The task is to install hashicorp/aws provider. You can refer below code for the very purpose.
- Here apart from the hashicorp/aws we will download from other providers like azure also
- Similarly in default code they have also added another one the random.

```sh {"id":"01J2ZREEKESKFBW5PC79321Q1Y"}
# terraform main.tf
terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = ">= 3.0"
        }
        azurerm = {
            source = "hashicorp/azurerm"
            version = ">= 2.0"
        }
        random = {
            source = "hashicorp/random"
        }
    }
}
```

### 3. Testing the things out
Now we will check the terraform file and download terraform configuration file containing aws provider download

```sh {"id":"01J300RJ7M2VD60MZTKZ45CJCE"}
# Use this command to reformat the main.tf file
terraform fmt
```

```sh {"id":"01J300T2NZQH8NDE6XVPDZ5ZX2"}
# Use this command to install the providers
terraform init
```

```bat {"id":"01J300YG6K6B8YTDXSZD6DAMPS"}
Initializing the backend...

Initializing provider plugins...
- Finding hashicorp/aws versions matching ">= 3.0.0"...
- Finding hashicorp/random versions matching "3.1.0"...
- Installing hashicorp/aws v5.58.0...
- Installed hashicorp/aws v5.58.0 (signed by HashiCorp)
- Installing hashicorp/random v3.1.0...
- Installed hashicorp/random v3.1.0 (signed by HashiCorp)

Terraform has created a lock file .terraform.lock.hcl to record the provider
selections it made above. Include this file in your version control repository
so that Terraform can guarantee to make the same selections by default when
you run "terraform init" in the future.
```

```sh {"id":"01J300V189BCS08KBMNMNC4C3T"}
# Use this command to check terraform and other provider version
terraform version
```

```sh {"id":"01J3011H54ZVKSBKZDZY379979"}
Terraform v1.7.4
on windows_amd64
+ provider registry.terraform.io/hashicorp/aws v5.58.0
+ provider registry.terraform.io/hashicorp/random v3.1.0
```

```sh {"id":"01J3012BNWGPPZPZX3GXMCB0ZQ"}
# Use this to check the terraform providers those are available
terraform providers
```

```sh {"id":"01J3013D5JXJ44J5CX62EGX9A5"}
Providers required by configuration:
.
├── provider[registry.terraform.io/hashicorp/aws] >= 3.0.0
├── provider[registry.terraform.io/hashicorp/azurerm] >= 2.0.0
└── provider[registry.terraform.io/hashicorp/random]
```

## Conclusion
This lab ends here with all the tasks that has been asked to perform with their outputs