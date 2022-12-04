{ config, pkgs, ... }:

let
  nvidia-offload = pkgs.writeShellScriptBin "nvidia-offload" ''
    export __NV_PRIME_RENDER_OFFLOAD=1
    export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
    export __GLX_VENDOR_LIBRARY_NAME=nvidia
    export __VK_LAYER_NV_optimus=NVIDIA_only
    exec "$@"
  '';
in
{
  imports =
    [ ];

  # Boot and Kernel 
  boot = {
    kernelPackages = pkgs.linuxPackages_latest; # Latest kernel 
    kernelParams = [ "i915.force_probe=46a6" ]; # Intel 12th generation required kernel params
  };

  # Hardware
  hardware = {
    # Nvidia
    nvidia = {
      powerManagement.finegrained = true;
      prime = {
        offload.enable = true;
        nvidiaBusId = "PCI:1:0:0";
        intelBusId = "PCI:0:2:0";
      };
    };
  };

  # Environment
  environment = {
    systemPackages = with pkgs; [
      nvidia-offload
    ];
  };
}
