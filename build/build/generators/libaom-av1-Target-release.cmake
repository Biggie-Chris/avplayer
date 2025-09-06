# Avoid multiple calls to find_package to append duplicated properties to the targets
include_guard()########### VARIABLES #######################################################################
#############################################################################################
set(libaom-av1_FRAMEWORKS_FOUND_RELEASE "") # Will be filled later
conan_find_apple_frameworks(libaom-av1_FRAMEWORKS_FOUND_RELEASE "${libaom-av1_FRAMEWORKS_RELEASE}" "${libaom-av1_FRAMEWORK_DIRS_RELEASE}")

set(libaom-av1_LIBRARIES_TARGETS "") # Will be filled later


######## Create an interface target to contain all the dependencies (frameworks, system and conan deps)
if(NOT TARGET libaom-av1_DEPS_TARGET)
    add_library(libaom-av1_DEPS_TARGET INTERFACE IMPORTED)
endif()

set_property(TARGET libaom-av1_DEPS_TARGET
             APPEND PROPERTY INTERFACE_LINK_LIBRARIES
             $<$<CONFIG:Release>:${libaom-av1_FRAMEWORKS_FOUND_RELEASE}>
             $<$<CONFIG:Release>:${libaom-av1_SYSTEM_LIBS_RELEASE}>
             $<$<CONFIG:Release>:>)

####### Find the libraries declared in cpp_info.libs, create an IMPORTED target for each one and link the
####### libaom-av1_DEPS_TARGET to all of them
conan_package_library_targets("${libaom-av1_LIBS_RELEASE}"    # libraries
                              "${libaom-av1_LIB_DIRS_RELEASE}" # package_libdir
                              "${libaom-av1_BIN_DIRS_RELEASE}" # package_bindir
                              "${libaom-av1_LIBRARY_TYPE_RELEASE}"
                              "${libaom-av1_IS_HOST_WINDOWS_RELEASE}"
                              libaom-av1_DEPS_TARGET
                              libaom-av1_LIBRARIES_TARGETS  # out_libraries_targets
                              "_RELEASE"
                              "libaom-av1"    # package_name
                              "${libaom-av1_NO_SONAME_MODE_RELEASE}")  # soname

# FIXME: What is the result of this for multi-config? All configs adding themselves to path?
set(CMAKE_MODULE_PATH ${libaom-av1_BUILD_DIRS_RELEASE} ${CMAKE_MODULE_PATH})

########## GLOBAL TARGET PROPERTIES Release ########################################
    set_property(TARGET libaom-av1::libaom-av1
                 APPEND PROPERTY INTERFACE_LINK_LIBRARIES
                 $<$<CONFIG:Release>:${libaom-av1_OBJECTS_RELEASE}>
                 $<$<CONFIG:Release>:${libaom-av1_LIBRARIES_TARGETS}>
                 )

    if("${libaom-av1_LIBS_RELEASE}" STREQUAL "")
        # If the package is not declaring any "cpp_info.libs" the package deps, system libs,
        # frameworks etc are not linked to the imported targets and we need to do it to the
        # global target
        set_property(TARGET libaom-av1::libaom-av1
                     APPEND PROPERTY INTERFACE_LINK_LIBRARIES
                     libaom-av1_DEPS_TARGET)
    endif()

    set_property(TARGET libaom-av1::libaom-av1
                 APPEND PROPERTY INTERFACE_LINK_OPTIONS
                 $<$<CONFIG:Release>:${libaom-av1_LINKER_FLAGS_RELEASE}>)
    set_property(TARGET libaom-av1::libaom-av1
                 APPEND PROPERTY INTERFACE_INCLUDE_DIRECTORIES
                 $<$<CONFIG:Release>:${libaom-av1_INCLUDE_DIRS_RELEASE}>)
    # Necessary to find LINK shared libraries in Linux
    set_property(TARGET libaom-av1::libaom-av1
                 APPEND PROPERTY INTERFACE_LINK_DIRECTORIES
                 $<$<CONFIG:Release>:${libaom-av1_LIB_DIRS_RELEASE}>)
    set_property(TARGET libaom-av1::libaom-av1
                 APPEND PROPERTY INTERFACE_COMPILE_DEFINITIONS
                 $<$<CONFIG:Release>:${libaom-av1_COMPILE_DEFINITIONS_RELEASE}>)
    set_property(TARGET libaom-av1::libaom-av1
                 APPEND PROPERTY INTERFACE_COMPILE_OPTIONS
                 $<$<CONFIG:Release>:${libaom-av1_COMPILE_OPTIONS_RELEASE}>)

########## For the modules (FindXXX)
set(libaom-av1_LIBRARIES_RELEASE libaom-av1::libaom-av1)
