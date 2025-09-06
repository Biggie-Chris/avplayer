# Avoid multiple calls to find_package to append duplicated properties to the targets
include_guard()########### VARIABLES #######################################################################
#############################################################################################
set(libx265_FRAMEWORKS_FOUND_RELEASE "") # Will be filled later
conan_find_apple_frameworks(libx265_FRAMEWORKS_FOUND_RELEASE "${libx265_FRAMEWORKS_RELEASE}" "${libx265_FRAMEWORK_DIRS_RELEASE}")

set(libx265_LIBRARIES_TARGETS "") # Will be filled later


######## Create an interface target to contain all the dependencies (frameworks, system and conan deps)
if(NOT TARGET libx265_DEPS_TARGET)
    add_library(libx265_DEPS_TARGET INTERFACE IMPORTED)
endif()

set_property(TARGET libx265_DEPS_TARGET
             APPEND PROPERTY INTERFACE_LINK_LIBRARIES
             $<$<CONFIG:Release>:${libx265_FRAMEWORKS_FOUND_RELEASE}>
             $<$<CONFIG:Release>:${libx265_SYSTEM_LIBS_RELEASE}>
             $<$<CONFIG:Release>:>)

####### Find the libraries declared in cpp_info.libs, create an IMPORTED target for each one and link the
####### libx265_DEPS_TARGET to all of them
conan_package_library_targets("${libx265_LIBS_RELEASE}"    # libraries
                              "${libx265_LIB_DIRS_RELEASE}" # package_libdir
                              "${libx265_BIN_DIRS_RELEASE}" # package_bindir
                              "${libx265_LIBRARY_TYPE_RELEASE}"
                              "${libx265_IS_HOST_WINDOWS_RELEASE}"
                              libx265_DEPS_TARGET
                              libx265_LIBRARIES_TARGETS  # out_libraries_targets
                              "_RELEASE"
                              "libx265"    # package_name
                              "${libx265_NO_SONAME_MODE_RELEASE}")  # soname

# FIXME: What is the result of this for multi-config? All configs adding themselves to path?
set(CMAKE_MODULE_PATH ${libx265_BUILD_DIRS_RELEASE} ${CMAKE_MODULE_PATH})

########## GLOBAL TARGET PROPERTIES Release ########################################
    set_property(TARGET libx265::libx265
                 APPEND PROPERTY INTERFACE_LINK_LIBRARIES
                 $<$<CONFIG:Release>:${libx265_OBJECTS_RELEASE}>
                 $<$<CONFIG:Release>:${libx265_LIBRARIES_TARGETS}>
                 )

    if("${libx265_LIBS_RELEASE}" STREQUAL "")
        # If the package is not declaring any "cpp_info.libs" the package deps, system libs,
        # frameworks etc are not linked to the imported targets and we need to do it to the
        # global target
        set_property(TARGET libx265::libx265
                     APPEND PROPERTY INTERFACE_LINK_LIBRARIES
                     libx265_DEPS_TARGET)
    endif()

    set_property(TARGET libx265::libx265
                 APPEND PROPERTY INTERFACE_LINK_OPTIONS
                 $<$<CONFIG:Release>:${libx265_LINKER_FLAGS_RELEASE}>)
    set_property(TARGET libx265::libx265
                 APPEND PROPERTY INTERFACE_INCLUDE_DIRECTORIES
                 $<$<CONFIG:Release>:${libx265_INCLUDE_DIRS_RELEASE}>)
    # Necessary to find LINK shared libraries in Linux
    set_property(TARGET libx265::libx265
                 APPEND PROPERTY INTERFACE_LINK_DIRECTORIES
                 $<$<CONFIG:Release>:${libx265_LIB_DIRS_RELEASE}>)
    set_property(TARGET libx265::libx265
                 APPEND PROPERTY INTERFACE_COMPILE_DEFINITIONS
                 $<$<CONFIG:Release>:${libx265_COMPILE_DEFINITIONS_RELEASE}>)
    set_property(TARGET libx265::libx265
                 APPEND PROPERTY INTERFACE_COMPILE_OPTIONS
                 $<$<CONFIG:Release>:${libx265_COMPILE_OPTIONS_RELEASE}>)

########## For the modules (FindXXX)
set(libx265_LIBRARIES_RELEASE libx265::libx265)
