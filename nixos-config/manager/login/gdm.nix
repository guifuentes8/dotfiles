{ pkgs, ... }:

let
in
{
  services.xserver = {
    displayManager = {
      gdm.enable = true;
    };
  };
}
