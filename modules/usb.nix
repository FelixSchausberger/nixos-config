{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    usbutils
    udiskie
    udisks
  ];

  services = {
    gvfs.enable = true;
    udisks2.enable = true;
  };
}
