{ pkgs, ... }:
let
  unstable = import <nixos-unstable> { };
in
{

  environment.systemPackages = with pkgs;
    [
      # apps
      alacritty # terminal
      blender # 3D modelling
      discord # chat app
      firefox # alternative browser if qutebrowser doesn't work
      flameshot # screenshots
      gimp # image editing
      helix # alternative editor to nvim
      imagemagick # convert between image data type
      inkscape # drawing tool
      keepassxc # password manager
      libresprite # pixel art tool
      mdbook # pdf books from markdown
      peek # gif capturing tool
      qutebrowser # broswer with vim controls
      restream # stream remarkable to pc screen
      rustdesk # remote connection to other computers
      spotify # music
      tdesktop # telegram desktop app
      teamspeak_client # voice chat
      zathura # pdf reader
      xflux # blue light filter

      # cli utils
      blueberry # bluetooth config
      bat # better cat
      binutils
      btop
      delta
      difftastic
      du-dust
      duf
      dunst
      exa
      exercism
      fd
      fzf
      gh
      git
      git-cliff
      git-lfs
      gitoxide
      glab
      hurl
      jq
      just
      license-generator
      lsof
      pass
      pciutils
      ranger
      ripgrep
      sd
      tealdeer
      tokei
      tree
      unstable.gum
      unzip
      xclip
      zip
      zola
      zoxide
      zsh

      # for tmux battery
      acpi
      upower

      # ui
      brightnessctl
      i3lock-fancy

      # stuff
      clang
      lld
      lldb
      killall
      pkg-config
      wget
      wpa_supplicant
      usbutils
      graphviz

      # audio
      pamixer

      # rust
      rustup
      rust-analyzer
      mold

      # rust cargo extensions
      cargo-audit
      cargo-bloat
      cargo-deny
      cargo-edit
      cargo-expand
      cargo-fuzz
      cargo-generate
      cargo-llvm-lines
      cargo-nextest
      cargo-outdated
      cargo-udeps
      cargo-update
      cargo-watch
      unstable.cargo-make # latest version needed
      hyperfine
      feroxbuster
      # not available yet
      #cargo-hack

      #kind
      unstable.kind2

      # haskell
      cabal-install
      cabal2nix
      haskellPackages.implicit-hie
      ghc
      haskell-language-server
      ormolu

      # tidal cycles
      haskellPackages.tidal
      supercollider

      # local markdown slides
      jekyll

      # lua
      luajit
      sumneko-lua-language-server

      # wasm
      wasm-bindgen-cli # not always up to date
      wasm-pack

      # javascript 
      nodejs

      # docker
      docker-compose
    ];
}
