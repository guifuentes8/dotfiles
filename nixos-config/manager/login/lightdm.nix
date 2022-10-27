{ pkgs, ... }:

let
in
{
  services.xserver = {
    layout = "br";
    xkbVariant = "";
    enable = true;
    libinput.enable = true;
    displayManager = {
      lightdm = {
        enable = true;
        background = pkgs.nixos-artwork.wallpapers.nineish.gnomeFilePath;
        greeters = {
          gtk.enable = true;
        };
      };
    };
  };
}
