{ pkgs, config, ... }:

let
in
{
  # Services
  services.dbus.enable = true;
  services.printing.enable = true;
  services.openssh.enable = true;
  services.gnome.gnome-keyring.enable = true;

}
