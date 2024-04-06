# Transparent Cursor in Rust & Vulkano
[![Build Status](https://github.com/gyatskov/vulkano-transparent-cursor/actions/workflows/rust.yml/badge.svg)](https://github.com/gyatskov/vulkano-transparent-cursor/actions/workflows/rust.yml)

A simple animated, clickable, transparent cursor on transparent background written in Rust using Vulkano.

The relevant application shader and logic are in [app](./app).

Most of the boilerplate code has been taken from the Vulkan 1.3 triangle example in [vulkano](https://github.com/vulkano-rs/vulkano) and updated according to API changes.

## Dependencies

### Build
* Rust

### Runtime
* Vulkan 1.3


## Running the application:

```sh
# Debug
cargo run --bin vulkano-transparent-cursor

# Release
cargo run --release --bin vulkano-transparent-cursor
```

## License

Licensed under MIT license ([LICENSE-MIT](LICENSE-MIT) or http://opensource.org/licenses/MIT)
