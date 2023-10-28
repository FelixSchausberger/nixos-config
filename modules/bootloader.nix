{
  boot = {
    loader = {
      systemd-boot = {
        enable = true;
        editor = false; # true allows gaining root access by passing init=/bin/sh as a kernel parameter
        consoleMode = "max";
      };

      efi.canTouchEfiVariables = true;
      timeout = 0;
    };

    supportedFilesystems = ["ntfs"];
    initrd.systemd.enable = true;
    kernelParams = ["quiet" "udev.log_level=3"];
  };
}
