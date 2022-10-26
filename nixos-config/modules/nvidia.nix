{ pkgs, config, ... }:

let
in
{
  services.xserver = {
    videoDrivers = [ "nvidia" ];
    screenSection = ''
      Option "metamodes" "nvidia-auto-select +0+0 {ForceFullCompositionPipeline=On}"
      Option "AllowIndirectGLXProtocol" "off"
      Option "TripleBuffer" "on"
    '';

  };
  # Nvidia extra options
  hardware.opengl.enable = true;
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;
}
