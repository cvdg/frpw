# frpw / firepower: HTB pwnbox

Create a `pwbbox` with `terraform` on `azure`.

## Login to Azure (once)

```shell
$ az login --tenant 1dac3ff2-bab9-401d-8ac3-6fa4eefa0422
```

## Get Access Key

```shell
$ source access_key.sh
```

## Create `htb00`

```shell
$ terraform init
$ terraform plan -out terraform.tfplan
$ terraform apply terraform.tfplan
```

## Delete `htb00`

```shell
$ terraform destroy
```
