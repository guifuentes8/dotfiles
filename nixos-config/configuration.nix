{ config, pkgs, ... }:
{
  imports =
    [
      ./hardware-configuration.nix
      #./modules/notebook-prime/default.nix
      ./services/default.nix
      ./home/default.nix
      ./pkgs/default.nix
    ];

  # Boot and Kernel 
  boot = {
    loader = {
      # systemd-boot.enable = true;
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
    postgresql = {
      enable = true;
      package = pkgs.postgresql_15;
    };
    flatpak.enable = true;
    teamviewer.enable = true;
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
      excludePackages = [ pkgs.xterm ];
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
      extraGroups = [ "networkmanager" "wheel" "video" "docker" "adbusers" ];
      shell = pkgs.zsh;
    };
  };



  # Environment
  environment = {
    pathsToLink = [ "/libexec" ]; # links /libexec from derivations to /run/current-system/sw 
    sessionVariables = rec {
      XDG_CACHE_HOME = "\${HOME}/.cache";
      XDG_CONFIG_HOME = "\${HOME}/.config";
      XDG_BIN_HOME = "\${HOME}/.local/bin";
      XDG_DATA_HOME = "\${HOME}/.local/share";
      # Steam needs this to find Proton-GE
      STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/root/compatibilitytools.d";
      # note: this doesn't replace PATH, it just adds this to it
      PATH = [
        "\${XDG_BIN_HOME}"
      ];
    };
  };

  # Garbage collector
  nix = {
    settings.auto-optimise-store = true;
    gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 4d";
    };
  };

  # System config and auto update
  system = {
    stateVersion = "22.11";
    autoUpgrade = {
      enable = true;
      channel = "https://nixos.org/channels/nixos-22.11";
      allowReboot = true;
      dates = "12:30";
    };
  };
}
