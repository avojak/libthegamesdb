![CI](https://github.com/avojak/libthegamesdb/actions/workflows/ci.yml/badge.svg)
![Lint](https://github.com/avojak/libthegamesdb/actions/workflows/lint.yml/badge.svg)
![GitHub](https://img.shields.io/github/license/avojak/libthegamesdb.svg?color=blue)
![GitHub release (latest SemVer)](https://img.shields.io/github/v/release/avojak/libthegamesdb?sort=semver)
[![Documentation](https://img.shields.io/badge/documentation-valadoc-a56de2)](https://avojak.com/libthegamesdb/thegamesdb-1/)

# TheGamesDB Client Library

`libthegamesdb` is a GObject-based client library for TheGamesDB REST API.

API documentation is available at: https://avojak.com/libthegamesdb/thegamesdb-1/

## Example Usage

If using Meson, simply add the dependency after installation:

```meson
dependency('thegamesdb-1', version: '>= 1.0.0')
```

## Building, Testing, and Installation

Run `meson build` to configure the build environment:

```bash
meson build --prefix=/usr
```

This will create a `build` directory.

To build and install `libthegamesdb`, use `ninja`:

```bash
ninja -C build install
```

To run tests:

```bash
ninja -C build test
```

There's also a Makefile if you're lazy like me and don't want to type those commands all the time.

## Demo

Some features are demonstrated through a simple demo application. To run the demo after installation:

```bash
thegamesdb-1-demo
```

## Documentation

The additional requirements for building the documentation are:

- valadoc

To generate the valadoc documentation, pass the additional `-Ddocumentation=true` flag to Meson, and then run `ninja` as before.