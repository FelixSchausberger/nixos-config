{ secrets, ... }:

{
  networking = {
    networkmanager.enable = true;

    # WiFi configuration
    wireless = {
      # enable = true;

      networks = {
        Pretty-Fly-For-A-WiFi = {
          psk = "${secrets.wifi.pretty-fly-for-a-wifi}";
        };

        Hochbau-Talstation = {
          psk = "${secrets.wifi.hochbau-talstation}";
        };
      };
    };
  };
}

