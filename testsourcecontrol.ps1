Param(
    [Parameter(Mandatory=$true)]
    [String] $ResourceGroupName,

    [Parameter(Mandatory=$true)]
    [String] $AutomationAccountName,
 
    [Parameter(Mandatory=$true)]
    [String] $SourceControlName
)
# Authenticate to Azure so we can upload the runbooks
$RunAsConnection = Get-AutomationConnection -Name "AzureRunAsConnection"         

Write-Verbose ("Logging in to Azure...")
Add-AzureRmAccount `
    -ServicePrincipal `
    -TenantId $RunAsConnection.TenantId `
    -ApplicationId $RunAsConnection.ApplicationId `
    -CertificateThumbprint $RunAsConnection.CertificateThumbprint | Write-Verbose 

Select-AzureRmSubscription -SubscriptionId $RunAsConnection.SubscriptionID  | Write-Verbose 

Start-AzureRmAutomationSourceControlSyncJob -ResourceGroupName $ResourceGroupName `
                                            -AutomationAccountName $AutomationAccountName `
                                            -Name $SourceControlName

