cmake_minimum_required(VERSION 3.2)
project(wrapper C CXX)

if(NOT DEFINED LLVM_GCC_VERSION)
    message( FATAL_ERROR "LLVM_GCC_VERSION not set" )
endif()
add_definitions(-DLLVM_GCC_VERSION="${LLVM_GCC_VERSION}")

add_executable(wrapper
    src/main.cc
    src/infer_target.cc
    src/path_collection.cc
    src/sysroot_args.cc
    src/target_args.cc
    src/whereami.c
)
set_property(TARGET wrapper PROPERTY CXX_STANDARD 11)
target_include_directories(wrapper PRIVATE include)
install(TARGETS wrapper DESTINATION bin)
