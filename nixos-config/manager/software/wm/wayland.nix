{ pkgs, ... }:

let
in
{
  environment.systemPackages =
    (with pkgs;
    [
      bemenu # wayland clone of dmenu
      bpytop
      cava
      cmatrix
      dracula-theme # gtk theme
      dunst
      feh
      flameshot
      glib # gsettings
      gnome3.adwaita-icon-theme # default gnome cursors
      gvfs
      himalaya
      kitty # gpu accelerated terminal
      lxappearance
      mpv
      ncspot
      pavucontrol
      playerctl
      ranger
      sptlrx
      tty-clock
      wayland
      wl-clipboard # wl-copy and wl-paste for copy/paste from stdin / stdout
      wofi
      xdg-utils
      xfce.thunar
      xfce.thunar-volman
      xfce.thunar-archive-plugin
    ]);
}
