{ config, pkgs, ... }:
let
  unstableTarball =
    fetchTarball
      https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz;
  yarn-16-18 = pkgs.callPackage ./pkgs/yarn-16-18.nix { };
  tokyo-night = pkgs.callPackage ./pkgs/tokyo-night.nix { };

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
  environment.extraInit = ''
    if [ -d "~/.themes/" ]; then
    mkdir ~/.themes/
    fi 
        ln -sf "${tokyo-night}/share/themes/Tokyonight-Dark-BL" ~/.themes/
        ln -sf "${tokyo-night}/share/themes/Tokyonight-Dark-BL/gtk-4.0/gtk.css" ~/.config/gtk-4.0/gtk.css

  '';
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
    nodejs-16_x
    yarn-16-18
    # yarn

    # Docker
    docker-compose
    lsof

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
      emoji-selector
      force-quit
      gnome-40-ui-improvements
      gtk3-theme-switcher
      gsconnect
      lock-keys
      middle-click-to-close-in-overview
      muteunmute
      notification-timeout
      noannoyance-2
      panel-corners
      remove-alttab-delay-v2
      replace-activities-text
      show-desktop-button
      space-bar
      tactile
      task-widget
      user-avatar-in-quick-settings
      vitals
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
