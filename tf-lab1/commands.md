# Commands for lab 1

## command to format

```sh {"id":"01J1YRTY62ST8QC9JEC18ATXY0"}
terraform fmt
```

## Command to plan the files before the apply

```sh {"id":"01J1YRW1JKZ1JAVR04QW3A8HZV"}
terraform plan
```

## Command to apply the required resources

```sh {"id":"01J1YRYFJ4BRE0R71FWKSJFWDT"}
terraform apply
```

**To auto approve you can use this**

just use the flag *-auto-approve* after apply or destroy

```sh {"id":"01J1YS1PJMBR9FKN609V3JTV6M"}
terraform apply -auto-approve
```

## To destroy the applied changes

```sh {"id":"01J1YS2RSNH5RSYDJ5TSWVYPVA"}
terraform destroy -auto-approve
```