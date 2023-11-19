{ pkgs, ... }:
{
  environment = {
    systemPackages = with pkgs; [
      bash
      leftwm
      xorg.libX11
      xorg.libXinerama
      xorg.xrandr
      xorg.xorgserver
    ];
  };

  services.xserver = {
    enable = true;
    videoDrivers = [ "amdgpu" ];
  };
}
