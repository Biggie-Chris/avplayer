# Load the debug and release variables
file(GLOB DATA_FILES "${CMAKE_CURRENT_LIST_DIR}/libvpx-*-data.cmake")

foreach(f ${DATA_FILES})
    include(${f})
endforeach()

# Create the targets for all the components
foreach(_COMPONENT ${libvpx_COMPONENT_NAMES} )
    if(NOT TARGET ${_COMPONENT})
        add_library(${_COMPONENT} INTERFACE IMPORTED)
        message(${libvpx_MESSAGE_MODE} "Conan: Component target declared '${_COMPONENT}'")
    endif()
endforeach()

if(NOT TARGET libvpx::libvpx)
    add_library(libvpx::libvpx INTERFACE IMPORTED)
    message(${libvpx_MESSAGE_MODE} "Conan: Target declared 'libvpx::libvpx'")
endif()
# Load the debug and release library finders
file(GLOB CONFIG_FILES "${CMAKE_CURRENT_LIST_DIR}/libvpx-Target-*.cmake")

foreach(f ${CONFIG_FILES})
    include(${f})
endforeach()