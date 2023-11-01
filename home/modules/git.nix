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
    };
    aliases = {
      fetch = "git fetch";
      gaa = "git add .";
      gcm = "git commit -m";
      gst = "git status";
      pull = "git pull";
      push = "git push";
    };
  };
}
