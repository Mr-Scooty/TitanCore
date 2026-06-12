# Native CMake precompiled header support (requires CMake >= 3.16).
# Replaces the former cotire-based implementation.

set(PCHSupport_FOUND 1)

# ADD_CXX_PCH(<target-list> <pch-header> [<pch-source>])
# The pch-source argument was only needed by cotire/MSVC and is ignored.
function(ADD_CXX_PCH TARGET_NAME_LIST PCH_HEADER)
  foreach(TARGET_NAME ${TARGET_NAME_LIST})
    target_precompile_headers(${TARGET_NAME} PRIVATE ${PCH_HEADER})
  endforeach()
endfunction(ADD_CXX_PCH)
