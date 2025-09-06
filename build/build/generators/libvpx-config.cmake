########## MACROS ###########################################################################
#############################################################################################

# Requires CMake > 3.15
if(${CMAKE_VERSION} VERSION_LESS "3.15")
    message(FATAL_ERROR "The 'CMakeDeps' generator only works with CMake >= 3.15")
endif()

if(libvpx_FIND_QUIETLY)
    set(libvpx_MESSAGE_MODE VERBOSE)
else()
    set(libvpx_MESSAGE_MODE STATUS)
endif()

include(${CMAKE_CURRENT_LIST_DIR}/cmakedeps_macros.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/libvpxTargets.cmake)
include(CMakeFindDependencyMacro)

check_build_type_defined()

foreach(_DEPENDENCY ${libvpx_FIND_DEPENDENCY_NAMES} )
    # Check that we have not already called a find_package with the transitive dependency
    if(NOT ${_DEPENDENCY}_FOUND)
        find_dependency(${_DEPENDENCY} REQUIRED ${${_DEPENDENCY}_FIND_MODE})
    endif()
endforeach()

set(libvpx_VERSION_STRING "1.15.2")
set(libvpx_INCLUDE_DIRS ${libvpx_INCLUDE_DIRS_RELEASE} )
set(libvpx_INCLUDE_DIR ${libvpx_INCLUDE_DIRS_RELEASE} )
set(libvpx_LIBRARIES ${libvpx_LIBRARIES_RELEASE} )
set(libvpx_DEFINITIONS ${libvpx_DEFINITIONS_RELEASE} )


# Only the last installed configuration BUILD_MODULES are included to avoid the collision
foreach(_BUILD_MODULE ${libvpx_BUILD_MODULES_PATHS_RELEASE} )
    message(${libvpx_MESSAGE_MODE} "Conan: Including build module from '${_BUILD_MODULE}'")
    include(${_BUILD_MODULE})
endforeach()


