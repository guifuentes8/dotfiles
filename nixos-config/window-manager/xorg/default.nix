{ pkgs, ... }:

let
in
{
  imports =
    [
      # ./awesome.nix
      # ./i3.nix
      ./qtile.nix
    ];
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

  environment.systemPackages =
    (with pkgs;
    [
      bpytop
      cava
      cmatrix
      dmenu
      dracula-theme # gtk theme
      dunst
      feh
      flameshot
      glib # gsettings
      gnome3.adwaita-icon-theme # default gnome cursors
      himalaya
      kitty
      lxappearance
      mpv
      nitrogen
      ncspot
      pavucontrol
      picom
      playerctl
      ranger
      sptlrx
      tty-clock
      rofi
      xfce.thunar
      xfce.thunar-volman
      xfce.thunar-archive-plugin
      xorg.xrandr

    ]);
}
