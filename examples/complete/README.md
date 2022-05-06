## Starting Steps

1. Download cloudposse's terraform modules
```
terraform init
```

2. Edit `fixtures.ap-southeast-1.tfvars` to suit your needs

3. Deploy the setup to AWS
```
terraform apply -var-file="fixtures.ap-southeast-1.tfvars"
```
