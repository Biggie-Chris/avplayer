########## MACROS ###########################################################################
#############################################################################################

# Requires CMake > 3.15
if(${CMAKE_VERSION} VERSION_LESS "3.15")
    message(FATAL_ERROR "The 'CMakeDeps' generator only works with CMake >= 3.15")
endif()

if(fdk-aac_FIND_QUIETLY)
    set(fdk-aac_MESSAGE_MODE VERBOSE)
else()
    set(fdk-aac_MESSAGE_MODE STATUS)
endif()

include(${CMAKE_CURRENT_LIST_DIR}/cmakedeps_macros.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/fdk-aacTargets.cmake)
include(CMakeFindDependencyMacro)

check_build_type_defined()

foreach(_DEPENDENCY ${libfdk_aac_FIND_DEPENDENCY_NAMES} )
    # Check that we have not already called a find_package with the transitive dependency
    if(NOT ${_DEPENDENCY}_FOUND)
        find_dependency(${_DEPENDENCY} REQUIRED ${${_DEPENDENCY}_FIND_MODE})
    endif()
endforeach()

set(fdk-aac_VERSION_STRING "2.0.3")
set(fdk-aac_INCLUDE_DIRS ${libfdk_aac_INCLUDE_DIRS_RELEASE} )
set(fdk-aac_INCLUDE_DIR ${libfdk_aac_INCLUDE_DIRS_RELEASE} )
set(fdk-aac_LIBRARIES ${libfdk_aac_LIBRARIES_RELEASE} )
set(fdk-aac_DEFINITIONS ${libfdk_aac_DEFINITIONS_RELEASE} )


# Only the last installed configuration BUILD_MODULES are included to avoid the collision
foreach(_BUILD_MODULE ${libfdk_aac_BUILD_MODULES_PATHS_RELEASE} )
    message(${fdk-aac_MESSAGE_MODE} "Conan: Including build module from '${_BUILD_MODULE}'")
    include(${_BUILD_MODULE})
endforeach()


