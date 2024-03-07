##
## Author: GBL
##
## Powershell script for vcpkg installation 
## Script to build libraries for
##
## LightHouse, SoftPhone, phones server 
##

## *** Bootstrap ***
	
cmd.exe /c .\bootstrap-vcpkg.bat

##
## Check the Visual Studio path in the triplets\x86-windows-static.cmake file
## matches the current installation one
##
## Visual Studio path must be escaped correctly
## \ -> \\
## 
## set(VCPKG_VISUAL_STUDIO_PATH "C:\\Program Files (x86)\\Microsoft Visual Studio\\2017\\Professional")
##

## *** cpprestsdk ***
.\vcpkg.exe install cpprestsdk:x86-windows-static

## *** OpenSSL ***
.\vcpkg.exe install openssl:x86-windows-static

## *** Opus ***
.\vcpkg.exe install opus[avx]:x86-windows-static

## *** usockets (ssl required!!!) ***
.\vcpkg.exe install usockets[ssl]:x86-windows-static

## *** uwebsockets ***
.\vcpkg.exe install uwebsockets:x86-windows-static

## *** Visual Studio integration ***
.\vcpkg.exe integrate install

## *** Installed packets ***
.\vcpkg.exe list
