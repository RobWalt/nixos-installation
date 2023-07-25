# shell.nix

{ pkgs ? import <nixos> { } }:
with pkgs; mkShell {
  nativeBuildInputs =
    [
      pkgconfig
      clang
      lld
    ];
  buildInputs =
    [
      alsaLib
      udev
      python3
      alsa-lib
      vulkan-loader
      xorg.libX11
      xorg.libXcursor
      xorg.libXrandr
      xorg.libXi
    ];
  shellHook = ''export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:${pkgs.lib.makeLibraryPath [
    udev alsaLib vulkan-loader
  ]}"'';
}
