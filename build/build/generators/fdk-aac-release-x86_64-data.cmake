########### AGGREGATED COMPONENTS AND DEPENDENCIES FOR THE MULTI CONFIG #####################
#############################################################################################

list(APPEND libfdk_aac_COMPONENT_NAMES FDK-AAC::fdk-aac)
list(REMOVE_DUPLICATES libfdk_aac_COMPONENT_NAMES)
if(DEFINED libfdk_aac_FIND_DEPENDENCY_NAMES)
  list(APPEND libfdk_aac_FIND_DEPENDENCY_NAMES )
  list(REMOVE_DUPLICATES libfdk_aac_FIND_DEPENDENCY_NAMES)
else()
  set(libfdk_aac_FIND_DEPENDENCY_NAMES )
endif()

########### VARIABLES #######################################################################
#############################################################################################
set(libfdk_aac_PACKAGE_FOLDER_RELEASE "C:/Users/69070/.conan2/p/libfd615fcaf5b2b15/p")
set(libfdk_aac_BUILD_MODULES_PATHS_RELEASE )


set(libfdk_aac_INCLUDE_DIRS_RELEASE )
set(libfdk_aac_RES_DIRS_RELEASE )
set(libfdk_aac_DEFINITIONS_RELEASE )
set(libfdk_aac_SHARED_LINK_FLAGS_RELEASE )
set(libfdk_aac_EXE_LINK_FLAGS_RELEASE )
set(libfdk_aac_OBJECTS_RELEASE )
set(libfdk_aac_COMPILE_DEFINITIONS_RELEASE )
set(libfdk_aac_COMPILE_OPTIONS_C_RELEASE )
set(libfdk_aac_COMPILE_OPTIONS_CXX_RELEASE )
set(libfdk_aac_LIB_DIRS_RELEASE "${libfdk_aac_PACKAGE_FOLDER_RELEASE}/lib")
set(libfdk_aac_BIN_DIRS_RELEASE )
set(libfdk_aac_LIBRARY_TYPE_RELEASE STATIC)
set(libfdk_aac_IS_HOST_WINDOWS_RELEASE 1)
set(libfdk_aac_LIBS_RELEASE fdk-aac)
set(libfdk_aac_SYSTEM_LIBS_RELEASE )
set(libfdk_aac_FRAMEWORK_DIRS_RELEASE )
set(libfdk_aac_FRAMEWORKS_RELEASE )
set(libfdk_aac_BUILD_DIRS_RELEASE )
set(libfdk_aac_NO_SONAME_MODE_RELEASE FALSE)


# COMPOUND VARIABLES
set(libfdk_aac_COMPILE_OPTIONS_RELEASE
    "$<$<COMPILE_LANGUAGE:CXX>:${libfdk_aac_COMPILE_OPTIONS_CXX_RELEASE}>"
    "$<$<COMPILE_LANGUAGE:C>:${libfdk_aac_COMPILE_OPTIONS_C_RELEASE}>")
set(libfdk_aac_LINKER_FLAGS_RELEASE
    "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${libfdk_aac_SHARED_LINK_FLAGS_RELEASE}>"
    "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${libfdk_aac_SHARED_LINK_FLAGS_RELEASE}>"
    "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${libfdk_aac_EXE_LINK_FLAGS_RELEASE}>")


set(libfdk_aac_COMPONENTS_RELEASE FDK-AAC::fdk-aac)
########### COMPONENT FDK-AAC::fdk-aac VARIABLES ############################################

set(libfdk_aac_FDK-AAC_fdk-aac_INCLUDE_DIRS_RELEASE )
set(libfdk_aac_FDK-AAC_fdk-aac_LIB_DIRS_RELEASE "${libfdk_aac_PACKAGE_FOLDER_RELEASE}/lib")
set(libfdk_aac_FDK-AAC_fdk-aac_BIN_DIRS_RELEASE )
set(libfdk_aac_FDK-AAC_fdk-aac_LIBRARY_TYPE_RELEASE STATIC)
set(libfdk_aac_FDK-AAC_fdk-aac_IS_HOST_WINDOWS_RELEASE 1)
set(libfdk_aac_FDK-AAC_fdk-aac_RES_DIRS_RELEASE )
set(libfdk_aac_FDK-AAC_fdk-aac_DEFINITIONS_RELEASE )
set(libfdk_aac_FDK-AAC_fdk-aac_OBJECTS_RELEASE )
set(libfdk_aac_FDK-AAC_fdk-aac_COMPILE_DEFINITIONS_RELEASE )
set(libfdk_aac_FDK-AAC_fdk-aac_COMPILE_OPTIONS_C_RELEASE "")
set(libfdk_aac_FDK-AAC_fdk-aac_COMPILE_OPTIONS_CXX_RELEASE "")
set(libfdk_aac_FDK-AAC_fdk-aac_LIBS_RELEASE fdk-aac)
set(libfdk_aac_FDK-AAC_fdk-aac_SYSTEM_LIBS_RELEASE )
set(libfdk_aac_FDK-AAC_fdk-aac_FRAMEWORK_DIRS_RELEASE )
set(libfdk_aac_FDK-AAC_fdk-aac_FRAMEWORKS_RELEASE )
set(libfdk_aac_FDK-AAC_fdk-aac_DEPENDENCIES_RELEASE )
set(libfdk_aac_FDK-AAC_fdk-aac_SHARED_LINK_FLAGS_RELEASE )
set(libfdk_aac_FDK-AAC_fdk-aac_EXE_LINK_FLAGS_RELEASE )
set(libfdk_aac_FDK-AAC_fdk-aac_NO_SONAME_MODE_RELEASE FALSE)

# COMPOUND VARIABLES
set(libfdk_aac_FDK-AAC_fdk-aac_LINKER_FLAGS_RELEASE
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${libfdk_aac_FDK-AAC_fdk-aac_SHARED_LINK_FLAGS_RELEASE}>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${libfdk_aac_FDK-AAC_fdk-aac_SHARED_LINK_FLAGS_RELEASE}>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${libfdk_aac_FDK-AAC_fdk-aac_EXE_LINK_FLAGS_RELEASE}>
)
set(libfdk_aac_FDK-AAC_fdk-aac_COMPILE_OPTIONS_RELEASE
    "$<$<COMPILE_LANGUAGE:CXX>:${libfdk_aac_FDK-AAC_fdk-aac_COMPILE_OPTIONS_CXX_RELEASE}>"
    "$<$<COMPILE_LANGUAGE:C>:${libfdk_aac_FDK-AAC_fdk-aac_COMPILE_OPTIONS_C_RELEASE}>")