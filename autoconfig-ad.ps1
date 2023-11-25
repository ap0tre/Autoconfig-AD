# Prompt for network configuration
Get-NetAdapter

Write-Host "---- Configuration réseau ----"
$index = Read-Host "Index"
$ip = Read-Host "IP"
$prefixLength = Read-Host "Mask (/24) without /"
$gateway = Read-Host "Gateway"

# Configure network
New-NetIPAddress -InterfaceIndex $index -IPAddress $ip -PrefixLength $prefixLength -DefaultGateway $gateway
Write-Host "---- Fin configuration réseau ----"

# Install required Windows features
$features = @(
    "AD-Domain-Services",
    "DNS",
    "RSAT-AD-Tools"
)

Add-WindowsFeature -Name $features -IncludeManagementTools -IncludeAllSubFeature

# Active Directory Configuration
Write-Host "---- Configuration Active Directory ----"
$CreateDnsDelegation = $false
$domainName = Read-Host "Enter domain name w/o extension"
$extension = Read-Host "Enter extension"
$fullDomainName = "$domainName.$extension"
$netbiosName = $domainName
$ntdsPath = "C:\Windows\NTDS"
$logPath = "C:\Windows\NTDS"
$sysvolPath = "C:\Windows\SYSVOL"
$domainMode = "Default"
$installDNS = $true
$forestMode = "Default"
$noRebootOnCompletion = $false
$strongPassword = Read-Host "Enter password"
$safeModeClearPassword = "$strongPassword"
$safeModeAdministratorPassword = ConvertTo-SecureString $safeModeClearPassword -AsPlaintext -Force

# Import ADDSDeployment module
Import-Module ADDSDeployment

# Install Active Directory Domain Services
Install-ADDSForest -CreateDnsDelegation:$CreateDnsDelegation -DomainName $fullDomainName -DatabasePath $ntdsPath -DomainMode $domainMode -DomainNetbiosName $netbiosName -ForestMode $forestMode -InstallDNS:$installDNS -LogPath $logPath -NoRebootOnCompletion:$noRebootOnCompletion -SysvolPath $sysvolPath -SafeModeAdministratorPassword $safeModeAdministratorPassword -Force:$true

# Restart the computer
Restart-Computer
