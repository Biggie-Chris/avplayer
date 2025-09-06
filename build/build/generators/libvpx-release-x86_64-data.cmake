########### AGGREGATED COMPONENTS AND DEPENDENCIES FOR THE MULTI CONFIG #####################
#############################################################################################

set(libvpx_COMPONENT_NAMES "")
if(DEFINED libvpx_FIND_DEPENDENCY_NAMES)
  list(APPEND libvpx_FIND_DEPENDENCY_NAMES )
  list(REMOVE_DUPLICATES libvpx_FIND_DEPENDENCY_NAMES)
else()
  set(libvpx_FIND_DEPENDENCY_NAMES )
endif()

########### VARIABLES #######################################################################
#############################################################################################
set(libvpx_PACKAGE_FOLDER_RELEASE "C:/Users/69070/.conan2/p/libvpfcd84689fe076/p")
set(libvpx_BUILD_MODULES_PATHS_RELEASE )


set(libvpx_INCLUDE_DIRS_RELEASE )
set(libvpx_RES_DIRS_RELEASE )
set(libvpx_DEFINITIONS_RELEASE )
set(libvpx_SHARED_LINK_FLAGS_RELEASE )
set(libvpx_EXE_LINK_FLAGS_RELEASE )
set(libvpx_OBJECTS_RELEASE )
set(libvpx_COMPILE_DEFINITIONS_RELEASE )
set(libvpx_COMPILE_OPTIONS_C_RELEASE )
set(libvpx_COMPILE_OPTIONS_CXX_RELEASE )
set(libvpx_LIB_DIRS_RELEASE "${libvpx_PACKAGE_FOLDER_RELEASE}/lib")
set(libvpx_BIN_DIRS_RELEASE )
set(libvpx_LIBRARY_TYPE_RELEASE STATIC)
set(libvpx_IS_HOST_WINDOWS_RELEASE 1)
set(libvpx_LIBS_RELEASE vpxmd)
set(libvpx_SYSTEM_LIBS_RELEASE )
set(libvpx_FRAMEWORK_DIRS_RELEASE )
set(libvpx_FRAMEWORKS_RELEASE )
set(libvpx_BUILD_DIRS_RELEASE )
set(libvpx_NO_SONAME_MODE_RELEASE FALSE)


# COMPOUND VARIABLES
set(libvpx_COMPILE_OPTIONS_RELEASE
    "$<$<COMPILE_LANGUAGE:CXX>:${libvpx_COMPILE_OPTIONS_CXX_RELEASE}>"
    "$<$<COMPILE_LANGUAGE:C>:${libvpx_COMPILE_OPTIONS_C_RELEASE}>")
set(libvpx_LINKER_FLAGS_RELEASE
    "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${libvpx_SHARED_LINK_FLAGS_RELEASE}>"
    "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${libvpx_SHARED_LINK_FLAGS_RELEASE}>"
    "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${libvpx_EXE_LINK_FLAGS_RELEASE}>")


set(libvpx_COMPONENTS_RELEASE )