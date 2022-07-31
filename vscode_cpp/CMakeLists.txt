cmake_minimum_required(VERSION 3.8)

if(CMAKE_GENERATOR MATCHES "Visual Studio ([0-9]*)")
    set(CMAKE_PREFIX_PATH "D:/SystemTools/vcpkg/installed/x64-windows-static-md")
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /EHsc /D_CRT_SECURE_NO_WARNINGS")
    message(STATUS "USING VISUAL STUDIO MAKEFILES")
    set(CMAKE_C_COMPILER "C:/Program Files/Microsoft Visual Studio/2022/Community/VC/Tools/MSVC/14.32.31326/bin/Hostx64/x64/cl.exe")
    set(CMAKE_CXX_COMPILER "C:/Program Files/Microsoft Visual Studio/2022/Community/VC/Tools/MSVC/14.32.31326/bin/Hostx64/x64/cl.exe")
elseif(CMAKE_GENERATOR MATCHES "MinGW Makefiles")
    set(CMAKE_PREFIX_PATH "D:/SystemTools/vcpkg/installed/x64-mingw-static")
    set(CMAKE_CXX_FLAGS_DEBUG "$ENV{CXXFLAGS} -O0 -g2 -ggdb -Wall")
    set(CMAKE_CXX_FLAGS_RELEASE "$ENV{CXXFLAGS} -O2 -DNDEBUG -Wall" )   # release包优化?
    message(STATUS "USING MINGW MAKEFILES")
    set(CMAKE_C_COMPILER "D:/SystemTools/llvm-mingw-20220323-msvcrt-x86_64/bin/clang.exe")
    set(CMAKE_CXX_COMPILER "D:/SystemTools/llvm-mingw-20220323-msvcrt-x86_64/bin/clang++.exe")
endif()
# show compile infomation
set(CMAKE_VERBOSE_MAKEFILEON ON)
# enable folder
set_property(GLOBAL PROPERTY USE_FOLDERS ON)
# set cpp standard
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_STANDARD 11)

set(CMAKE_EXPORT_COMPILE_COMMANDS True)         # 生成compile_commands.json 用于 intelliSense
set(CMAKE_INSTALL_PREFIX "${CMAKE_SOURCE_DIR}/build")

#set(CMAKE_BUILD_TYPE "Release")
set(CMAKE_BUILD_TYPE "Debug")

message(STATUS "CURRENT COMPILER IS ${CMAKE_CXX_COMPILER}")

set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY_DEBUG "${CMAKE_INSTALL_PREFIX}")
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY_RELEASE "${CMAKE_INSTALL_PREFIX}")
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY_DEBUG "${CMAKE_INSTALL_PREFIX}")
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY_RELEASE "${CMAKE_INSTALL_PREFIX}")
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_DEBUG "${CMAKE_INSTALL_PREFIX}")
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_RELEASE "${CMAKE_INSTALL_PREFIX}")

project(vendingmachine LANGUAGES CXX)
# Locate pthread
find_package(Threads REQUIRED)
# Locate Glog
find_package(glog REQUIRED)
# Locate WinSock
if(CMAKE_CXX_COMPILER_ID STREQUAL "MSVC")
    if(CMAKE_SIZEOF_VOID_P EQUAL 8) # 64 bits
        set(CMAKE_LIBRARY_PATH "C:/Program Files (x86)/Windows Kits/10/Lib/10.0.19041.0/um/x64")
    elseif(CMAKE_SIZEOF_VOID_P EQUAL 4) # 32 bits
        set(CMAKE_LIBRARY_PATH "C:/Program Files (x86)/Windows Kits/10/Lib/10.0.19041.0/um/x86")
    else()
        message(ERROR "NOT SUPPORT PLATFORM, MUST BE X64|X86")
    endif()
elseif(CMAKE_CXX_COMPILER_ID STREQUAL "Clang")
    set(CMAKE_LIBRARY_PATH "D:/SystemTools/llvm-mingw-20210816-msvcrt-x86_64/x86_64-w64-mingw32/lib/")
endif()
find_library(WSOCK32_LIBRARY wsock32)
find_library(WS2_32_LIBRARY ws2_32)
# Locate VisualLeakDectector
if(CMAKE_CXX_COMPILER_ID STREQUAL "MSVC")

    message(STATUS "SETTING VLD FOR MSVC")
    if(CMAKE_SIZEOF_VOID_P EQUAL 8) # 64 bits
        set(CMAKE_LIBRARY_PATH "C:/Program Files (x86)/Visual Leak Detector/lib/Win64/")
    elseif(CMAKE_SIZEOF_VOID_P EQUAL 4) # 32 bits
        set(CMAKE_LIBRARY_PATH "C:/Program Files (x86)/Visual Leak Detector/lib/Win32/")
    else()
        message(ERROR "NOT SUPPORT PLATFORM, MUST BE X64|X86")
    endif()
    set(VLD_INCLUDE_DIRECTORY "C:/Program Files (x86)/Visual Leak Detector/include/")
    find_library(VLD_LIBRARY vld PATHS ${CMAKE_LIBRARY_PATH})
