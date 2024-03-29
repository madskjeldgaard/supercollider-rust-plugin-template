// PluginRustGain.cpp
// Mads Kjeldgaard (mail@madskjeldgaard.dk)

#include "SC_PlugIn.hpp"
#include "RustGain.hpp"

static InterfaceTable* ft;

namespace RustGain {

RustGain::RustGain() {
    mCalcFunc = make_calc_function<RustGain, &RustGain::next>();
    next(1);
}

void RustGain::next(int nSamples) {

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

} // namespace RustGain

PluginLoad(RustGainUGens) {
    // Plugin magic
    ft = inTable;
    registerUnit<RustGain::RustGain>(ft, "RustGain", false);
}
