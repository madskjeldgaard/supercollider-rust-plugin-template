// PluginRustPlug.hpp
// Mads Kjeldgaard (mail@madskjeldgaard.dk)

#pragma once

#include "SC_PlugIn.hpp"
#include "myscplug/lib.h"

namespace RustPlug {

class RustPlug : public SCUnit {
public:
    RustPlug();

    // Destructor
    // ~RustPlug();

private:
    // Calc function
    void next(int nSamples);

    // Member variables
};

} // namespace RustPlug
