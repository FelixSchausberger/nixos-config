{ pkgs, secrets, ... }:

{
  home.packages = with pkgs; [
    git-crypt
    pre-commit
  ];

  programs.git = {
    enable = true;
    userName = "Felix Schausberger";
    userEmail = "fel.schausberger@gmail.com";
    delta = { enable = true; };
    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = false;
      config.credential.helper = "libsecret";
      core.editor = "${pkgs.helix}/bin/hx";
      url = {
        "https://oauth2:${secrets.github.oauth_token}@github.com" = {
          insteadOf = "https://github.com";
        };
      };
    };
    # alises = {
    #   clone = "git clone";
    #   fetch = "git fetch";
    #   gst = "git status";
    #   pull = "git pull";
    #   push = "git push";
    # };
  };
}
