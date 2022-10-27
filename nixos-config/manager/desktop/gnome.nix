{ pkgs, ... }:

let
in
{

  services.xserver = {
    desktopManager = {
      gnome.enable = true;
    };
  };
  # Gnome udev required
  services.udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];
}
