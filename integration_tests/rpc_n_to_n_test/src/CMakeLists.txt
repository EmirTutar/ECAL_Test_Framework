cmake_minimum_required(VERSION 3.10)
project(rpc_n_to_n_test)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(eCAL REQUIRED)

# Optional: EcalConfigHelper library
if(NOT DEFINED ECALCONFIGHELPER_PATH)
  set(ECALCONFIGHELPER_PATH ${CMAKE_CURRENT_LIST_DIR}/../../lib/EcalConfigHelper)
else()
  add_subdirectory(${ECALCONFIGHELPER_PATH} ${CMAKE_BINARY_DIR}/EcalConfigHelper)
endif()

# Build RPC Server
add_executable(rpc_n_to_n_server rpc_n_to_n_server.cpp)
target_include_directories(rpc_n_to_n_server PRIVATE ${CMAKE_CURRENT_SOURCE_DIR})
target_link_libraries(rpc_n_to_n_server PRIVATE EcalConfigHelper eCAL::core)

# Build RPC Client
add_executable(rpc_n_to_n_client rpc_n_to_n_client.cpp)
target_include_directories(rpc_n_to_n_client PRIVATE ${CMAKE_CURRENT_SOURCE_DIR})
target_link_libraries(rpc_n_to_n_client PRIVATE EcalConfigHelper eCAL::core)
