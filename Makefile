# Variables common to both environments
VERSION = 0.1.0
LIB_NAME = libchedrpack.a
HEADER_NAME = chedrpack.h

# Detect the operating system
UNAME_S := $(shell uname -s)

# Conditional directive for macOS
ifeq ($(UNAME_S),Darwin)
LIB_DIR = /usr/local/lib
INCLUDE_DIR = /usr/local/include

.PHONY: all clean install uninstall

all:
	cargo build --release
	mkdir -p include
	cbindgen --config cbindgen.toml --crate chedrpack --output include/chedrpack.h

install:
	install -m 755 target/release/$(LIB_NAME) $(LIB_DIR)/$(LIB_NAME)
	install -m 644 include/$(HEADER_NAME) $(INCLUDE_DIR)/$(HEADER_NAME)

uninstall:
	rm -f $(LIB_DIR)/$(LIB_NAME)
	rm -f $(INCLUDE_DIR)/$(HEADER_NAME)

clean:
	cargo clean

# Conditional directive for Linux
else
TAR_NAME = chedrpack-$(VERSION).tar.gz
SOURCE_DIR = build/rpmbuild/SOURCES
RPMBUILD_DIR = /build/build/rpmbuild

.PHONY: all clean package deps

all: package

deps:
	dnf group install "Development Tools" -y
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs |  sh -s -- -y
	source "${HOME}/.cargo/env"

package:
	mkdir -p $(SOURCE_DIR)
	tar czvf $(SOURCE_DIR)/$(TAR_NAME) --exclude=target --exclude=.git --transform 's,^,chedrpack-$(VERSION)/,' *
	rpmbuild --define "_topdir /build/build/rpmbuild" -bb packaging/package.spec

install:
	yum -y localinstall build/rpmbuild/RPMS/aarch64/chedrpack-0.1.0-1.el9.aarch64.rpm

uninstall:
	yum -y remove chedrpack

clean:
	rm -rf $(RPMBUILD_DIR)
	cargo clean

endif

test:
	gcc -o tests/test_add tests/test_add.c -l chedrpack && tests/test_add && rm tests/test_add