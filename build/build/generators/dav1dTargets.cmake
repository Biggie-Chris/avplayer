# Load the debug and release variables
file(GLOB DATA_FILES "${CMAKE_CURRENT_LIST_DIR}/dav1d-*-data.cmake")

foreach(f ${DATA_FILES})
    include(${f})
endforeach()

# Create the targets for all the components
foreach(_COMPONENT ${dav1d_COMPONENT_NAMES} )
    if(NOT TARGET ${_COMPONENT})
        add_library(${_COMPONENT} INTERFACE IMPORTED)
        message(${dav1d_MESSAGE_MODE} "Conan: Component target declared '${_COMPONENT}'")
    endif()
endforeach()

if(NOT TARGET dav1d::dav1d)
    add_library(dav1d::dav1d INTERFACE IMPORTED)
    message(${dav1d_MESSAGE_MODE} "Conan: Target declared 'dav1d::dav1d'")
endif()
# Load the debug and release library finders
file(GLOB CONFIG_FILES "${CMAKE_CURRENT_LIST_DIR}/dav1d-Target-*.cmake")

foreach(f ${CONFIG_FILES})
    include(${f})
endforeach()