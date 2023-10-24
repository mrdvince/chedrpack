# chedrpack

Trying a little C from Rust and while at it might as well trying building an rpm.

# Compile

```bash
    make
```

This should build the rust package in release mode, and also use cbindgen to genereate a c header file in the `include` folder.

This basically just runs the following commands:

```bash
	cargo build --release
	mkdir -p include
	cbindgen --config cbindgen.toml --crate rustrpm --output include/rustrpm.h
```
