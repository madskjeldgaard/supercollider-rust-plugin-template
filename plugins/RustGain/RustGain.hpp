// PluginRustGain.hpp
// Mads Kjeldgaard (mail@madskjeldgaard.dk)

#pragma once

#include "SC_PlugIn.hpp"
#include "myscplug/lib.h"

namespace RustGain {

class RustGain : public SCUnit {
public:
    RustGain();

    // Destructor
    // ~RustGain();

private:
    // Calc function
    void next(int nSamples);

    // Member variables
};

} // namespace RustGain
