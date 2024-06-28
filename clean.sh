#!/bin/bash

# # 检查build目录是否存在
# if [ -d "build" ]; then
#     echo "Directory 'build' exists. Clearing its contents..."
#     rm -rf build/*
# else
#     echo "Directory 'build' does not exist. Creating it..."
#     mkdir -p build
# fi

# 检查build目录是否存在
if [ -d "CMakeFiles" ]; then
    echo "Directory 'build' exists. Clearing its contents..."
    rm -rf CMakeFiles/
fi

ninja -t clean

echo "clean completed."