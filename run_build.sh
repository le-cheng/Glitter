#!/bin/bash

# 检查build目录是否存在
if [ -d "build" ]; then
    echo "Directory 'build' exists."
else
    echo "Directory 'build' does not exist. Creating it..."
    mkdir -p build
fi

cd build

# 设置CMake参数，例如启用优化或调试模式
# CMAKE_ARGS="-DCMAKE_BUILD_TYPE=Release"

# # 使用CMake配置项目
cmake -G "MinGW Makefiles" ..

# 使用MinGW编译项目
mingw32-make -j8


bin_file = ./out/Glitter.exe

if [ -f $bin_file ]; then
    ./out/Glitter.exe
else
    echo "File does not exist. Warning!"
fi

echo "run completed."