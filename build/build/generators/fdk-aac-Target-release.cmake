# Avoid multiple calls to find_package to append duplicated properties to the targets
include_guard()########### VARIABLES #######################################################################
#############################################################################################
set(libfdk_aac_FRAMEWORKS_FOUND_RELEASE "") # Will be filled later
conan_find_apple_frameworks(libfdk_aac_FRAMEWORKS_FOUND_RELEASE "${libfdk_aac_FRAMEWORKS_RELEASE}" "${libfdk_aac_FRAMEWORK_DIRS_RELEASE}")

set(libfdk_aac_LIBRARIES_TARGETS "") # Will be filled later


######## Create an interface target to contain all the dependencies (frameworks, system and conan deps)
if(NOT TARGET libfdk_aac_DEPS_TARGET)
    add_library(libfdk_aac_DEPS_TARGET INTERFACE IMPORTED)
endif()

set_property(TARGET libfdk_aac_DEPS_TARGET
             APPEND PROPERTY INTERFACE_LINK_LIBRARIES
             $<$<CONFIG:Release>:${libfdk_aac_FRAMEWORKS_FOUND_RELEASE}>
             $<$<CONFIG:Release>:${libfdk_aac_SYSTEM_LIBS_RELEASE}>
             $<$<CONFIG:Release>:>)

####### Find the libraries declared in cpp_info.libs, create an IMPORTED target for each one and link the
####### libfdk_aac_DEPS_TARGET to all of them
conan_package_library_targets("${libfdk_aac_LIBS_RELEASE}"    # libraries
                              "${libfdk_aac_LIB_DIRS_RELEASE}" # package_libdir
                              "${libfdk_aac_BIN_DIRS_RELEASE}" # package_bindir
                              "${libfdk_aac_LIBRARY_TYPE_RELEASE}"
                              "${libfdk_aac_IS_HOST_WINDOWS_RELEASE}"
                              libfdk_aac_DEPS_TARGET
                              libfdk_aac_LIBRARIES_TARGETS  # out_libraries_targets
                              "_RELEASE"
                              "libfdk_aac"    # package_name
                              "${libfdk_aac_NO_SONAME_MODE_RELEASE}")  # soname

# FIXME: What is the result of this for multi-config? All configs adding themselves to path?
set(CMAKE_MODULE_PATH ${libfdk_aac_BUILD_DIRS_RELEASE} ${CMAKE_MODULE_PATH})

