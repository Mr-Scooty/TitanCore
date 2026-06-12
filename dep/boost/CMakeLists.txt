# Copyright (C) 2008-2018 TrinityCore <https://www.trinitycore.org/>
#
# This file is free software; as a special exception the author gives
# unlimited permission to copy and/or distribute it, with or without
# modifications, as long as this notice is preserved.
#
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY, to the extent permitted by law; without even the
# implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

if(WIN32)
  set(BOOST_DEBUG ON)
  if(DEFINED ENV{BOOST_ROOT})
    set(BOOST_ROOT $ENV{BOOST_ROOT})
  else()
    message(FATAL_ERROR "No BOOST_ROOT environment variable could be found! Please make sure it is set and the points to your Boost installation.")
  endif()

  set(Boost_USE_STATIC_LIBS        ON)
  set(Boost_USE_MULTITHREADED      ON)
  set(Boost_USE_STATIC_RUNTIME     OFF)
endif()

# Use Boost's own CMake package configuration (FindBoost was removed in CMake 4)
if(POLICY CMP0167)
  cmake_policy(SET CMP0167 NEW)
endif()

include(CheckCXXSourceCompiles)

check_cxx_source_compiles("
  #include <regex>
  int main() { std::wregex r(L\".*\"); }"
  STD_HAS_WORKING_WREGEX)

if (STD_HAS_WORKING_WREGEX)
  find_package(Boost 1.70 REQUIRED COMPONENTS system filesystem thread program_options iostreams)
else()
  find_package(Boost 1.70 REQUIRED COMPONENTS system filesystem thread program_options iostreams regex)
endif()

add_library(boost INTERFACE)

target_link_libraries(boost
  INTERFACE
    Boost::system
    Boost::filesystem
    Boost::thread
    Boost::program_options
    Boost::iostreams)

target_compile_definitions(boost
  INTERFACE
    -DBOOST_DATE_TIME_NO_LIB
    -DBOOST_REGEX_NO_LIB
    -DBOOST_CHRONO_NO_LIB
    -DBOOST_CONFIG_SUPPRESS_OUTDATED_MESSAGE
    -DBOOST_ASIO_NO_DEPRECATED)

if (NOT STD_HAS_WORKING_WREGEX)
  target_link_libraries(boost
    INTERFACE
      Boost::regex)

  target_compile_definitions(boost
    INTERFACE
      -DTC_HAS_BROKEN_WSTRING_REGEX)
endif()
