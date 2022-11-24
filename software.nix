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

    # Environtment Dev Packages #
    python2
    python38
    gcc
    sassc
    sqlite
    # Web
    git
    gh
    nodejs
    yarn
    # Nix
    nixpkgs-fmt
    # Environtment Dev Packages #

    # Softwares default 
    bitwarden
    davinci-resolve
    dbeaver
    discord
    ffmpeg
    firefox-devedition-bin
    fragments
    glxinfo
    google-chrome
    imagemagick
    mattermost-desktop
    obs-studio
    onlyoffice-bin
    pfetch
    slack
    unzip
    vscode
    vim
    wget

    # Gnome
    contrast
    drawio
    foliate
    gaphor
    gnome-feeds
    marker
    pdfslicer
    unstable.adw-gtk3

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
    #      kitty # gpu accelerated terminal
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
      #gnome-boxes
    ])


  # Gnome extensions install
  ++ (with pkgs.gnomeExtensions;
    [
      appindicator
      caffeine
      clipboard-history
      color-picker
      eye-extended
      force-quit
      gnome-40-ui-improvements
      lock-keys
      noannoyance-2
      runcat
      sound-output-device-chooser
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
