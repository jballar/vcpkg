### [GB240307]
###
### Triplet copyed from community\x86-windows-static-md.cmake
###

set(VCPKG_TARGET_ARCHITECTURE x86)
set(VCPKG_CRT_LINKAGE dynamic)
set(VCPKG_LIBRARY_LINKAGE static)

###
### [GBL] Visual studio 2017
###

set(VCPKG_PLATFORM_TOOLSET v141)

### path must be escaped correctly
### \ -> \\

### The VCPKG_VISUAL_STUDIO_PATH is now passed as the environment variable
### set(VCPKG_VISUAL_STUDI O_PATH "C:\\Program Files (x86)\\Microsoft Visual Studio\\2017\\Professional")
