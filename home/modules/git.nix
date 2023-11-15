{ secrets, ... }:
{
  programs.git = {
    enable = true;
    userName = "Felix Schausberger";
    userEmail = "fel.schausberger@gmail.com";
    delta = { enable = true; };
    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = false;
      config.credential.helper = "libsecret";
      url = {
        "https://oauth2:${secrets.github.oauth_token}@github.com" = {
          insteadOf = "https://github.com";
        };
      };
    };
  };
}
