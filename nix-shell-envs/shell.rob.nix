let
  moz_overlay = import (builtins.fetchTarball https://github.com/mozilla/nixpkgs-mozilla/archive/master.tar.gz);
  nixpkgs = import <nixpkgs> {
    overlays = [
      (import "${fetchTarball "https://github.com/nix-community/fenix/archive/main.tar.gz"}/overlay.nix")
    ];
  };
in
with nixpkgs;
stdenv.mkDerivation {
  name = "rust-env";
  allowUnfree = true;
  buildInputs = [
    #nixpkgs.latest.rustChannels.stable.rust
    #nixpkgs.latest.rustChannels.nightly.rust
    #(nixpkgs.latest.rustChannels.stable.rust.override {
    #  targets = [ "wasm32-unknown-unknown" ];
    #})
    (fenix.complete.withComponents [
      "cargo"
      "clippy"
      "rust-src"
      "rustc"
      "rustfmt"
    ])
    cargo-watch
    cargo-make
    jq
    xsv
    # Needed for metacad
    alsaLib
    #lutris
    gtk3
    pkgconfig
    # egui dependency
    python3
    udev
    vulkan-headers
    vulkan-loader
    vulkan-tools
    vulkan-validation-layers
    wasm-pack
    xlibsWrapper
    xorg.libXcursor
    xorg.libXi
    xorg.libXrandr
  ];
  shellHook = ''
    export NIX_ENFORCE_PURITY=0
    export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:${pkgs.lib.makeLibraryPath [ udev alsaLib vulkan-loader ]}"
    source .env
    #cargo watch -x "clippy"
  '';
}
