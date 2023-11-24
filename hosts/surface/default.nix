{ pkgs, ... }:

{
  # Set kernel parameters
  boot.kernelParams = [ "i915.force_probe=5916" ];

  # Override vaapiIntel with enableHybridCodec
  nixpkgs.config.packageOverrides = pkgs: {
    vaapiIntel = pkgs.vaapiIntel.override { enableHybridCodec = true; };
  };

  # Configure additional OpenGL packages
  hardware.opengl = {
    extraPackages = with pkgs; [
      intel-media-driver  # LIBVA_DRIVER_NAME=iHD
      vaapiIntel          # LIBVA_DRIVER_NAME=i965 (older, better for Firefox/Chromium)
      vaapiVdpau
      libvdpau-va-gl
    ];
  };

  # Set the hostname
  networking.hostName = "surface";

  # Configure console keymap
  console.keyMap = "de";
}
