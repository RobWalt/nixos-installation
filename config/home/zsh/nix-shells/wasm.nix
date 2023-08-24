let
  moz_overlay = import (fetchTarball "https://github.com/mozilla/nixpkgs-mozilla/archive/master.tar.gz");
  nixpkgs = import <nixpkgs> { overlays = [ moz_overlay ]; };
in
with nixpkgs;
stdenv.mkDerivation
{
  name = "rust-env";
  allowUnfree = true;
  nativeBuildInputs = [
    pkgconfig
    clang
    lld
  ];
  buildInputs = [
    (nixpkgs.latest.rustChannels.stable.rust.override {
      targets = [ "wasm32-unknown-unknown" ];
    })
    udev
    python3
    alsaLib
    xorg.libX11
    xorg.libXcursor
    xorg.libXrandr
    xorg.libXi
    vulkan-headers
    vulkan-loader
    vulkan-tools
    vulkan-validation-layers
  ];
  shellHook = ''
    export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:${pkgs.lib.makeLibraryPath [
      udev alsaLib vulkan-loader
    ]}"
  '';
}
