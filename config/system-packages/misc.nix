{ pkgs, ... }:
{
  inherit (pkgs.llvmPackages_9) bintools;
}
