{ pkgs, ... }: {
  hardware.opengl = {
    driSupport32Bit = true;
    extraPackages = with pkgs; [
      rocm-opencl-icd
      rocm-opencl-runtime
    ];
  };

  networking.hostName = "desktop";

  # Configure console keymap
  # environment.etc."vconsole.conf".text = ''
  #   KEYMAP=eu
  # '';
  # console.keyMap = "eu";
}
