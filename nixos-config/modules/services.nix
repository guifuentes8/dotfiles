{ pkgs, config, ... }:

let
in
{
  # Services
  services.dbus.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };
  services.printing.enable = true;
  services.openssh.enable = true;
  services.blueman.enable = true;
  services.gnome.gnome-keyring.enable = true;

}
