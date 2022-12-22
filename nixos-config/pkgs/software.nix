{ pkgs, ... }:
{
  environment.systemPackages = (with pkgs; [
    alacritty
    bitwarden
    dbeaver
    discord
    fragments
    figma-linux
    firefox
    mattermost-desktop
    obs-studio
    postman
    slack
    teamviewer
    vscode
    vim
    wget
    xorg.xkill
    spotify

    # wm - xorg
    #      bpytop
    #      cava
    #      cmatrix
    #      dmenu
    #      dracula-theme
    #      dunst
    #      feh
    #      flameshot
    #      glib
    #      gnome3.adwaita-icon-theme
    #      gvfs
    #      himalaya
    #      kitty
    #      lxappearance
    #      mpv
    #      nitrogen
    #      ncspot
    #      pavucontrol
    #      picom
    #      playerctl
    #      ranger
    #      sptlrx
    #      tty-clock
    #      rofi
    #      xdg-utils
    #      xfce.thunar
    #      xfce.thunar-volman
    #      xfce.thunar-archive-plugin
    #      xorg.xrandr

    #wm - wayland
    #      bemenu # wayland clone of dmenu
    #      bpytop
    #      cava
    #      cmatrix
    #      dracula-theme # gtk theme
    #      dunst
    #      feh
    #      glib # gsettings
    #      gnome3.adwaita-icon-theme # default gnome cursors
    #      grim
    #      gvfs
    #      himalaya
    #      lxappearance
    #      mpv
    #      ncspot
    #      pavucontrol
    #      playerctl
    #      ranger
    #      slurp
    #      sptlrx
    #      tty-clock
    #      waybar
    #      wayland
    #      wl-clipboard # wl-copy and wl-paste for copy/paste from stdin / stdout
    #      wofi
    #      xdg-utils
    #      xfce.thunar
    #      xfce.thunar-volman
    #      xfce.thunar-archive-plugin
  ]);
}
