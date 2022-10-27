{ pkgs, ... }:

let
in
{
  environment.systemPackages =
    (with pkgs;
    [
      bpytop
      cava
      cmatrix
      dmenu
      dracula-theme
      dunst
      feh
      flameshot
      glib
      gnome3.adwaita-icon-theme
      gvfs
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
      xdg-utils
      xfce.thunar
      xfce.thunar-volman
      xfce.thunar-archive-plugin
      xorg.xrandr
    ]);
}
