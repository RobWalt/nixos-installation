_: {
  nix.settings = {

    # cache options
    substituters = [
      "https://cache.nixos.org/"
    ];
    trusted-public-keys = [
    ];

    # enables flakes
    experimental-features = [
      "nix-command"
      "flakes"
    ];
  };
}
