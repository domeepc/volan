# Additional clean files
cmake_minimum_required(VERSION 3.16)

if("${CONFIG}" STREQUAL "" OR "${CONFIG}" STREQUAL "Debug")
  file(REMOVE_RECURSE
  "CMakeFiles/appvolan_autogen.dir/AutogenUsed.txt"
  "CMakeFiles/appvolan_autogen.dir/ParseCache.txt"
  "appvolan_autogen"
  )
endif()
