RESOURCE_GROUP_NAME=rg-web
STORAGE_ACCOUNT_NAME=griendeh24g4vw

export ARM_ACCESS_KEY=$(az storage account keys list --resource-group $RESOURCE_GROUP_NAME --account-name $STORAGE_ACCOUNT_NAME --query '[0].value' -o tsv)

echo ${ARM_ACCESS_KEY}
