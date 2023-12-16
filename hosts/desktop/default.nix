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

  # Uncomment the following lines to customize the console keymap
  # environment.etc."vconsole.conf".text = ''
  #   KEYMAP=eu
  # '';
  # console.keyMap = "eu";
}

