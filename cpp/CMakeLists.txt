
cmake_minimum_required(VERSION 2.8)

project(cpp)

find_package(OpenCV REQUIRED)

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wall -pipe -std=c++11" CACHE string "" FORCE)
include_directories(${CMAKE_CURRENT_SOURCE_DIR} ${CMAKE_CURRENT_BINARY_DIR})

############################################################################ 

add_library(simple SHARED simple.cpp)

add_library(opencv SHARED opencv.cpp)
target_link_libraries(opencv ${OpenCV_LIBS})

