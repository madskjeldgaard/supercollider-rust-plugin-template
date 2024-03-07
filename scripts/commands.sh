#! /bin/bash

# This function returns the location of Supercollider extensions, depending on the OS
function get_sc_extensions_path {
  if [[ "$OSTYPE" == "linux-gnu" ]]; then
    echo "$HOME/.local/share/SuperCollider/Extensions"
  elif [[ "$OSTYPE" == "darwin"* ]]; then
    echo "$HOME/Library/Application Support/SuperCollider/Extensions"
  else
    echo "Unsupported OS"
  fi
}

# Set up CMake
function configure {
  CONF=$1
  SCEXTPATH=$(get_sc_extensions_path)
  cmake -B build -S . -DCMAKE_BUILD_TYPE=$CONF -DCMAKE_INSTALL_PREFIX="${SCEXTPATH}"
}

# Build the project
function build {
  CONF=$1
  cmake --build build --config $CONF
}

# Build and install
function build_and_install {
  CONF=$1
  cmake --build build --config $CONF --target install
}

function clean {
  rm -rf build
}

function main {
  if [ "$1" == "configure_release" ]; then
    configure Release
  elif [ "$1" == "build_release" ]; then
    build Release
  elif [ "$1" == "build_and_install" ]; then
    build_and_install Release
  elif [ "$1" == "clean" ]; then
    clean
  elif [ "$1" == "configure_debug" ]; then
    configure Debug
  elif [ "$1" == "build_debug" ]; then
    build Debug
  elif [ "$1" == "build_and_install_debug" ]; then
    build_and_install Debug
  else
    echo "Usage: $0 [configure_release|build_release|build_and_install|clean|configure_debug|build_debug|build_and_install_debug]"
  fi
}

main $@
