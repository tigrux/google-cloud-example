cmake_minimum_required(VERSION 3.24)
project(google-cloud-example)

include(FetchContent)
set(FETCHCONTENT_QUIET OFF)

set(BUILD_SHARED_LIBS OFF)
set(BUILD_TESTING OFF)

find_package(Threads REQUIRED)

FetchContent_Declare(
    absl
    URL https://github.com/abseil/abseil-cpp/archive/refs/tags/20240116.2.tar.gz
    URL_HASH SHA256=733726b8c3a6d39a4120d7e45ea8b41a434cdacde401cba500f14236c49b39dc
    OVERRIDE_FIND_PACKAGE
    EXCLUDE_FROM_ALL)
set(ABSL_BUILD_TESTING OFF)
set(ABSL_PROPAGATE_CXX_STD ON)
set(ABSL_ENABLE_INSTALL ON)
FetchContent_MakeAvailable(absl)

FetchContent_Declare(
    protobuf
    URL https://github.com/protocolbuffers/protobuf/archive/v26.1.tar.gz
    URL_HASH SHA256=4fc5ff1b2c339fb86cd3a25f0b5311478ab081e65ad258c6789359cd84d421f8
    OVERRIDE_FIND_PACKAGE
    EXCLUDE_FROM_ALL)
set(protobuf_BUILD_TESTS OFF)
set(protobuf_ABSL_PROVIDER "package")
set(PROTO_INCLUDE_DIR ${protobuf_SOURCE_DIR}/src)
FetchContent_MakeAvailable(protobuf)
add_executable(protobuf::protoc ALIAS protoc)

FetchContent_Declare(
    gRPC
    URL https://github.com/grpc/grpc/archive/refs/tags/v1.63.0.tar.gz
    URL_HASH SHA256=493d9905aa09124c2f44268b66205dd013f3925a7e82995f36745974e97af609
    OVERRIDE_FIND_PACKAGE
    EXCLUDE_FROM_ALL)
set(gRPC_ABSL_PROVIDER "package" CACHE STRING "Provider of absl library")
set(gRPC_ZLIB_PROVIDER "package" CACHE STRING "Provider of zlib library")
set(gRPC_CARES_PROVIDER "package" CACHE STRING "Provider of c-ares library")
set(gRPC_RE2_PROVIDER "package" CACHE STRING "Provider of re2 library")
set(gRPC_SSL_PROVIDER "package" CACHE STRING "Provider of ssl library")
set(gRPC_PROTOBUF_PROVIDER "package" CACHE STRING "Provider of protobuf library")
set(gRPC_INSTALL ON CACHE BOOL "Generate installation target")
FetchContent_MakeAvailable(gRPC)
add_library(gRPC::grpc ALIAS grpc)
add_library(gRPC::grpc++ ALIAS grpc++)
add_executable(gRPC::grpc_cpp_plugin ALIAS grpc_cpp_plugin)

FetchContent_Declare(
    google-cloud-cpp
    URL https://github.com/googleapis/google-cloud-cpp/archive/refs/tags/v2.24.0.tar.gz
    URL_HASH SHA256=8d398958cad2338087ed5321db1d2c70a078d5d9d4dde720449395a3365a9ced
    OVERRIDE_FIND_PACKAGE
    EXCLUDE_FROM_ALL)
set(GOOGLE_CLOUD_CPP_ENABLE_EXAMPLES OFF)
set(GOOGLE_CLOUD_CPP_ENABLE "storage,bigquery" CACHE STRING "The list of libraries to build.")
FetchContent_MakeAvailable(google-cloud-cpp)

add_executable(quickstart quickstart.cc)
target_link_libraries(quickstart google_cloud_cpp_bigquery)