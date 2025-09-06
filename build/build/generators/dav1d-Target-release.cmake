# Avoid multiple calls to find_package to append duplicated properties to the targets
include_guard()########### VARIABLES #######################################################################
#############################################################################################
set(dav1d_FRAMEWORKS_FOUND_RELEASE "") # Will be filled later
conan_find_apple_frameworks(dav1d_FRAMEWORKS_FOUND_RELEASE "${dav1d_FRAMEWORKS_RELEASE}" "${dav1d_FRAMEWORK_DIRS_RELEASE}")

set(dav1d_LIBRARIES_TARGETS "") # Will be filled later


######## Create an interface target to contain all the dependencies (frameworks, system and conan deps)
if(NOT TARGET dav1d_DEPS_TARGET)
    add_library(dav1d_DEPS_TARGET INTERFACE IMPORTED)
endif()

set_property(TARGET dav1d_DEPS_TARGET
             APPEND PROPERTY INTERFACE_LINK_LIBRARIES
             $<$<CONFIG:Release>:${dav1d_FRAMEWORKS_FOUND_RELEASE}>
             $<$<CONFIG:Release>:${dav1d_SYSTEM_LIBS_RELEASE}>
             $<$<CONFIG:Release>:>)

####### Find the libraries declared in cpp_info.libs, create an IMPORTED target for each one and link the
####### dav1d_DEPS_TARGET to all of them
conan_package_library_targets("${dav1d_LIBS_RELEASE}"    # libraries
                              "${dav1d_LIB_DIRS_RELEASE}" # package_libdir
                              "${dav1d_BIN_DIRS_RELEASE}" # package_bindir
                              "${dav1d_LIBRARY_TYPE_RELEASE}"
                              "${dav1d_IS_HOST_WINDOWS_RELEASE}"
                              dav1d_DEPS_TARGET
                              dav1d_LIBRARIES_TARGETS  # out_libraries_targets
                              "_RELEASE"
                              "dav1d"    # package_name
                              "${dav1d_NO_SONAME_MODE_RELEASE}")  # soname

# FIXME: What is the result of this for multi-config? All configs adding themselves to path?
set(CMAKE_MODULE_PATH ${dav1d_BUILD_DIRS_RELEASE} ${CMAKE_MODULE_PATH})

########## GLOBAL TARGET PROPERTIES Release ########################################
    set_property(TARGET dav1d::dav1d
                 APPEND PROPERTY INTERFACE_LINK_LIBRARIES
                 $<$<CONFIG:Release>:${dav1d_OBJECTS_RELEASE}>
                 $<$<CONFIG:Release>:${dav1d_LIBRARIES_TARGETS}>
                 )

    if("${dav1d_LIBS_RELEASE}" STREQUAL "")
        # If the package is not declaring any "cpp_info.libs" the package deps, system libs,
        # frameworks etc are not linked to the imported targets and we need to do it to the
        # global target
        set_property(TARGET dav1d::dav1d
                     APPEND PROPERTY INTERFACE_LINK_LIBRARIES
                     dav1d_DEPS_TARGET)
    endif()

    set_property(TARGET dav1d::dav1d
                 APPEND PROPERTY INTERFACE_LINK_OPTIONS
                 $<$<CONFIG:Release>:${dav1d_LINKER_FLAGS_RELEASE}>)
    set_property(TARGET dav1d::dav1d
                 APPEND PROPERTY INTERFACE_INCLUDE_DIRECTORIES
                 $<$<CONFIG:Release>:${dav1d_INCLUDE_DIRS_RELEASE}>)
    # Necessary to find LINK shared libraries in Linux
    set_property(TARGET dav1d::dav1d
                 APPEND PROPERTY INTERFACE_LINK_DIRECTORIES
                 $<$<CONFIG:Release>:${dav1d_LIB_DIRS_RELEASE}>)
    set_property(TARGET dav1d::dav1d
                 APPEND PROPERTY INTERFACE_COMPILE_DEFINITIONS
                 $<$<CONFIG:Release>:${dav1d_COMPILE_DEFINITIONS_RELEASE}>)
    set_property(TARGET dav1d::dav1d
                 APPEND PROPERTY INTERFACE_COMPILE_OPTIONS
                 $<$<CONFIG:Release>:${dav1d_COMPILE_OPTIONS_RELEASE}>)

########## For the modules (FindXXX)
set(dav1d_LIBRARIES_RELEASE dav1d::dav1d)
