cmake_minimum_required(VERSION 3.16)

set(PLUGIN_NAME uq-plugin-example)
set(PLUGIN_VERSION_MAJOR 1)
set(PLUGIN_VERSION_MINOR 0)
set(PLUGIN_VERSION "${PLUGIN_VERSION_MAJOR}.${PLUGIN_VERSION_MINOR}")
set(TARGET ${PLUGIN_NAME}${PLUGIN_VERSION_MAJOR})


project(${PLUGIN_NAME} LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOUIC ON)

find_package(Qt6 6.0 REQUIRED COMPONENTS Core Qml Quick)

qt_standard_project_setup()

add_library(${PLUGIN_NAME} MODULE
    Plugin.h
    Plugin.cpp
    Backend.h
    Backend.cpp
)

target_include_directories(${PLUGIN_NAME}
    PRIVATE
        ${CMAKE_CURRENT_SOURCE_DIR}
)

target_link_libraries(${PLUGIN_NAME}
    PRIVATE
        Qt6::Core
        Qt6::Qml
        Qt6::Quick
)

qt6_add_qml_module(${PLUGIN_NAME}
    URI org.uq.pluginexample
    OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/org/uq/pluginexample"
    VERSION ${PLUGIN_VERSION}
    QML_FILES Plugin.qml PluginOptions.qml
    RESOURCE_PREFIX "/uq/pluginexample/kit" 
    RESOURCES plugin-info.json 
    NO_PLUGIN
)

set_target_properties(${PLUGIN_NAME} PROPERTIES
    LIBRARY_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/bin/"
    RUNTIME_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/bin/"
    PREFIX ""
)