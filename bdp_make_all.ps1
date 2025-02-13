##
## Author: GBL
##
## Powershell script for vcpkg installation 
## Script to build libraries for
##
## LightHouse, SoftPhone, phones server 
##

param (
    [string]$vs2017Path = "C:\\Program Files (x86)\\Microsoft Visual Studio\\2017\\Professional"
)

## *** Bootstrap ***
	
cmd.exe /c .\bootstrap-vcpkg.bat

## Check the Visual Studio 2017 PATH
if (-Not (Test-Path -Path $vs2017Path)) { 
    Write-Host "Path $vs2017Path does not exists!" -ForegroundColor Red 
    Write-Host "Please run the script passing the Visual Studio 2017 Path"
    Write-Host "Example:"
    Write-Host "bdp_make_all.ps1 -vs2017Path <VISUAL_STUDIO_2017_PATH>"
    Write-Host
    Break
}

## Set the Visual Studio 2017 PATH as environment variable
[Environment]::SetEnvironmentVariable('VCPKG_VISUAL_STUDIO_PATH', $vs2017Path)

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

## *** Visual Studio integration ***
.\vcpkg.exe integrate install

## *** Installed packets ***
.\vcpkg.exe list
