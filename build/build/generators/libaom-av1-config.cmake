########## MACROS ###########################################################################
#############################################################################################

# Requires CMake > 3.15
if(${CMAKE_VERSION} VERSION_LESS "3.15")
    message(FATAL_ERROR "The 'CMakeDeps' generator only works with CMake >= 3.15")
endif()

if(libaom-av1_FIND_QUIETLY)
    set(libaom-av1_MESSAGE_MODE VERBOSE)
else()
    set(libaom-av1_MESSAGE_MODE STATUS)
endif()

include(${CMAKE_CURRENT_LIST_DIR}/cmakedeps_macros.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/libaom-av1Targets.cmake)
include(CMakeFindDependencyMacro)

check_build_type_defined()

foreach(_DEPENDENCY ${libaom-av1_FIND_DEPENDENCY_NAMES} )
    # Check that we have not already called a find_package with the transitive dependency
    if(NOT ${_DEPENDENCY}_FOUND)
        find_dependency(${_DEPENDENCY} REQUIRED ${${_DEPENDENCY}_FIND_MODE})
    endif()
endforeach()

set(libaom-av1_VERSION_STRING "3.6.1")
set(libaom-av1_INCLUDE_DIRS ${libaom-av1_INCLUDE_DIRS_RELEASE} )
set(libaom-av1_INCLUDE_DIR ${libaom-av1_INCLUDE_DIRS_RELEASE} )
set(libaom-av1_LIBRARIES ${libaom-av1_LIBRARIES_RELEASE} )
set(libaom-av1_DEFINITIONS ${libaom-av1_DEFINITIONS_RELEASE} )


# Only the last installed configuration BUILD_MODULES are included to avoid the collision
foreach(_BUILD_MODULE ${libaom-av1_BUILD_MODULES_PATHS_RELEASE} )
    message(${libaom-av1_MESSAGE_MODE} "Conan: Including build module from '${_BUILD_MODULE}'")
    include(${_BUILD_MODULE})
endforeach()


