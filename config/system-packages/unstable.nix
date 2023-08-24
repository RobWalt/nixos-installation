{ unstable, ... }:
# 23.05 unstable
{
  inherit (unstable)
    codeberg-cli# my pkg
    thunderbird# email client -> cool new version
    cargo-shuttle# needed a specific version which wasn't stable yet
    typst# latex alternative - writing documents
    typst-lsp# typst lsp
    ;
}
