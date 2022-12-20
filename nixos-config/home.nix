{ config, pkgs, lib, ... }:
let
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/release-22.11.tar.gz";
  tokyo-night = pkgs.callPackage ./pkgs/build/tokyo-night.nix { };
in
{
  imports = [
    (import "${home-manager}/nixos")
  ];

  home-manager.users.guifuentes8 = {
    home.stateVersion = "22.11";
    gtk = {
      enable = true;
      cursorTheme.name = "Bibata-Modern-Ice";
      cursorTheme.package = pkgs.bibata-cursors;
      theme.package = tokyo-night;
      theme.name = "Tokyonight-Dark-B";
    };
  };

  programs = {
    dconf.enable = true;
    steam = {
      enable = true;
      remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
      dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    };
    zsh = {
      enable = true;
      autosuggestions.enable = true;
      syntaxHighlighting.enable = true;
      shellInit = ''
        unset -v SSH_ASKPASS
      '';
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
  };



  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "steam"
    "steam-original"
    "steam-runtime"
  ];


  # xdg.mime = {
  #    enable = true;
  #    defaultApplications = {
  #      "text/html" = "google-chrome-stable.desktop";
  #      "x-scheme-handler/http" = "google-chrome-stable.desktop";
  #      "x-scheme-handler/https" = "google-chrome-stable.desktop";
  #      "x-scheme-handler/about" = "google-chrome-stable.desktop";
  #      "x-scheme-handler/unknown" = "google-chrome-stable.desktop";
  #    };
  #  };

}
