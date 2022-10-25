{ pkgs, ... }:

let
in
{
  imports =
    [
      # ./awesome.nix
      # ./i3.nix
      ./sway.nix
    ];


  environment.systemPackages =
    (with pkgs;
    [
      bemenu # wayland clone of dmenu
      bpytop
      cava
      cmatrix
      configure-gtk
      dracula-theme # gtk theme
      dunst
      feh
      flameshot
      glib # gsettings
      gnome3.adwaita-icon-theme # default gnome cursors
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
      xfce.thunar
      xfce.thunar-volman
      xfce.thunar-archive-plugin
    ]);
}
