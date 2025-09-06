########## MACROS ###########################################################################
#############################################################################################

# Requires CMake > 3.15
if(${CMAKE_VERSION} VERSION_LESS "3.15")
    message(FATAL_ERROR "The 'CMakeDeps' generator only works with CMake >= 3.15")
endif()

if(dav1d_FIND_QUIETLY)
    set(dav1d_MESSAGE_MODE VERBOSE)
else()
    set(dav1d_MESSAGE_MODE STATUS)
endif()

include(${CMAKE_CURRENT_LIST_DIR}/cmakedeps_macros.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/dav1dTargets.cmake)
include(CMakeFindDependencyMacro)

check_build_type_defined()

foreach(_DEPENDENCY ${dav1d_FIND_DEPENDENCY_NAMES} )
    # Check that we have not already called a find_package with the transitive dependency
    if(NOT ${_DEPENDENCY}_FOUND)
        find_dependency(${_DEPENDENCY} REQUIRED ${${_DEPENDENCY}_FIND_MODE})
    endif()
endforeach()

set(dav1d_VERSION_STRING "1.5.0")
set(dav1d_INCLUDE_DIRS ${dav1d_INCLUDE_DIRS_RELEASE} )
set(dav1d_INCLUDE_DIR ${dav1d_INCLUDE_DIRS_RELEASE} )
set(dav1d_LIBRARIES ${dav1d_LIBRARIES_RELEASE} )
set(dav1d_DEFINITIONS ${dav1d_DEFINITIONS_RELEASE} )


# Only the last installed configuration BUILD_MODULES are included to avoid the collision
foreach(_BUILD_MODULE ${dav1d_BUILD_MODULES_PATHS_RELEASE} )
    message(${dav1d_MESSAGE_MODE} "Conan: Including build module from '${_BUILD_MODULE}'")
    include(${_BUILD_MODULE})
endforeach()


