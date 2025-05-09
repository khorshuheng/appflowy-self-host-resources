param(
)

Disable-AzContextAutosave -Scope Process
$AzureContext = (Connect-AzAccount -Identity -AccountId ${client_id}).context
$AzureContext = Set-AzContext -SubscriptionName $AzureContext.Subscription -DefaultProfile $AzureContext

$appflowyEnvBase64 = Get-AzKeyVaultSecret -VaultName ${vault_name} -Name ${appflowy_env_secret_name} -AsPlainText
$appflowySiteConfBase64 = Get-AzKeyVaultSecret -VaultName ${vault_name} -Name ${appflowy_site_conf_secret_name} -AsPlainText

$script = @"
cloud-init status --wait
echo '$($appflowyEnvBase64)' | base64 -d > /opt/appflowy/AppFlowy-Cloud/.env
echo '$($appflowySiteConfBase64)' | base64 -d > /etc/nginx/conf.d/appflowy-cloud-site.conf
nginx -s reload
docker login -u appflowyinc -p ${docker_hub_password}
cd /opt/appflowy/AppFlowy-Cloud; docker compose -f docker-compose-base.yml -f docker-compose-external.yml up -d
"@

Invoke-AzVMRunCommand -ResourceGroupName ${resource_group_name} `
    -Name ${vm_name} `
    -CommandId 'RunShellScript' `
    -ScriptString $script
