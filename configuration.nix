# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

let
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/release-22.05.tar.gz";
  nvidia-offload = pkgs.writeShellScriptBin "nvidia-offload" ''
    export __NV_PRIME_RENDER_OFFLOAD=1
    export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
    export __GLX_VENDOR_LIBRARY_NAME=nvidia
    export __VK_LAYER_NV_optimus=NVIDIA_only
    exec "$@"
  '';
in
{
  imports =
    [
      ./hardware-configuration.nix
      (import "${home-manager}/nixos")
    ];

  # BOOT 

  boot.loader.grub = {
    enable = true;
    useOSProber = true;
    efiSupport = true;
    default = "saved";
    device = "nodev";
  };
  boot.loader.efi = {
    canTouchEfiVariables = true;
    efiSysMountPoint = "/boot/efi";
  };

  boot.kernelParams = [ "i915.force_probe=46a6" ];
  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Sao_Paulo";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.utf8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pt_BR.utf8";
    LC_IDENTIFICATION = "pt_BR.utf8";
    LC_MEASUREMENT = "pt_BR.utf8";
    LC_MONETARY = "pt_BR.utf8";
    LC_NAME = "pt_BR.utf8";
    LC_NUMERIC = "pt_BR.utf8";
    LC_PAPER = "pt_BR.utf8";
    LC_TELEPHONE = "pt_BR.utf8";
    LC_TIME = "pt_BR.utf8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  hardware.opengl.enable = true;
  hardware.nvidia.modesetting.enable = true;
  hardware.nvidia.nvidiaPersistenced = true;
  hardware.nvidia.powerManagement.enable = true;
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;

  services.xserver.videoDrivers = [ "nvidia" ];
  services.xserver.screenSection = ''
    Option         "metamodes" "nvidia-auto-select +0+0 {ForceFullCompositionPipeline=On}"
    Option         "AllowIndirectGLXProtocol" "off"
    Option         "TripleBuffer" "on"
  '';
  hardware.nvidia.prime = {
    offload.enable = true;
    nvidiaBusId = "PCI:1:0:0";
    intelBusId = "PCI:0:2:0";
  };

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  #services.xserver.displayManager.lightdm = {
  #      enable = true;
  #      background = pkgs.nixos-artwork.wallpapers.nineish.gnomeFilePath;
  #      greeters = {
  #        gtk.enable = true;
  #      };
  #    };

  services.xserver.desktopManager.gnome.enable = true;

  # Awesome

  #  services.xserver.windowManager.awesome = {
  #    enable = true;
  #    luaModules = with pkgs.luaPackages; [
  #      luarocks # is the package manager for Lua modules
  #      luadbi-mysql # Database abstraction layer
  #    ];
  #  };

  # I3

  #environment.pathsToLink = [ "/libexec" ]; # links /libexec from derivations to /run/current-system/sw 
  #  services.xserver.windowManager.i3 = {
  #    enable = true;
  #    extraPackages = with pkgs; [
  #      i3status # gives you the default i3 status bar
  #      i3lock #default i3 screen locker
  #      i3blocks #if you are planning on using i3blocks over i3status
  #      polybar
  #    ];
  #  };

  # Qtile

  #services.xserver.windowManager.qtile = {
  #    enable = true;
  #  };


  #xdg.mime = {
  #    enable = true;
  #    defaultApplications = {
  #      "text/html" = "google-chrome-stable.desktop";
  #      "x-scheme-handler/http" = "google-chrome-stable.desktop";
  #      "x-scheme-handler/https" = "google-chrome-stable.desktop";
  #      "x-scheme-handler/about" = "google-chrome-stable.desktop";
  #      "x-scheme-handler/unknown" = "google-chrome-stable.desktop";
  #    };
  #  };

  # Configure keymap in X11
  services.xserver = {
    layout = "br";
    xkbVariant = "";
  };

  # Configure console keymap
  console.keyMap = "br-abnt2";

  # Enable CUPS to print documents.
  services.printing.enable = true;
  services.udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];

  # Enable sound with pipewire.
  # Pulseaudio + Pipewire
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Fonts
  fonts.fonts = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    meslo-lgs-nf
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users = {
    defaultUserShell = pkgs.bash;
    users.guifuentes8 = {
      isNormalUser = true;
      description = "Guilherme Fuentes";
      extraGroups = [ "networkmanager" "wheel" "video" ];
      shell = pkgs.zsh;
    };
  };

  # Enable automatic login for the user.
  services.xserver.displayManager.autoLogin.enable = true;
  services.xserver.displayManager.autoLogin.user = "guifuentes8";

  # Workaround for GNOME autologin: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = (with pkgs; [

    nvidia-offload
    # default 
    bitwarden
    davinci-resolve
    ffmpeg
    firefox-devedition-bin
    fragments
    gh
    git
    glxinfo
    google-chrome
    imagemagick
    nixpkgs-fmt
    nodejs
    obs-studio
    onlyoffice-bin
    pfetch
    sassc
    unzip
    vscode
    vim
    wget
    yarn

    # gnome

    contrast
    drawio
    discord
    foliate
    gaphor
    gnome-feeds
    marker
    mattermost-desktop
    pdfslicer
    slack

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

  programs.zsh = {
    enable = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    ohMyZsh = {
      enable = true;
      plugins = [ "git" ];
      theme = "af-magic";
    };
    shellAliases = {

      # Spotify
      #    spt = "ncspot";
      #    sptl = "sptlrx --current 'bold,#8be9fd' --before '#bd93f9,faint,italic,strikethrough' --after '#ff79c6,faint'";

      # TTY clock
      #    clock = "tty-clock -c -s -D";

      # Unimatrix
      #    matrix = "cmatrix";

      # Fetch 
      #    fetch = "pfetch";

      # Himalaya mail
      #    mail = "himalaya";
      #    mailsent = "mail -m '[Gmail]/Sent Mail'";
      #    maild = "mail attachments";
      #    mailw = "mail write";

      # Resolution control
      xr1920 = "xrandr --output DP-2 --mode 1920x1080 --rate 120";
      xr3840 = "xrandr --output DP-2 --mode 3840x1080 --rate 120";
      xr2560 = "xrandr --output DP-2 --mode 2560x1440 --rate 120";
      xr5120 = "xrandr --output DP-2 --mode 5120x1440 --rate 120";

      # Nixos system commands
      nixos-edit = "sudo vim /etc/nixos/configuration.nix";
      nixos-update = "sudo nixos-rebuild switch";
      nixos-upgrade = "sudo nixos-rebuild switch --upgrade";
      nixos-delete = "sudo nix-collect-garbage";
      nixos-clean = "sudo nix-store --optimise";

    };
  };



  # SYSTEM 

  # NixOs

  nix = {
    settings.auto-optimise-store = true;
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  # Automatic system upgrade

  system = {
    stateVersion = "22.05";
    autoUpgrade = {
      enable = true;
      allowReboot = true;
      dates = "daily";
    };
  };
}
