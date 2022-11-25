{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./home.nix
      ./software.nix
    ];

  # Boot and Kernel 
  boot = {
    loader = {
      grub = {
        version = 2;
        enable = true;
        useOSProber = true;
        efiSupport = true;
        default = "saved";
        device = "nodev";
      };
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot/efi";
      };
    };
    extraModulePackages = [ config.boot.kernelPackages.nvidia_x11 ]; # Extra modules in kernel
  };

  # Networking
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  # Sound
  sound.enable = true;
  security.rtkit.enable = true;

  # Console key
  console.keyMap = "br-abnt2";

  # Set your time zone.
  time.timeZone = "America/Sao_Paulo";

  # Select internationalisation properties.
  i18n = {
    defaultLocale = "en_US.utf8";
    extraLocaleSettings = {
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
  };

  # Fonts
  fonts.fonts = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    meslo-lgs-nf
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];

  # Services
  services = {
    flatpak.enable = true;
    printing.enable = true;
    udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];

    # Sound with Pipewire
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };

    # X11 / Display Manager / Desktop Manager / Window Manager
    xserver = {
      layout = "br";
      xkbVariant = "abnt2";
      enable = true;
      libinput.enable = true;
      displayManager = {
        gdm.enable = true;
        lightdm = {
          enable = false;
          background = pkgs.nixos-artwork.wallpapers.nineish.gnomeFilePath;
          greeters = {
            gtk.enable = false;
          };
        };
      };
      desktopManager = {
        gnome.enable = true;
      };
      windowManager = {
        i3 = {
          enable = false;
          extraPackages = with pkgs; [
            i3status
            i3lock
            i3blocks
            polybar
          ];
        };
        awesome = {
          enable = false;
          luaModules = with pkgs.luaPackages; [
            luarocks
            luadbi-mysql
          ];
        };
        qtile = {
          enable = false;
        };
      };
      videoDrivers = [ "nvidia" "nomodeset" ];
      deviceSection = ''
        Option "DRI" "2"
        Option "TearFree" "true"
      '';
      screenSection = ''
        Option         "metamodes" "nvidia-auto-select +0+0 {ForceFullCompositionPipeline=On}"
        Option         "AllowIndirectGLXProtocol" "off"
        Option         "TripleBuffer" "on"
      '';
    };
  };

  # Hardware
  hardware = {
    opengl.enable = true;
    pulseaudio.enable = false; # Pulseaudio soundcard

    # Nvidia
    nvidia = {
      modesetting.enable = true;
      powerManagement.enable = true;
      nvidiaPersistenced = true;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
    };
  };

  # User
  users = {
    defaultUserShell = pkgs.bash;
    users.guifuentes8 = {
      isNormalUser = true;
      description = "Guilherme Fuentes";
      extraGroups = [ "networkmanager" "wheel" "video" ];
      shell = pkgs.zsh;
    };
  };

  # Environment
  environment = {
    pathsToLink = [ "/libexec" ]; # links /libexec from derivations to /run/current-system/sw 
  };

  # Garbage collector
  nix = {
    settings.auto-optimise-store = true;
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  # System config and auto update
  system = {
    stateVersion = "22.05";
    autoUpgrade = {
      enable = true;
      allowReboot = false;
      dates = "daily";
    };
  };
}
