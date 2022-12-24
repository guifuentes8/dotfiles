{ pkgs, ... }:
let
  yarn-16-18 = pkgs.callPackage ../build/yarn-16-18.nix { };
in
{
  environment.systemPackages = (with pkgs; [
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
    #nodejs-16_x
    nodejs
    nodePackages.expo-cli
    docker-compose
    lsof
    nixpkgs-fmt
    yarn-16-18
  ]);
}
