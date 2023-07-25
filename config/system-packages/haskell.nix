{ haskellPackages, ... }:
{
  inherit (haskellPackages)
    greenclip# clipboard manager, daemon needs to be started
    implicit-hie
    hoogle
    fast-tags
    haskell-debug-adapter
    ghci-dap;
}
