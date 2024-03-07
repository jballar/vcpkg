## Author: GBL
##
## Powershell for vcpkg installation 
## Script to build libraries for
##
## LightHouse, SoftPhone, phones server 

## *** Bootstrap ***
bootstrap-vcpkg.bat

##
## Controllare che il path del Visual Studio nel file triplets\x86-windows-static.cmake
## corrisponda a quello di installazione attuale
##
## NB: il path del Visual Studio va escapato in questo modo (come una stringa C/C++)
##
## 
## set(VCPKG_VISUAL_STUDIO_PATH "C:\\Program Files (x86)\\Microsoft Visual Studio\\2017\\Professional")
##

## *** cpprestsdk ***
vcpkg install cpprestsdk:x86-windows-static

## *** OpenSSL ***
vcpkg install openssl:x86-windows-static

## *** Opus ***
vcpkg install opus[avx]:x86-windows-static

## *** usockets ssl required!!! ***
vcpkg install usockets[ssl]:x86-windows-static

## *** uwebsockets ***
vcpkg install uwebsockets:x86-windows-static

## *** Visual Studio integration ***
vcpkg integrate install

## *** Installed packets ***
vcpkg list
