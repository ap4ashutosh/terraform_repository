# Exploring Terraform States

In this lab 2 we will explore the apply we done in lab1 and we will check the states file. Now let's see what is a statefile and why it is important

--> In order to properly and correctly manage your infrastructure resources, terraform stores the state of your managed  infrastructure. This state must be stored and maintained on each execution so future operations can perform correctly.

--> By default it is stored in the *"terraform.tfstate"* file. By this when approved to proceed, only the necessary changes will be applied, leaving existing valid infrastructure untouched. But we will explore the terraform cloud to store this statefile so it can be accessed by all team members working in the same project.

## Benefits of the Terraform state

--> During an execution, Terraform willexamine the state of currently running infrastructure, determines the differences exist between current and revised desired state.

--> By this when approved to proceed, only changes will be applied , leaving existing valid infrastructure untouched.

**LAB TASK**

1. To show the current state, follow the command.

*remember the **terraform.tfstate** shouldn't be empty. means you must have done terraform apply command*

```sh {"id":"01J28F6EPSSR9TMQ9N9XWAYTQZ"}
terraform show
```

2. Update your configuration