########## CONFIGURATION.NIX ##########

{ config, pkgs, ... }:

let
in
{
  imports =
    [
      ./hardware-configuration.nix
      ./modules/services.nix
      ./modules/bluetooth.nix
      ./window-manager/wayland/default.nix
      ./software/default.nix
      ./home-manager/home.nix
    ];

  ##### SYSTEM BASE CONFIGURATION #####

  # Keyboard format
  console.keyMap = "br-abnt2";

  # Systemd boot loader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  # NetworkManager
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  # TimeZone
  time.timeZone = "America/Sao_Paulo";

  # Locale
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


  # Automatic system upgrade
  system = {
    stateVersion = "22.05";
    autoUpgrade = {
      enable = true;
      allowReboot = true;
      dates = "daily";
    };
  };

  # Automatic garbage collector
  nix = {
    settings.auto-optimise-store = true;
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
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

  ##### USER BASE CONFIGURATION #####

  # Config
  users = {
    defaultUserShell = pkgs.bash;
    users.guifuentes8 = {
      isNormalUser = true;
      description = "Guilherme Fuentes";
      extraGroups = [ "networkmanager" "wheel" ];
      shell = pkgs.zsh;
    };
  };
}
