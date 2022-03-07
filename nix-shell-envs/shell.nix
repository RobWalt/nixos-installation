# shell.nix

{ pkgs ? import <nixpkgs> { } }:
with pkgs; mkShell {
  nativeBuildInputs = [
    pkgconfig
    clang
    lld
  ];
  buildInputs = [
    udev
    alsaLib
    vulkan-loader
    x11
    xorg.libXcursor
    xorg.libXrandr
    xorg.libXi
  ];
  shellHook = ''export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:${pkgs.lib.makeLibraryPath [
    udev alsaLib vulkan-loader
  ]}"'';
}
