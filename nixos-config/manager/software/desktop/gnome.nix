{ pkgs, ... }:

let
in
{

  # Gnome software install
  environment.systemPackages =
    (with pkgs; [
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
      spotify
    ])
    ++ (with pkgs.gnome;
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

}
