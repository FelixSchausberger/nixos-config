{ pkgs, ... }:
{
  environment = {
    systemPackages = with pkgs; [
      bash
      leftwm
      xorg
      # xorg.xinit
    ];
  };

  services.xserver = {
    enable = true;
    videoDrivers = [ "amdgpu" ];
  };
}
