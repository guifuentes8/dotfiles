{ pkgs, ... }:

{

  environment.systemPackages = (with pkgs; [
    contrast
    endeavour
    foliate
    gaphor
    gnome-feeds
    marker
    pdfslicer

  ]) ++ (with pkgs.gnome;
    [
      gnome-themes-extra
      gnome-tweaks
      gnome-boxes
    ]);

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
}
