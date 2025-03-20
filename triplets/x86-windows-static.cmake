### [GB250312]
###
### Triplet copyed from community\x86-windows-static-md.cmake
###

set(VCPKG_TARGET_ARCHITECTURE x86)
set(VCPKG_CRT_LINKAGE dynamic)
set(VCPKG_LIBRARY_LINKAGE static)

### [GBL] Visual Studio setting
###
### This triplet was tested with:
### Visual Studio 2017
### Visual Studio 2022
###

# message(WARNING "GBL: IMPORTANT!!! VCPKG_PLATFORM_TOOLSET set to v141 (Visual Studio 2017)")
# set(VCPKG_PLATFORM_TOOLSET v141)

message(STATUS "________________________________________________________________________________")
message(STATUS "GBL: TRIPLET x86-windows-static")
message(STATUS "GBL: IMPORTANT!!! Visual Studio setting not changed")
message(STATUS "GBL: VCPKG_ROOT = ${VCPKG_ROOT}")
message(STATUS "GBL: VCPKG_VISUAL_STUDIO_PATH = ${VCPKG_VISUAL_STUDIO_PATH}")
message(STATUS "GBL: VCPKG_PLATFORM_TOOLSET = ${VCPKG_PLATFORM_TOOLSET}")
message(STATUS "________________________________________________________________________________")

### path must be escaped correctly
### \ -> \\

### The VCPKG_VISUAL_STUDIO_PATH is now passed as the environment variable
### set(VCPKG_VISUAL_STUDIO_PATH "C:\\Program Files (x86)\\Microsoft Visual Studio\\2017\\Professional")

