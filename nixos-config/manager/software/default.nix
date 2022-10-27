{ pkgs, config, ... }:

let
in
{
  # Allow unfree software
  nixpkgs.config.allowUnfree = true;

  # Default software install
  environment.systemPackages =
    (with pkgs;
    [
      bitwarden
      davinci-resolve
      ffmpeg
      firefox-devedition-bin
      fragments
      gh
      git
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
    ]);

}
