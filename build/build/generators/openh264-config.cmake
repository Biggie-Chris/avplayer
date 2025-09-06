########## MACROS ###########################################################################
#############################################################################################

# Requires CMake > 3.15
if(${CMAKE_VERSION} VERSION_LESS "3.15")
    message(FATAL_ERROR "The 'CMakeDeps' generator only works with CMake >= 3.15")
endif()

if(openh264_FIND_QUIETLY)
    set(openh264_MESSAGE_MODE VERBOSE)
else()
    set(openh264_MESSAGE_MODE STATUS)
endif()

include(${CMAKE_CURRENT_LIST_DIR}/cmakedeps_macros.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/openh264Targets.cmake)
include(CMakeFindDependencyMacro)

check_build_type_defined()

foreach(_DEPENDENCY ${openh264_FIND_DEPENDENCY_NAMES} )
    # Check that we have not already called a find_package with the transitive dependency
    if(NOT ${_DEPENDENCY}_FOUND)
        find_dependency(${_DEPENDENCY} REQUIRED ${${_DEPENDENCY}_FIND_MODE})
    endif()
endforeach()

set(openh264_VERSION_STRING "2.6.0")
set(openh264_INCLUDE_DIRS ${openh264_INCLUDE_DIRS_RELEASE} )
set(openh264_INCLUDE_DIR ${openh264_INCLUDE_DIRS_RELEASE} )
set(openh264_LIBRARIES ${openh264_LIBRARIES_RELEASE} )
set(openh264_DEFINITIONS ${openh264_DEFINITIONS_RELEASE} )


# Only the last installed configuration BUILD_MODULES are included to avoid the collision
foreach(_BUILD_MODULE ${openh264_BUILD_MODULES_PATHS_RELEASE} )
    message(${openh264_MESSAGE_MODE} "Conan: Including build module from '${_BUILD_MODULE}'")
    include(${_BUILD_MODULE})
endforeach()


