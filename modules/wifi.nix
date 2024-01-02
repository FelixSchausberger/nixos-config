{ secrets, ... }:

{
  networking = {
    networkmanager.enable = true;

    # WiFi configuration
    wireless = {
      enable = true;

      networks = {
        Pretty-Fly-For-A-WiFi = {
          key = "${secrets.wifi.pretty-fly-for-a-wifi}";
        };

        Hochbau-Talstation = {
          key = "${secrets.wifi.hochbau-talstation}";
        };
      };
    };
  };
}

