// PluginRustPlug.cpp
// Mads Kjeldgaard (mail@madskjeldgaard.dk)

#include "SC_PlugIn.hpp"
#include "RustPlug.hpp"

static InterfaceTable* ft;

namespace RustPlug {

RustPlug::RustPlug() {
    mCalcFunc = make_calc_function<RustPlug, &RustPlug::next>();
    next(1);
}

void RustPlug::next(int nSamples) {

    // Audio rate input
    const float* input = in(0);

    // Control rate parameter: gain.
    const float gain = in0(1);

    // Output buffer
    float* outbuf = out(0);

    // simple gain function
    for (int i = 0; i < nSamples; ++i) {
        outbuf[i] = myscplug::apply_gain(input[i], gain);
    }
}

} // namespace RustPlug

PluginLoad(RustPlugUGens) {
    // Plugin magic
    ft = inTable;
    registerUnit<RustPlug::RustPlug>(ft, "RustPlug", false);
}
