# Avoid multiple calls to find_package to append duplicated properties to the targets
include_guard()########### VARIABLES #######################################################################
#############################################################################################
set(libvpx_FRAMEWORKS_FOUND_RELEASE "") # Will be filled later
conan_find_apple_frameworks(libvpx_FRAMEWORKS_FOUND_RELEASE "${libvpx_FRAMEWORKS_RELEASE}" "${libvpx_FRAMEWORK_DIRS_RELEASE}")

set(libvpx_LIBRARIES_TARGETS "") # Will be filled later


######## Create an interface target to contain all the dependencies (frameworks, system and conan deps)
if(NOT TARGET libvpx_DEPS_TARGET)
    add_library(libvpx_DEPS_TARGET INTERFACE IMPORTED)
endif()

set_property(TARGET libvpx_DEPS_TARGET
             APPEND PROPERTY INTERFACE_LINK_LIBRARIES
             $<$<CONFIG:Release>:${libvpx_FRAMEWORKS_FOUND_RELEASE}>
             $<$<CONFIG:Release>:${libvpx_SYSTEM_LIBS_RELEASE}>
             $<$<CONFIG:Release>:>)

####### Find the libraries declared in cpp_info.libs, create an IMPORTED target for each one and link the
####### libvpx_DEPS_TARGET to all of them
conan_package_library_targets("${libvpx_LIBS_RELEASE}"    # libraries
                              "${libvpx_LIB_DIRS_RELEASE}" # package_libdir
                              "${libvpx_BIN_DIRS_RELEASE}" # package_bindir
                              "${libvpx_LIBRARY_TYPE_RELEASE}"
                              "${libvpx_IS_HOST_WINDOWS_RELEASE}"
                              libvpx_DEPS_TARGET
                              libvpx_LIBRARIES_TARGETS  # out_libraries_targets
                              "_RELEASE"
                              "libvpx"    # package_name
                              "${libvpx_NO_SONAME_MODE_RELEASE}")  # soname

# FIXME: What is the result of this for multi-config? All configs adding themselves to path?
set(CMAKE_MODULE_PATH ${libvpx_BUILD_DIRS_RELEASE} ${CMAKE_MODULE_PATH})

########## GLOBAL TARGET PROPERTIES Release ########################################
    set_property(TARGET libvpx::libvpx
                 APPEND PROPERTY INTERFACE_LINK_LIBRARIES
                 $<$<CONFIG:Release>:${libvpx_OBJECTS_RELEASE}>
                 $<$<CONFIG:Release>:${libvpx_LIBRARIES_TARGETS}>
                 )

    if("${libvpx_LIBS_RELEASE}" STREQUAL "")
        # If the package is not declaring any "cpp_info.libs" the package deps, system libs,
        # frameworks etc are not linked to the imported targets and we need to do it to the
        # global target
        set_property(TARGET libvpx::libvpx
                     APPEND PROPERTY INTERFACE_LINK_LIBRARIES
                     libvpx_DEPS_TARGET)
    endif()

    set_property(TARGET libvpx::libvpx
                 APPEND PROPERTY INTERFACE_LINK_OPTIONS
                 $<$<CONFIG:Release>:${libvpx_LINKER_FLAGS_RELEASE}>)
    set_property(TARGET libvpx::libvpx
                 APPEND PROPERTY INTERFACE_INCLUDE_DIRECTORIES
                 $<$<CONFIG:Release>:${libvpx_INCLUDE_DIRS_RELEASE}>)
    # Necessary to find LINK shared libraries in Linux
    set_property(TARGET libvpx::libvpx
                 APPEND PROPERTY INTERFACE_LINK_DIRECTORIES
                 $<$<CONFIG:Release>:${libvpx_LIB_DIRS_RELEASE}>)
    set_property(TARGET libvpx::libvpx
                 APPEND PROPERTY INTERFACE_COMPILE_DEFINITIONS
                 $<$<CONFIG:Release>:${libvpx_COMPILE_DEFINITIONS_RELEASE}>)
    set_property(TARGET libvpx::libvpx
                 APPEND PROPERTY INTERFACE_COMPILE_OPTIONS
                 $<$<CONFIG:Release>:${libvpx_COMPILE_OPTIONS_RELEASE}>)

########## For the modules (FindXXX)
set(libvpx_LIBRARIES_RELEASE libvpx::libvpx)
