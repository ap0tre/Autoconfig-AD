Get-NetAdapter
Write-Host "---- Configuration réseau ----"
$index = Read-Host "index "
$ip = Read-Host "ip "
$prefixLenght = Read-Host "Mask (/24) without / "
$gateway = Read-Host "Gateway "

New-NetIPAddress -InterfaceIndex $index -IPAddress $ip -PrefixLength $prefixLenght -DefaultGateway $gateway
Write-Host "---- Fin configuration réseau ----"

Add-WindowsFeature -Name AD-Domain-Services -IncludeManagementTools -IncludeAllSubFeature
Add-WindowsFeature -Name DNS -IncludeManagementTools -IncludeAllSubFeature
Add-WindowsFeature -Name RSAT-AD-Tools -IncludeManagementTools -IncludeAllSubFeature
$CreateDnsDelegation = $false
$domain_name = Read-Host "Enter domain name w/o extension "
$extension = Read-Host "Enter extension "
$DomainName = "$domain_name.$extension"
$NetbiosName = "$domain_name"
$NTDSPath = "C:\Windows\NTDS"
$LogPath = "C:\Windows\NTDS"
$SysvolPath = "C:\Windows\SYSVOL"
$DomainMode = "Default"
$InstallDNS = $true
$ForestMode = "Default"
$NoRebootOnCompletion = $false
$strong_passwd = Read-Host "Enter passwd "
$SafeModeClearPassword = "$strong_passwd"
$SafeModeAdministratorPassword = ConvertTo-SecureString $SafeModeClearPassword -AsPlaintext -Force

Import-Module ADDSDeployment
Install-ADDSForest -CreateDnsDelegation:$CreateDnsDelegation -DomainName $DomainName -DatabasePath $NTDSPath -DomainMode $DomainMode -DomainNetbiosName $NetbiosName -ForestMode $ForestMode -InstallDNS:$InstallDNS -LogPath $LogPath -NoRebootOnCompletion:$NoRebootOnCompletion -SysvolPath $SysvolPath -SafeModeAdministratorPassword $SafeModeAdministratorPassword -Force:$true
Restart-Computer