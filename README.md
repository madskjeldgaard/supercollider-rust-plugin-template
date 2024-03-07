[![ko-fi](https://ko-fi.com/img/githubbutton_sm.svg)](https://ko-fi.com/X8X6RXV10)

# RustGain

Author: Mads Kjeldgaard

An example of using Rust to create a SuperCollider plugin. This plugin is silly and only uses Rust to change the gain of the samples but you can be creative with it however you want :)

The project is set up to be as fast and easy to use as possible. No need to clone source codes and place the certain places. Simply run the included commands to build and install. Build dependencies are handled automatically by CPM (C++ and CMake) and Cargo (Rust).

It is set up to create a small rust libray which is then imported into the C++ side of the plugin. A bridge is automatically generated by the [cxx](https://cxx.rs/) and [corrosion-rs](https://corrosion-rs.github.io/corrosion/) for the CMake part of it. It is all downloaded automatically, including the SuperCollider source code needed, via the CPM package manager. 

To use this, simply clone this repo and replace the "RustGain" name throughout the project with your own plugin name.

## Features

- A handy build script `commands.sh` to easily build and install the plugin, no extra steps needed
- Automatic dependency handling via the CPM package manager (No need to manually clone SuperCollider, etc.)
- Automatic generation of C++ headers for the Rust code (handled via corrosion-rs and cxxbridge)
- VSCode / Neovim Overseer build tasks to easily run all build commands from your editor

### Requirements

- CMake >= 3.15
- Rust

## Workflow

A typical workflow for developing an audio plugin using this template looks like this:

0. Make changes to the code
1. Run the build commands to build and install (see below)
2. Recompile the SuperCollider class library:
    - In the SuperCollider IDE, run `Language> Recompile Class Library`
    or:
    - In SuperCollider code, evaluate `thisProcess.recompile()`
3. Run your plugin by evaluating this code in SuperCollider:

```supercollider
s.waitForBoot {
    "Supercollider sound server booted".postln;

    play{
        var sig = SinOsc.ar(440)!2;
        // Run RustGain plugin on a sine wave
        RustGain.ar(sig, gain: 0.5)
    }

}
```

## Building

Clone the project:

    git clone https://github.com/madskjeldgaard/RustGain
    cd RustGain

### Using commands.sh

An easier way to build is included via the commands.sh script. This will automatically find the path to your SuperCollider extensions and install the plugin after build.

```bash
# Only needed once:
chmod +x scripts/commands.sh

# Configure and build
./scripts/commands.sh configure_release
./scripts/commands.sh build
./scripts/commands.sh build_and_install

# Optionally clean
./scripts/commands.sh clean
```

### Using CMake directly

Then, use CMake to configure and build it:

    mkdir build
    cd build
    cmake .. -DCMAKE_BUILD_TYPE=Release
    cmake --build . --config Release
    cmake --build . --config Release --target install

You may want to manually specify the install location in the first step to point it at your
SuperCollider extensions directory: add the option `-DCMAKE_INSTALL_PREFIX=/path/to/extensions` (this is done automatically by commands.sh if you go that route)
