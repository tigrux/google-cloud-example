#!/bin/bash

# Install dependencies that cannot be built using cmake's FetchContent.
./install-deps.sh

# Now compile, referring to the previously installed libraries
cmake -B build -DCMAKE_INSTALL_PREFIX=./install -DCMAKE_PREFIX_PATH=./install
make -C build -j 8