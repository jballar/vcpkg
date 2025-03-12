##
## Author: GBL
##
## Powershell script for vcpkg installation 
## Script to build libraries for
##
## LightHouse, SoftPhone, phones server 
##

param (
    [string]$vs2017Path = "C:\\Program Files (x86)\\Microsoft Visual Studio\\2017\\Professional",
    [string]$vs2022Path = "C:\\Program Files (x86)\\Microsoft Visual Studio\\2022\\Professional"
)

## *** Bootstrap ***
	
cmd.exe /c .\bootstrap-vcpkg.bat

$vsPathExists = $false

## Check the Visual Studio 2017 PATH
if (-Not (Test-Path -Path $vs2017Path)) { 
    Write-Host "Path $vs2017Path does not exists!" -ForegroundColor Red 
} else {
    $vsPathExists = $true
}

## Check the Visual Studio 2022 PATH
if (-Not (Test-Path -Path $vs2022Path)) { 
    Write-Host "Path $vs2017Path does not exists!" -ForegroundColor Red 
} else {
    $vsPathExists = $true
}

if (-Not $vsPathExists) {
    Write-Host "Please run the script passing a Visual Studio Path"
    Write-Host ""
    Write-Host "Example:"
    Write-Host ""
    Write-Host "bdp_make_all.ps1 -vs2022Path <VISUAL_STUDIO_2022_PATH> (preferred)"
    Write-Host "bdp_make_all.ps1 -vs2017Path <VISUAL_STUDIO_2017_PATH>"
    Write-Host
    Break
}

## Set the Visual Studio PATHs as environment variable
[Environment]::SetEnvironmentVariable('VCPKG_VISUAL_STUDIO_PATH', $vs2022Path)
[Environment]::SetEnvironmentVariable('VCPKG_VISUAL_STUDIO_PATH_VS2017', $vs2017Path)
[Environment]::SetEnvironmentVariable('VCPKG_VISUAL_STUDIO_PATH_VS2022', $vs2022Path)

## *** cpprestsdk ***
.\vcpkg.exe install cpprestsdk:x86-windows-static

## *** OpenSSL ***
.\vcpkg.exe install openssl:x86-windows-static

## *** Opus ***
.\vcpkg.exe install opus[avx2]:x86-windows-static

## *** usockets (ssl required!!!) ***
.\vcpkg.exe install usockets[ssl]:x86-windows-static

## *** uwebsockets ***
.\vcpkg.exe install uwebsockets:x86-windows-static

## *** grpc - dynamic link ***
.\vcpkg.exe install grpc:x86-windows

## *** Visual Studio integration ***
.\vcpkg.exe integrate install

## *** Installed packets ***
.\vcpkg.exe list

