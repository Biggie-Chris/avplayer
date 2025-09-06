# Avoid multiple calls to find_package to append duplicated properties to the targets
include_guard()########### VARIABLES #######################################################################
#############################################################################################
set(openh264_FRAMEWORKS_FOUND_RELEASE "") # Will be filled later
conan_find_apple_frameworks(openh264_FRAMEWORKS_FOUND_RELEASE "${openh264_FRAMEWORKS_RELEASE}" "${openh264_FRAMEWORK_DIRS_RELEASE}")

set(openh264_LIBRARIES_TARGETS "") # Will be filled later


######## Create an interface target to contain all the dependencies (frameworks, system and conan deps)
if(NOT TARGET openh264_DEPS_TARGET)
    add_library(openh264_DEPS_TARGET INTERFACE IMPORTED)
endif()

set_property(TARGET openh264_DEPS_TARGET
             APPEND PROPERTY INTERFACE_LINK_LIBRARIES
             $<$<CONFIG:Release>:${openh264_FRAMEWORKS_FOUND_RELEASE}>
             $<$<CONFIG:Release>:${openh264_SYSTEM_LIBS_RELEASE}>
             $<$<CONFIG:Release>:>)

####### Find the libraries declared in cpp_info.libs, create an IMPORTED target for each one and link the
####### openh264_DEPS_TARGET to all of them
conan_package_library_targets("${openh264_LIBS_RELEASE}"    # libraries
                              "${openh264_LIB_DIRS_RELEASE}" # package_libdir
                              "${openh264_BIN_DIRS_RELEASE}" # package_bindir
                              "${openh264_LIBRARY_TYPE_RELEASE}"
                              "${openh264_IS_HOST_WINDOWS_RELEASE}"
                              openh264_DEPS_TARGET
                              openh264_LIBRARIES_TARGETS  # out_libraries_targets
                              "_RELEASE"
                              "openh264"    # package_name
                              "${openh264_NO_SONAME_MODE_RELEASE}")  # soname

# FIXME: What is the result of this for multi-config? All configs adding themselves to path?
set(CMAKE_MODULE_PATH ${openh264_BUILD_DIRS_RELEASE} ${CMAKE_MODULE_PATH})

########## GLOBAL TARGET PROPERTIES Release ########################################
    set_property(TARGET openh264::openh264
                 APPEND PROPERTY INTERFACE_LINK_LIBRARIES
                 $<$<CONFIG:Release>:${openh264_OBJECTS_RELEASE}>
                 $<$<CONFIG:Release>:${openh264_LIBRARIES_TARGETS}>
                 )

    if("${openh264_LIBS_RELEASE}" STREQUAL "")
        # If the package is not declaring any "cpp_info.libs" the package deps, system libs,
        # frameworks etc are not linked to the imported targets and we need to do it to the
        # global target
        set_property(TARGET openh264::openh264
                     APPEND PROPERTY INTERFACE_LINK_LIBRARIES
                     openh264_DEPS_TARGET)
    endif()

    set_property(TARGET openh264::openh264
                 APPEND PROPERTY INTERFACE_LINK_OPTIONS
                 $<$<CONFIG:Release>:${openh264_LINKER_FLAGS_RELEASE}>)
    set_property(TARGET openh264::openh264
                 APPEND PROPERTY INTERFACE_INCLUDE_DIRECTORIES
                 $<$<CONFIG:Release>:${openh264_INCLUDE_DIRS_RELEASE}>)
    # Necessary to find LINK shared libraries in Linux
    set_property(TARGET openh264::openh264
                 APPEND PROPERTY INTERFACE_LINK_DIRECTORIES
                 $<$<CONFIG:Release>:${openh264_LIB_DIRS_RELEASE}>)
    set_property(TARGET openh264::openh264
                 APPEND PROPERTY INTERFACE_COMPILE_DEFINITIONS
                 $<$<CONFIG:Release>:${openh264_COMPILE_DEFINITIONS_RELEASE}>)
    set_property(TARGET openh264::openh264
                 APPEND PROPERTY INTERFACE_COMPILE_OPTIONS
                 $<$<CONFIG:Release>:${openh264_COMPILE_OPTIONS_RELEASE}>)

########## For the modules (FindXXX)
set(openh264_LIBRARIES_RELEASE openh264::openh264)
