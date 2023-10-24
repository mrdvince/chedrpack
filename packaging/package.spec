Name:       chedrpack
Version:    0.1.0
Release:    1%{?dist}
Summary:    Trying out packaging rust and c rpms

License:        MIT
URL:            https://github.com/mrdvince/chedrpack

Source0:        %{name}-%{version}.tar.gz

BuildRequires:  gcc

%description
A ddummy sample project to try out Rust + C

%define sourcedir %{name}-%{version}.tar.gz
%define debug_package %{nil}

%prep
%setup -q

%build
cargo build --release

%install
install -Dm755 target/release/libchedrpack.a %{buildroot}/usr/local/lib/libchedrpack.a
install -Dm644 include/chedrpack.h %{buildroot}/usr/local/include/chedrpack.h

%files
/usr/local/lib/libchedrpack.a
/usr/local/include/chedrpack.h