#[no_mangle]
pub extern fn apply_gain(input_sample: f32, gain: f32) -> f32 {
    input_sample * gain
}

#[cxx::bridge(namespace = "myscplug")]
mod ffi {
    // This lists types and functions defined on the Rust side that should be exposed to C++
    extern "Rust" {
        fn apply_gain(input_sample: f32, gain: f32) -> f32;
    }

    // A unsafe extern "C++" section defines data types and functions available on the C++ side, which should be usable from Rust
    // unsafe extern "C++" {
    //     include!("myrustlib/include/myrustlib.h");

    //     type MyRustLib;

    //     fn create() -> UniquePtr<MyRustLib>;
    //     fn add(this: &MyRustLib, left: usize, right: usize) -> usize;
    // }
}


#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn it_works() {
        let result = apply_gain(2.0, 2.0);
        assert_eq!(result, 4.0);
    }
}
