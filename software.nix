{ config, pkgs, ... }:
let
  unstableTarball =
    fetchTarball
      https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz;
in
{
  # NixPkgs config
  nixpkgs.config = {
    allowBroken = true;
    allowUnfree = true;
    packageOverrides = pkgs: {
      unstable = import unstableTarball {
        config = config.nixpkgs.config;
      };
    };
  };

  environment.systemPackages = (with pkgs; [

    bitwarden
    davinci-resolve
    dbeaver
    discord
    fragments
    figma-linux
    firefox
    google-chrome
    mattermost-desktop
    obs-studio
    postman
    slack
    teamviewer
    vscode
    vim
    wget
    xorg.xkill

    # Gnome
    adw-gtk3
    contrast
    endeavour
    foliate
    gaphor
    gnome-feeds
    marker
    pdfslicer
    spotify

    # Environment Packages
    python2
    python38
    gcc
    glxinfo
    sassc
    sqlite
    imagemagick
    pfetch
    unzip
    ffmpeg

    # Web
    git
    gh
    nodejs
    yarn

    # Nix
    nixpkgs-fmt

  ]) ++ (with pkgs.gnome;
    [
      gnome-themes-extra
      gnome-tweaks
      gnome-boxes
    ])

  # Gnome extensions install
  ++ (with pkgs.gnomeExtensions;
    [
      appindicator
      burn-my-windows
      caffeine
      clipboard-history
      color-picker
      color-app-menu-icon-for-gnome-40
      dash2dock-lite
      docker
      draw-on-you-screen-2
      force-quit
      gnome-40-ui-improvements
      gtk3-theme-switcher
      gsconnect
      lock-keys
      middle-click-to-close-in-overview
      mpris-label
      muteunmute
      notification-timeout
      panel-corners
      replace-activities-text
      show-desktop-button
      simple-system-monitor
      space-bar
      tactile
      task-widget
      user-avatar-in-quick-settings
      wallpaper-switcher
      wayland-or-x11
      window-is-ready-remover
    ]);

  # Gnome softwares removed
  environment.gnome.excludePackages =
    (with pkgs.gnome;
    [
      atomix
      epiphany
      hitori
      iagno
      tali
      seahorse
    ]);

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
}