elseif(CMAKE_CXX_COMPILER_ID STREQUAL "Clang")
    message(WARNING "VLD NOT SUPPORT PLATFORM, MUST BE MSVC")
endif()




function(get_all_targets _result _dir)
    get_property(_subdirs DIRECTORY "${_dir}" PROPERTY SUBDIRECTORIES)
    foreach(_subdir IN LISTS _subdirs)
        get_all_targets(${_result} "${_subdir}")
    endforeach()
    get_property(_sub_targets DIRECTORY "${_dir}" PROPERTY BUILDSYSTEM_TARGETS)
    message(STATUS "get_all_targets find targets ${_sub_targets}")
    set(${_result} ${${_result}} ${_sub_targets} PARENT_SCOPE)
endfunction()

function(add_subdirectory_with_folder _folder _folder_name)
    message(STATUS "add_subdirectory_with_folder ${_folder_name} ${_fodler}")
    add_subdirectory(${_folder} ${ARGN})
    get_all_targets(_targets "${_folder}")
    foreach(_target IN LISTS _targets)
        get_target_property(_target_folder ${_target} FOLDER)
        if(_target_folder)
            message(STATUS "${_target} FOLDER = ${_target_folder}")
            set_target_properties(${_target} PROPERTIES FOLDER "${_folder_name}/${_target_folder}")
        else()
            set(_target_folder "")
            message(STATUS "${_target} FOLDER = ${_target_folder}")
            set_target_properties(${_target} PROPERTIES FOLDER "${_folder_name}")
        endif()
        get_target_property(_target_folder ${_target} FOLDER)
        message(STATUS "setting ${_target} FOLDER = ${_target_folder}")
    endforeach()
endfunction()

# add_subdirectory(cppLearning)
# add_subdirectory_with_folder(cppLearning cppLearning)
# set_property ( DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR} PROPERTY VS_STARTUP_PROJECT ${PROJECT_NAME})

message(STATUS "CURRENT COMPILER IS ${CMAKE_CXX_COMPILER}")
# add_subdirectory_with_folder(ftpClient ftpClient)
message(STATUS "CURRENT COMPILER IS ${CMAKE_CXX_COMPILER}")


# get_all_targets(all_targets .)
# set_property(TARGET ${all_targets} PROPERTY VS_DEBUGGER_WORKING_DIRECTORY "${CMAKE_INSTALL_PREFIX}")

# ./cppLearning/ftpClient/CMakeList.txt

project(server LANGUAGES CXX)
add_executable(server ${CMAKE_CURRENT_SOURCE_DIR}/server.cpp)
# set_property(TARGET server PROPERTY VS_DEBUGGER_WORKING_DIRECTORY "${CMAKE_INSTALL_PREFIX}")
if(WIN32)
    target_link_libraries(server glog::glog ${WSOCK32_LIBRARY} ${WS2_32_LIBRARY})
else()
    target_link_libraries(server glog::glog)
endif()


project(client LANGUAGES CXX)
add_executable(client ${CMAKE_CURRENT_SOURCE_DIR}/client.cpp)
# set_property(TARGET client PROPERTY VS_DEBUGGER_WORKING_DIRECTORY "${CMAKE_INSTALL_PREFIX}")
if(WIN32)
    target_link_libraries(client glog::glog ${WSOCK32_LIBRARY} ${WS2_32_LIBRARY})
else()
    target_link_libraries(client glog::glog)
endif()


project(ftpClientInstance LANGUAGES CXX)
add_executable(${PROJECT_NAME} ${CMAKE_CURRENT_SOURCE_DIR}/ftpClientInstance.cpp)
if(WIN32)
    if(MSVC)
        set_property(TARGET ${PROJECT_NAME} PROPERTY VS_DEBUGGER_WORKING_DIRECTORY ${CMAKE_INSTALL_PREFIX})
        target_include_directories(${PROJECT_NAME} PRIVATE ${VLD_INCLUDE_DIRECTORY})
        target_link_libraries(${PROJECT_NAME} ${WSOCK32_LIBRARY} ${WS2_32_LIBRARY} glog::glog ${VLD_LIBRARY})
        target_compile_definitions(${PROJECT_NAME} PRIVATE _VLD_SUPPORT)
    else()
        target_link_libraries(${PROJECT_NAME} ${WSOCK32_LIBRARY} ${WS2_32_LIBRARY} glog::glog)
    endif()
endif()
# if(WIN32)
#     target_link_libraries(${PROJECT_NAME} glog::glog ${WSOCK32_LIBRARY} ${WS2_32_LIBRARY})
#     target_compile_options(${PROJECT_NAME} PRIVATE -fsanitize=address)
# else()
#     target_link_libraries(${PROJECT_NAME} glog::glog)
# endif()

if(0)
    file(COPY ${CMAKE_CURRENT_SOURCE_DIR}/srcFile.jpg DESTINATION ${CMAKE_INSTALL_PREFIX})
    file(COPY ${CMAKE_CURRENT_SOURCE_DIR}/serverFolder DESTINATION ${CMAKE_INSTALL_PREFIX})
    file(COPY ${CMAKE_CURRENT_SOURCE_DIR}/clientFolder DESTINATION ${CMAKE_INSTALL_PREFIX})
endif()