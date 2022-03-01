{ pkgs, ... }:
{
  nixpkgs.overlays = with pkgs;
    [
      (self: super: {
        mypolybar = polybar.override {
          i3Support = true;
        };
      })
    ];

  environment.systemPackages = with pkgs;
    [
      alacritty
      rofi
      qutebrowser

      gh

      git
      wget
      killall

      ripgrep
      fd

      mypolybar

      rustup
      clang

      wpa_supplicant
    ];
}
