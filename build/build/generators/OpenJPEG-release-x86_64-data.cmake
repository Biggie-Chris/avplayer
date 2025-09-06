########### AGGREGATED COMPONENTS AND DEPENDENCIES FOR THE MULTI CONFIG #####################
#############################################################################################

set(openjpeg_COMPONENT_NAMES "")
if(DEFINED openjpeg_FIND_DEPENDENCY_NAMES)
  list(APPEND openjpeg_FIND_DEPENDENCY_NAMES )
  list(REMOVE_DUPLICATES openjpeg_FIND_DEPENDENCY_NAMES)
else()
  set(openjpeg_FIND_DEPENDENCY_NAMES )
endif()

########### VARIABLES #######################################################################
#############################################################################################
set(openjpeg_PACKAGE_FOLDER_RELEASE "C:/Users/69070/.conan2/p/openje7fb3d93f0bbc/p")
set(openjpeg_BUILD_MODULES_PATHS_RELEASE "${openjpeg_PACKAGE_FOLDER_RELEASE}/lib/cmake/conan-official-openjpeg-variables.cmake")


set(openjpeg_INCLUDE_DIRS_RELEASE )
set(openjpeg_RES_DIRS_RELEASE )
set(openjpeg_DEFINITIONS_RELEASE "-DOPJ_STATIC")
set(openjpeg_SHARED_LINK_FLAGS_RELEASE )
set(openjpeg_EXE_LINK_FLAGS_RELEASE )
set(openjpeg_OBJECTS_RELEASE )
set(openjpeg_COMPILE_DEFINITIONS_RELEASE "OPJ_STATIC")
set(openjpeg_COMPILE_OPTIONS_C_RELEASE )
set(openjpeg_COMPILE_OPTIONS_CXX_RELEASE )
set(openjpeg_LIB_DIRS_RELEASE "${openjpeg_PACKAGE_FOLDER_RELEASE}/lib")
set(openjpeg_BIN_DIRS_RELEASE )
set(openjpeg_LIBRARY_TYPE_RELEASE STATIC)
set(openjpeg_IS_HOST_WINDOWS_RELEASE 1)
set(openjpeg_LIBS_RELEASE openjp2)
set(openjpeg_SYSTEM_LIBS_RELEASE )
set(openjpeg_FRAMEWORK_DIRS_RELEASE )
set(openjpeg_FRAMEWORKS_RELEASE )
set(openjpeg_BUILD_DIRS_RELEASE "${openjpeg_PACKAGE_FOLDER_RELEASE}/lib/cmake")
set(openjpeg_NO_SONAME_MODE_RELEASE FALSE)


# COMPOUND VARIABLES
set(openjpeg_COMPILE_OPTIONS_RELEASE
    "$<$<COMPILE_LANGUAGE:CXX>:${openjpeg_COMPILE_OPTIONS_CXX_RELEASE}>"
    "$<$<COMPILE_LANGUAGE:C>:${openjpeg_COMPILE_OPTIONS_C_RELEASE}>")
set(openjpeg_LINKER_FLAGS_RELEASE
    "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${openjpeg_SHARED_LINK_FLAGS_RELEASE}>"
    "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${openjpeg_SHARED_LINK_FLAGS_RELEASE}>"
    "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${openjpeg_EXE_LINK_FLAGS_RELEASE}>")


set(openjpeg_COMPONENTS_RELEASE )