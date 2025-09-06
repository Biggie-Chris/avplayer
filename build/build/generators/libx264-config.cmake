########## MACROS ###########################################################################
#############################################################################################

# Requires CMake > 3.15
if(${CMAKE_VERSION} VERSION_LESS "3.15")
    message(FATAL_ERROR "The 'CMakeDeps' generator only works with CMake >= 3.15")
endif()

if(libx264_FIND_QUIETLY)
    set(libx264_MESSAGE_MODE VERBOSE)
else()
    set(libx264_MESSAGE_MODE STATUS)
endif()

include(${CMAKE_CURRENT_LIST_DIR}/cmakedeps_macros.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/libx264Targets.cmake)
include(CMakeFindDependencyMacro)

check_build_type_defined()

foreach(_DEPENDENCY ${libx264_FIND_DEPENDENCY_NAMES} )
    # Check that we have not already called a find_package with the transitive dependency
    if(NOT ${_DEPENDENCY}_FOUND)
        find_dependency(${_DEPENDENCY} REQUIRED ${${_DEPENDENCY}_FIND_MODE})
    endif()
endforeach()

set(libx264_VERSION_STRING "cci.20240224")
set(libx264_INCLUDE_DIRS ${libx264_INCLUDE_DIRS_RELEASE} )
set(libx264_INCLUDE_DIR ${libx264_INCLUDE_DIRS_RELEASE} )
set(libx264_LIBRARIES ${libx264_LIBRARIES_RELEASE} )
set(libx264_DEFINITIONS ${libx264_DEFINITIONS_RELEASE} )


# Only the last installed configuration BUILD_MODULES are included to avoid the collision
foreach(_BUILD_MODULE ${libx264_BUILD_MODULES_PATHS_RELEASE} )
    message(${libx264_MESSAGE_MODE} "Conan: Including build module from '${_BUILD_MODULE}'")
    include(${_BUILD_MODULE})
endforeach()


