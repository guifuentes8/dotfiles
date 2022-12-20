{ pkgs, ... }:
let
in
{
  imports =
    [
      ./software.nix
      ./extensions.nix
    ];

}
