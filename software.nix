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
    kitty
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

  ]) ++ (with pkgs.gnome;
    [
      gnome-themes-extra
      gnome-todo
      gnome-tweaks
      gnome-boxes
    ])


  # Gnome extensions install
  ++ (with pkgs.gnomeExtensions;
    [
      appindicator
      caffeine
      clipboard-history
      color-picker
      force-quit
      gnome-40-ui-improvements
      lock-keys
      noannoyance-2
      runcat
      spotify-tray
      tactile
      task-widget
    ]);

  # Gnome softwares removed
  environment.gnome.excludePackages = (with pkgs.gnome;
    [
      atomix
      epiphany
      hitori
      iagno
      tali
      seahorse
    ]);
}
