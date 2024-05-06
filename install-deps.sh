#!/bin/bash

BASEDIR=$(dirname "$0")

function install_dep {
    local DEP_NAME="$1"
    shift
    local DEP_URL="$1"
    local DEP_SRC="deps/${DEP_NAME}/src"
    local DEP_BUILD="deps/${DEP_NAME}/build"
    shift
    if ! test -d ${DEP_SRC}; then
        echo "-- Downloading ${DEP_NAME}"
        mkdir -p ${DEP_SRC} && \
        curl -fsSL ${DEP_URL} | tar -xzf - --strip-components=1 -C ${DEP_SRC}
    fi
    if ! test -d ${DEP_BUILD}; then
        echo "-- Building ${DEP_NAME}"
        mkdir -p ${DEP_BUILD} && \
        cmake -S ${DEP_SRC} -B ${DEP_BUILD} \
            -DCMAKE_INSTALL_PREFIX=${BASEDIR}/install -DCMAKE_PREFIX_PATH=${BASEDIR}/install \
            -DCMAKE_BUILD_TYPE=Release -DBUILD_SHARED_LIBS=OFF \
            "$@" && \
        cmake --build ${DEP_BUILD} -- -j && \
        cmake --build ${DEP_BUILD} --target install
    fi
}

function install_abseil_cpp {
    install_dep abseil-cpp https://github.com/abseil/abseil-cpp/archive/20240116.2.tar.gz \
        -DABSL_BUILD_TESTING=OFF \
        -DABSL_PROPAGATE_CXX_STD=ON \
        -DBUILD_SHARED_LIBS=OFF
}

function install_crc32c {
    install_dep crc32c https://github.com/google/crc32c/archive/1.1.2.tar.gz \
        -DCMAKE_BUILD_TYPE=Release \
        -DCRC32C_BUILD_TESTS=OFF \
        -DCRC32C_BUILD_BENCHMARKS=OFF \
        -DCRC32C_USE_GLOG=OFF
}

function install_nlohmann_json {
    install_dep nlohmann_json https://github.com/nlohmann/json/archive/v3.11.3.tar.gz \
        -DJSON_BuildTests=OFF
}

# install_abseil_cpp
install_crc32c
install_nlohmann_json