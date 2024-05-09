#!/bin/bash

# Install some dependencies via apt
sudo -E apt update && \
sudo -E apt install \
  libc-ares-dev \
  pkg-config \
  libre2-dev \
  libssl-dev \
  zlib1g-dev \
  libcurl4-openssl-dev

# Install dependencies that cannot be built using cmake's FetchContent.
./install-deps.sh

# Now compile, referring to the previously installed libraries
cmake -B build -DCMAKE_INSTALL_PREFIX=./install -DCMAKE_PREFIX_PATH=./install
make -C build -j 8