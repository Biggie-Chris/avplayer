########### AGGREGATED COMPONENTS AND DEPENDENCIES FOR THE MULTI CONFIG #####################
#############################################################################################

set(libaom-av1_COMPONENT_NAMES "")
if(DEFINED libaom-av1_FIND_DEPENDENCY_NAMES)
  list(APPEND libaom-av1_FIND_DEPENDENCY_NAMES )
  list(REMOVE_DUPLICATES libaom-av1_FIND_DEPENDENCY_NAMES)
else()
  set(libaom-av1_FIND_DEPENDENCY_NAMES )
endif()

########### VARIABLES #######################################################################
#############################################################################################
set(libaom-av1_PACKAGE_FOLDER_RELEASE "C:/Users/69070/.conan2/p/libao5a109c175bbd2/p")
set(libaom-av1_BUILD_MODULES_PATHS_RELEASE )


set(libaom-av1_INCLUDE_DIRS_RELEASE )
set(libaom-av1_RES_DIRS_RELEASE )
set(libaom-av1_DEFINITIONS_RELEASE )
set(libaom-av1_SHARED_LINK_FLAGS_RELEASE )
set(libaom-av1_EXE_LINK_FLAGS_RELEASE )
set(libaom-av1_OBJECTS_RELEASE )
set(libaom-av1_COMPILE_DEFINITIONS_RELEASE )
set(libaom-av1_COMPILE_OPTIONS_C_RELEASE )
set(libaom-av1_COMPILE_OPTIONS_CXX_RELEASE )
set(libaom-av1_LIB_DIRS_RELEASE "${libaom-av1_PACKAGE_FOLDER_RELEASE}/lib")
set(libaom-av1_BIN_DIRS_RELEASE )
set(libaom-av1_LIBRARY_TYPE_RELEASE STATIC)
set(libaom-av1_IS_HOST_WINDOWS_RELEASE 1)
set(libaom-av1_LIBS_RELEASE aom)
set(libaom-av1_SYSTEM_LIBS_RELEASE )
set(libaom-av1_FRAMEWORK_DIRS_RELEASE )
set(libaom-av1_FRAMEWORKS_RELEASE )
set(libaom-av1_BUILD_DIRS_RELEASE )
set(libaom-av1_NO_SONAME_MODE_RELEASE FALSE)


# COMPOUND VARIABLES
set(libaom-av1_COMPILE_OPTIONS_RELEASE
    "$<$<COMPILE_LANGUAGE:CXX>:${libaom-av1_COMPILE_OPTIONS_CXX_RELEASE}>"
    "$<$<COMPILE_LANGUAGE:C>:${libaom-av1_COMPILE_OPTIONS_C_RELEASE}>")
set(libaom-av1_LINKER_FLAGS_RELEASE
    "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${libaom-av1_SHARED_LINK_FLAGS_RELEASE}>"
    "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${libaom-av1_SHARED_LINK_FLAGS_RELEASE}>"
    "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${libaom-av1_EXE_LINK_FLAGS_RELEASE}>")


set(libaom-av1_COMPONENTS_RELEASE )