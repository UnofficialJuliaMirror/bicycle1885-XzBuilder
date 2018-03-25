using BinaryBuilder

# Collection of sources required to build XzBuilder
sources = [
    "https://tukaani.org/xz/xz-5.2.3.tar.xz" =>
    "7876096b053ad598c31f6df35f7de5cd9ff2ba3162e5a5554e4fc198447e0347",
]

# Bash recipe for building across all platforms
script = raw"""
cd $WORKSPACE/srcdir/xz-5.2.3/
./configure --prefix=$prefix --host=$target
make
make install
"""

# These are the platforms we will build for by default, unless further
# platforms are passed in on the command line
platforms = [
    BinaryProvider.Linux(:i686, :glibc),
    BinaryProvider.Linux(:x86_64, :glibc),
    BinaryProvider.Linux(:aarch64, :glibc),
    BinaryProvider.Linux(:armv7l, :glibc),
    BinaryProvider.Linux(:powerpc64le, :glibc),
    BinaryProvider.MacOS(),
    BinaryProvider.Windows(:i686),
    BinaryProvider.Windows(:x86_64),
]

# The products that we will ensure are always built
products(prefix) = [
    LibraryProduct(prefix, "liblzma", :liblzma)
]

# Dependencies that must be installed before this package can be built
dependencies = []

# Build the tarballs, and possibly a `build.jl` as well.
build_tarballs(ARGS, "XzBuilder", sources, script, platforms, products, dependencies)
