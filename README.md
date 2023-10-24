# chedrpack

Trying a little C from Rust and while at it might as well trying building an rpm.

# Compile

```bash
    make
```

This should build the rust package in release mode, and also use cbindgen to genereate a c header file in the `include` folder.

This basically just runs the following commands:
Mac:
```bash
	cargo build --release
	mkdir -p include
	cbindgen --config cbindgen.toml --crate chedrpack --output include/chedrpack.h
```

On linux (tried with almalinux):
```bash
	mkdir -p $(SOURCE_DIR)
	tar czvf $(SOURCE_DIR)/$(TAR_NAME) --exclude=target --exclude=.git --transform 's,^,chedrpack-$(VERSION)/,' *
	rpmbuild --define "_topdir /build/build/rpmbuild" -bb packaging/package.spec
```

# Install

Simply run:
```bash
    make install
```
Which runs the below commands to install:
Mac:

```bash
    install -m 755 target/release/$(LIB_NAME) $(LIB_DIR)/$(LIB_NAME)
	install -m 644 include/$(HEADER_NAME) $(INCLUDE_DIR)/$(HEADER_NAME)
```
where the variables are:
```bash
LIB_NAME = libchedrpack.a
HEADER_NAME = chedrpack.h
LIB_DIR = /usr/local/lib
INCLUDE_DIR = /usr/local/include
```

Linux: 
make install runs the following:
```bash
	yum -y localinstall build/rpmbuild/RPMS/aarch64/chedrpack-0.1.0-1.el9.aarch64.rpm
```
