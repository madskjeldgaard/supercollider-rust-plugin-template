# Dependencies that are downloaded using the CPM package manager
include("${CMAKE_CURRENT_LIST_DIR}/CPM.cmake")

# Install corrosion – a Rust to C++ bridge
cpmaddpackage(NAME Corrosion GITHUB_REPOSITORY corrosion-rs/corrosion GIT_TAG
              v0.5.2)

# Rust directory: rust in root dir
set(RUST_DIR "${CMAKE_CURRENT_SOURCE_DIR}/rust")

# Add a rust library After this, all you need to do is link to the rust library
# in your C++ like this: target_link_libraries(SharedCode INTERFACE myrustlib)
corrosion_import_crate(MANIFEST_PATH "${RUST_DIR}/myscplug/Cargo.toml")

corrosion_add_cxxbridge(
  myscplug
  CRATE
  myscplug-crate
  MANIFEST_PATH
  "${RUST_DIR}/myscplug"
  # NOTE: These file paths are relative to the root of the rust crate's src dir
  # eg rust/myscplug/src.
  FILES
  "lib.rs")

if(MSVC)
  # Note: This is required because we use `cxx` which uses `cc` to compile and
  # link C++ code.
  corrosion_set_env_vars(myscplug-crate "CFLAGS=-MDd" "CXXFLAGS=-MDd")
endif()

# A function that will link the rust library to a SC plugin target
function(
  sc_add_server_plugin_with_rust
  dest_dir
  name
  cpp
  sc
  schelp
  name_of_rust_target)

  sc_add_server_plugin(${dest_dir} ${name} ${cpp} ${sc} ${schelp})

  if(SCSYNTH)

    # Name of scsynth plugin
    set(SC_PLUGIN_TARGET_NAME "${name}_scsynth")

    # Link the rust library to the scsynth plugin
    target_link_libraries(${SC_PLUGIN_TARGET_NAME}
                          PRIVATE ${name_of_rust_target})
  endif()

  if(SUPERNOVA)

    # Name of supernova plugin
    set(SUPERNOVA_PLUGIN_TARGET_NAME "${name}_supernova")

    # Link the rust library to the supernova plugin
    target_link_libraries(${SUPERNOVA_PLUGIN_TARGET_NAME}
                          PRIVATE ${name_of_rust_target})
  endif()

endfunction()
