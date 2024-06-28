cmake_minimum_required(VERSION 3.27)
project(Glitter)

# 查找预编译库
find_library(EXISTING_GLEW glfw3 PATHS Prebuilts/glfw-3.4.bin.WIN64/lib-mingw-w64/)

if(NOT EXISTING_GLEW)
    message(STATUS "Compiling library from source ${EXISTING_GLEW}")

    option(GLFW_BUILD_DOCS OFF)
    option(GLFW_BUILD_TESTS OFF)
    option(GLFW_BUILD_EXAMPLES OFF)
    add_subdirectory(Glitter/Vendor/glfw)
endif()

option(ASSIMP_BUILD_ASSIMP_TOOLS OFF)
option(ASSIMP_BUILD_SAMPLES OFF)
option(ASSIMP_BUILD_TESTS OFF)
option(ASSIMP_WARNINGS_AS_ERRORS OFF)
add_subdirectory(Glitter/Vendor/assimp)

option(BUILD_BULLET2_DEMOS OFF)
option(BUILD_CPU_DEMOS OFF)
option(BUILD_EXTRAS OFF)
option(BUILD_OPENGL3_DEMOS OFF)
option(BUILD_UNIT_TESTS OFF)
add_subdirectory(Glitter/Vendor/bullet)

if(MSVC)
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /W4")
else()
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wall -Wextra -Wpedantic -std=c++11")
    if(NOT WIN32)
        set(GLAD_LIBRARIES dl)
    endif()
endif()

include_directories(Glitter/Headers/
                    Glitter/Vendor/assimp/include/
                    Glitter/Vendor/bullet/src/
                    Glitter/Vendor/glad/include/
                    Glitter/Vendor/glfw/include/
                    Glitter/Vendor/glm/
                    Glitter/Vendor/stb/
                    Glitter/Utils/
                    Glitter/Vendor/imgui/
                    Glitter/Vendor/imgui/backends/
                )

file(GLOB VENDORS_SOURCES Glitter/Vendor/glad/src/glad.c)
file(GLOB PROJECT_HEADERS Glitter/Headers/*.hpp
                          Glitter/Headers/*.h)
file(GLOB PROJECT_SOURCES Glitter/Sources/*.cpp)
file(GLOB PROJECT_SHADERS Glitter/Shaders/*.comp
                          Glitter/Shaders/*.frag
                          Glitter/Shaders/*.geom
                          Glitter/Shaders/*.vert)
#   将收集Glitter/Shaders/目录下四种类型的着色器文件：
#   .comp（compute shader），
#   .frag（fragment shader），
#   .geom（geometry shader），
#   .vert（vertex shader）
file(GLOB PROJECT_CONFIGS CMakeLists.txt
                          Readme.md
                         .gitattributes
                         .gitignore
                         .gitmodules)
file(GLOB PROJECT_UTILS Glitter/Utils/*.cpp)
file(GLOB PROJECT_IMGUI Glitter/Vendor/imgui/backends/imgui_impl_glfw.cpp
                        Glitter/Vendor/imgui/backends/imgui_impl_opengl3.cpp
                        Glitter/Vendor/imgui/*.cpp
                        Glitter/Vendor/imgui/*.h)

source_group("Headers" FILES ${PROJECT_HEADERS})
source_group("Shaders" FILES ${PROJECT_SHADERS})
source_group("Sources" FILES ${PROJECT_SOURCES})
source_group("Vendors" FILES ${VENDORS_SOURCES})

add_definitions(-DGLFW_INCLUDE_NONE
                -DPROJECT_SOURCE_DIR=\"${PROJECT_SOURCE_DIR}\")

foreach(src ${PROJECT_SOURCES})
    get_filename_component(filename ${src} NAME_WE)
    add_executable(${filename} ${src}
                    ${PROJECT_HEADERS}
                    ${PROJECT_SHADERS}
                    ${PROJECT_CONFIGS}
                    ${VENDORS_SOURCES}
                    ${PROJECT_UTILS}
                    ${PROJECT_IMGUI})
    if(EXISTING_GLEW)
        target_link_libraries(${filename}
                            assimp
                            ${GLAD_LIBRARIES} 
                            BulletDynamics 
                            BulletCollision 
                            LinearMath 
                            ${EXISTING_GLEW})
    else()
        message(STATUS "Compiling library from source")
        target_link_libraries(${filename}
                                assimp
                                glfw ${GLFW_LIBRARIES} 
                                ${GLAD_LIBRARIES} 
                                BulletDynamics 
                                BulletCollision 
                                LinearMath)
    endif()
    
    set_target_properties(${filename} PROPERTIES
                          RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/out)
endforeach()

# copy resources to out directory
file(GLOB resource_files Glitter/Shaders/*.fs
                         Glitter/Shaders/*.vs
                         Glitter/Images/*.jpg
                         Glitter/Images/*.png)

file(COPY ${resource_files} DESTINATION ${CMAKE_CURRENT_BINARY_DIR}/out/resources/)