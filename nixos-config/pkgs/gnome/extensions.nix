{ pkgs, ... }:
{
  environment.systemPackages = (with pkgs.gnomeExtensions; [
    appindicator
    caffeine
    clipboard-history
    color-picker
    color-app-menu-icon-for-gnome-40
    docker
    emoji-selector
    force-quit
    gnome-40-ui-improvements
    gsconnect
    lock-keys
    middle-click-to-close-in-overview
    mpris-label
    muteunmute
    notification-timeout
    no-activities-button
    remove-alttab-delay-v2
    show-desktop-button
    tactile
    task-widget
    vitals
    wayland-or-x11
  ]);
}
