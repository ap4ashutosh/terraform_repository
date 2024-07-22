# Introduction to Terraform Variables

Terraform, a powerful Infrastructure as Code (IaC) tool, allows developers and operations teams to define and manage cloud infrastructure efficiently. At the heart of Terraform's flexibility and reusability are variables. Variables in Terraform serve as dynamic inputs that allow users to customize their infrastructure configurations without modifying the core code. This approach not only enhances the maintainability of Terraform scripts but also promotes code reuse across different environments and projects. By mastering the use of variables, Terraform practitioners can create more adaptable, scalable, and easier-to-manage infrastructure deployments. This guide will walk you through the fundamentals of Terraform variables, from basic declaration to advanced usage patterns, empowering you to write more efficient and flexible Terraform configurations.

Here we have taken the example of variables with AWS, but in the `main.tf` we have used the codes for azure. 

## Why Use Variables?

- Enhance reusability of Terraform templates
- Promote DRY (Don't Repeat Yourself) development
- Allow customization without altering source code
- Enable sharing modules between configurations

## Variable Declaration

- Typically declared in `variables.tf` file (not mandatory but common practice)
- Each variable must be declared before use
- Uses `variable` block for declaration

### Variable Block Structure

```hcl
variable "example_variable" {
  type        = string
  description = "This is an example variable"
  default     = "default_value"
  sensitive   = false
  validation {
    condition     = length(var.example_variable) > 5
    error_message = "The variable must be longer than 5 characters."
  }
}
```

### Key Components:

1. **Name**: Unique identifier for the variable
2. **Type**: Defines the kind of value (e.g., string, number, bool)
3. **Description**: Explains the purpose of the variable
4. **Default**: Optional default value
5. **Sensitive**: Boolean flag for sensitive data
6. **Validation**: Optional rules to validate input

## Setting Variable Values

Variables can be set through multiple methods:

1. Default values in variable declaration
2. Command-line flags (`-var` or `-var-file`)
3. Environment variables
4. `.tfvars` files
5. Auto-loaded `terraform.tfvars` file

### Order of Precedence (Highest to Lowest):

1. Command-line flags
2. `.tfvars` files specified on command line
3. `terraform.tfvars` or `*.auto.tfvars` files
4. Environment variables
5. Default values in variable declarations

## Practical Example: VPC and Subnet Configuration

### Task 1: Adding a VPC Resource

```hcl
resource "aws_subnet" "variables-subnet" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "10.0.250.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true
  
  tags = {
    Name      = "sub-variables-us-east-1a"
    Terraform = "true"
  }
}
```

### Task 2: Introducing Variables

Define variables in `variables.tf`:

```hcl
variable "variables_sub_cidr" {
  description = "CIDR Block for the Variables Subnet"
  type        = string
}

variable "variables_sub_az" {
  description = "Availability Zone used for Variables Subnet"
  type        = string
}

variable "variables_sub_auto_ip" {
  description = "Set Automatic IP Assignment for Variables Subnet"
  type        = bool
}
```

Update the resource to use variables:

```hcl
resource "aws_subnet" "variables-subnet" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.variables_sub_cidr
  availability_zone       = var.variables_sub_az
  map_public_ip_on_launch = var.variables_sub_auto_ip
  
  tags = {
    Name      = "sub-variables-${var.variables_sub_az}"
    Terraform = "true"
  }
}
```

### Task 3: Adding Default Values

Modify variables with default values:

```hcl
variable "variables_sub_cidr" {
  description = "CIDR Block for the Variables Subnet"
  type        = string
  default     = "10.0.202.0/24"
}

variable "variables_sub_az" {
  description = "Availability Zone used for Variables Subnet"
  type        = string
  default     = "us-east-1a"
}

variable "variables_sub_auto_ip" {
  description = "Set Automatic IP Assignment for Variables Subnet"
  type        = bool
  default     = true
}
```

## Best Practices

1. Use descriptive variable names
2. Always include a `description` for each variable
3. Set `sensitive = true` for variables containing sensitive data
4. Use validation rules to ensure input correctness
5. Organize variables logically (e.g., grouping by resource type)
6. Consider using variable files (`.tfvars`) for environment-specific configurations

## Additional Tips

- Use `terraform console` to test and debug variable expressions
- Leverage `locals` for complex calculations or repeated expressions
- Remember that variables can reference other variables
- Use maps and lists for more complex variable structures
- Always review the plan output before applying changes

By using variables effectively, you can create more flexible, maintainable, and reusable Terraform configurations.