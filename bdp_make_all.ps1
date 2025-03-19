##
## Author: GBL
##
## Powershell script for vcpkg installation 
## Script to build libraries for
##
## LightHouse, SoftPhone, phones server 
##

### VS2017 Default Path
### "C:\\Program Files (x86)\\Microsoft Visual Studio\\2017\\Professional",

### VS2022 Default Path
### "C:\\Program Files (x86)\\Microsoft Visual Studio\\2022\\Professional"

param (
    [string]$vs2017Path, 
    [string]$vs2022Path,
    [bool]$doCleanup = $true
)

$startTime = Get-Date
Write-Host "Script started @ $($startTime.ToString('HH:mm:ss'))"

#################
### ARGOMENTI ###
#################

Write-Host "Arguments from command line:"
Write-Host
Write-Host "VS2017 Path = $vs2017Path"
Write-Host "VS2022 Path = $vs2022Path"
Write-Host "Cleanup after build = $doCleanup"

######################
### VCPKG BOOTSTRAP
######################

cmd.exe /c .\bootstrap-vcpkg.bat

####################################
### VISUAL STUDIO PATH (CRITICAL)
####################################

### (TBR) Save Visual Studio parameters on environment
### Not really used now!!!
[Environment]::SetEnvironmentVariable('VCPKG_VISUAL_STUDIO_PATH_VS2017', $vs2017Path)
[Environment]::SetEnvironmentVariable('VCPKG_VISUAL_STUDIO_PATH_VS2022', $vs2022Path)

$vsPathExternal = [System.Environment]::GetEnvironmentVariable('VCPKG_VISUAL_STUDIO_PATH')
Write-Output "VCPKG_VISUAL_STUDIO_PATH (externals set) = $vsPathExternal"

if (-not $vs2017Path -and -not $vs2022Path) {
    Write-Output "No Visual Studio PATH passed from command line" 
} elseif ($vs2022Path) {
    Write-Output "VS2022: Set VCPKG_VISUAL_STUDIO_PATH = $vs2022Path" 
    [Environment]::SetEnvironmentVariable('VCPKG_VISUAL_STUDIO_PATH', $vs2022Path)
} else {
    Write-Output "VS2017: Set VCPKG_VISUAL_STUDIO_PATH = $vs2017Path" 
    [Environment]::SetEnvironmentVariable('VCPKG_VISUAL_STUDIO_PATH', $vs2017Path)
}

$vsPath = [System.Environment]::GetEnvironmentVariable('VCPKG_VISUAL_STUDIO_PATH')

if (-Not $vsPath) {
    Write-Host "No Visual Studio Path 'VCPKG_VISUAL_STUDIO_PATH' in environment variable"
    Write-Host "If this script does not work, please try with"
    Write-Host ""
    Write-Host "bdp_make_all.ps1 -vs2022Path <VISUAL_STUDIO_2022_PATH> (preferred)"
    Write-Host "bdp_make_all.ps1 -vs2017Path <VISUAL_STUDIO_2017_PATH>"
    Write-Host ""
}

Write-Host "******************************************************************************"
Write-Host "Initialization terminated!!!"
Write-Host "Starting with package installation!!!"
Write-Host "******************************************************************************"

#########################
### VCPKG INSTALLATION
#########################

# Costruisci il flag di cleanup
$cleanupFlag = ""
if ($doCleanup) {
    $cleanupFlag = "--clean-after-build"
}

## *** cpprestsdk ***
.\vcpkg.exe install cpprestsdk:x86-windows-static $cleanupFlag

## *** OpenSSL ***
.\vcpkg.exe install openssl:x86-windows-static $cleanupFlag

## *** Opus ***
.\vcpkg.exe install opus[avx2]:x86-windows-static $cleanupFlag

## *** usockets (ssl required!!!) ***
.\vcpkg.exe install usockets[ssl]:x86-windows-static $cleanupFlag

## *** uwebsockets ***
.\vcpkg.exe install uwebsockets:x86-windows-static $cleanupFlag

## *** gRPC - dynamic link ***
.\vcpkg.exe install grpc:x86-windows $cleanupFlag

## *** Visual Studio integration ***
.\vcpkg.exe integrate install

## *** Installed packages list ***
.\vcpkg.exe list

###############################
### SHOW SCRIPT RUNNING TIME
###############################

$endTime = Get-Date

$duration = $endTime - $startTime
$hours = [math]::Floor($duration.TotalHours)
$minutes = $duration.Minutes
$seconds = $duration.Seconds

Write-Host "Script started @ $($startTime.ToString('HH:mm:ss'))"
Write-Host "Script End @     $($endTime.ToString('HH:mm:ss'))"
Write-Host "Durata: $hours ore, $minutes minuti, $seconds secondi"

