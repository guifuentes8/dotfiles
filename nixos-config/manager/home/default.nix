{ pkgs, ... }:

let
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/release-22.05.tar.gz";
in
{
  imports =
    [
      (import "${home-manager}/nixos")
      ./zsh.nix
    ];

  xdg.mime = {
    enable = true;
    defaultApplications = {
      "text/html" = "google-chrome-stable.desktop";
      "x-scheme-handler/http" = "google-chrome-stable.desktop";
      "x-scheme-handler/https" = "google-chrome-stable.desktop";
      "x-scheme-handler/about" = "google-chrome-stable.desktop";
      "x-scheme-handler/unknown" = "google-chrome-stable.desktop";
    };
  };
}
