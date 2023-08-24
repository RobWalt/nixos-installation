{ pkgs, ... }: {

  console.font = "${pkgs.terminus_font}/share/consolefonts/ter-u28n.psf.gz";

  fonts.fontDir.enable = true;
  fonts.fonts =
    let
      myfonts = pkgs.nerdfonts.override { fonts = [ "Iosevka" "IosevkaTerm" "Meslo" ]; };
    in
    builtins.attrValues {
      inherit (pkgs)
        terminus_font
        corefonts;
      inherit myfonts;
    };
}
