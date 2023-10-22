Name:       rustrpm
Version:    0.1.0
Release:    1%{?dist}
Summary:    Trying out packaging rust and c rpms

License:        MIT
URL:            https://github.com/mrdvince/rustrpm

Source0:        %{name}-%{version}.tar.gz

BuildRequires:  gcc

%description
A ddummy sample project to try out Rust + C

%define _topdir /build/build/rpmbuild
%define sourcedir %{name}-%{version}.tar.gz
%define debug_package %{nil}

%prep
%setup -q

%build
cargo build --release

%install
install -Dm755 target/release/librustrpm.a %{buildroot}/usr/local/lib/librustrpm.a
install -Dm644 include/rustrpm.h %{buildroot}/usr/local/include/rustrpm.h

%files
/usr/local/lib/librustrpm.a
/usr/local/include/rustrpm.h