########## COMPONENTS TARGET PROPERTIES Release ########################################

    ########## COMPONENT FDK-AAC::fdk-aac #############

        set(libfdk_aac_FDK-AAC_fdk-aac_FRAMEWORKS_FOUND_RELEASE "")
        conan_find_apple_frameworks(libfdk_aac_FDK-AAC_fdk-aac_FRAMEWORKS_FOUND_RELEASE "${libfdk_aac_FDK-AAC_fdk-aac_FRAMEWORKS_RELEASE}" "${libfdk_aac_FDK-AAC_fdk-aac_FRAMEWORK_DIRS_RELEASE}")

        set(libfdk_aac_FDK-AAC_fdk-aac_LIBRARIES_TARGETS "")

        ######## Create an interface target to contain all the dependencies (frameworks, system and conan deps)
        if(NOT TARGET libfdk_aac_FDK-AAC_fdk-aac_DEPS_TARGET)
            add_library(libfdk_aac_FDK-AAC_fdk-aac_DEPS_TARGET INTERFACE IMPORTED)
        endif()

        set_property(TARGET libfdk_aac_FDK-AAC_fdk-aac_DEPS_TARGET
                     APPEND PROPERTY INTERFACE_LINK_LIBRARIES
                     $<$<CONFIG:Release>:${libfdk_aac_FDK-AAC_fdk-aac_FRAMEWORKS_FOUND_RELEASE}>
                     $<$<CONFIG:Release>:${libfdk_aac_FDK-AAC_fdk-aac_SYSTEM_LIBS_RELEASE}>
                     $<$<CONFIG:Release>:${libfdk_aac_FDK-AAC_fdk-aac_DEPENDENCIES_RELEASE}>
                     )

        ####### Find the libraries declared in cpp_info.component["xxx"].libs,
        ####### create an IMPORTED target for each one and link the 'libfdk_aac_FDK-AAC_fdk-aac_DEPS_TARGET' to all of them
        conan_package_library_targets("${libfdk_aac_FDK-AAC_fdk-aac_LIBS_RELEASE}"
                              "${libfdk_aac_FDK-AAC_fdk-aac_LIB_DIRS_RELEASE}"
                              "${libfdk_aac_FDK-AAC_fdk-aac_BIN_DIRS_RELEASE}" # package_bindir
                              "${libfdk_aac_FDK-AAC_fdk-aac_LIBRARY_TYPE_RELEASE}"
                              "${libfdk_aac_FDK-AAC_fdk-aac_IS_HOST_WINDOWS_RELEASE}"
                              libfdk_aac_FDK-AAC_fdk-aac_DEPS_TARGET
                              libfdk_aac_FDK-AAC_fdk-aac_LIBRARIES_TARGETS
                              "_RELEASE"
                              "libfdk_aac_FDK-AAC_fdk-aac"
                              "${libfdk_aac_FDK-AAC_fdk-aac_NO_SONAME_MODE_RELEASE}")


        ########## TARGET PROPERTIES #####################################
        set_property(TARGET FDK-AAC::fdk-aac
                     APPEND PROPERTY INTERFACE_LINK_LIBRARIES
                     $<$<CONFIG:Release>:${libfdk_aac_FDK-AAC_fdk-aac_OBJECTS_RELEASE}>
                     $<$<CONFIG:Release>:${libfdk_aac_FDK-AAC_fdk-aac_LIBRARIES_TARGETS}>
                     )

        if("${libfdk_aac_FDK-AAC_fdk-aac_LIBS_RELEASE}" STREQUAL "")
            # If the component is not declaring any "cpp_info.components['foo'].libs" the system, frameworks etc are not
            # linked to the imported targets and we need to do it to the global target
            set_property(TARGET FDK-AAC::fdk-aac
                         APPEND PROPERTY INTERFACE_LINK_LIBRARIES
                         libfdk_aac_FDK-AAC_fdk-aac_DEPS_TARGET)
        endif()

        set_property(TARGET FDK-AAC::fdk-aac APPEND PROPERTY INTERFACE_LINK_OPTIONS
                     $<$<CONFIG:Release>:${libfdk_aac_FDK-AAC_fdk-aac_LINKER_FLAGS_RELEASE}>)
        set_property(TARGET FDK-AAC::fdk-aac APPEND PROPERTY INTERFACE_INCLUDE_DIRECTORIES
                     $<$<CONFIG:Release>:${libfdk_aac_FDK-AAC_fdk-aac_INCLUDE_DIRS_RELEASE}>)
        set_property(TARGET FDK-AAC::fdk-aac APPEND PROPERTY INTERFACE_LINK_DIRECTORIES
                     $<$<CONFIG:Release>:${libfdk_aac_FDK-AAC_fdk-aac_LIB_DIRS_RELEASE}>)
        set_property(TARGET FDK-AAC::fdk-aac APPEND PROPERTY INTERFACE_COMPILE_DEFINITIONS
                     $<$<CONFIG:Release>:${libfdk_aac_FDK-AAC_fdk-aac_COMPILE_DEFINITIONS_RELEASE}>)
        set_property(TARGET FDK-AAC::fdk-aac APPEND PROPERTY INTERFACE_COMPILE_OPTIONS
                     $<$<CONFIG:Release>:${libfdk_aac_FDK-AAC_fdk-aac_COMPILE_OPTIONS_RELEASE}>)


    ########## AGGREGATED GLOBAL TARGET WITH THE COMPONENTS #####################
    set_property(TARGET FDK-AAC::fdk-aac APPEND PROPERTY INTERFACE_LINK_LIBRARIES FDK-AAC::fdk-aac)

########## For the modules (FindXXX)
set(libfdk_aac_LIBRARIES_RELEASE FDK-AAC::fdk-aac)
