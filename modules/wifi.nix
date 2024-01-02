{ secrets, ... }:

{
  networking.networkmanager = {
    enable = true;
    # wireless.enable = true;  # Enable wireless support

    # WiFi configuration
    wireless.networks = {
      Pretty-Fly-For-A-WiFi = {
        key = "${secrets.pretty-fly-for-a-wifi.password}";
      };
      Hochbau-Talstation = {
        key = "${secrets.hochbau-talstation.password}";
      };
    };
  };
}

