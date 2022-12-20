{ pkgs, ... }:
{
  imports =
    [
      ./nvidia-offload.nix
    ];

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


}
