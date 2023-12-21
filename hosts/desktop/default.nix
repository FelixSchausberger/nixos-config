{ pkgs, ... }: {

  # Enable 32-bit support for Direct Rendering Infrastructure (DRI)
  hardware.opengl = {
    driSupport32Bit = true;
    extraPackages = with pkgs; [
      rocm-opencl-icd
      rocm-opencl-runtime
    ];
  };

  networking.hostName = "Desktop";

  # environment.etc."vconsole.conf".text = ''
  #   KEYMAP=eu
  # '';
  # console.keyMap = "eu";
}

