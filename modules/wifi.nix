{ secrets, ... }:

{
  networking.networkmanager = {
    enable = true;
    # wireless.enable = true;  # Enable wireless support

    # WiFi configuration
    wireless.networks = {
      Pretty-Fly-For-A-WiFi = {
        key = "${secrets.wifi.pretty-fly-for-a-wifi}";
      };
      Hochbau-Talstation = {
        key = "${secrets.wifi.hochbau-talstation}";
      };
    };
  };
}

