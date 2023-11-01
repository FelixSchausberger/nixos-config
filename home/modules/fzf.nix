{
  programs.fzf = {
    enable = true;
    defaultOptions = [
      "--height 40%"
      "--layout=reverse"
      "--info=inline"
      "--border"
      "--margin=1"
      "--padding=1"
    ];
    tmux = {
      enableShellIntegration = true;
      shellIntegrationOptions = [
        "-p 80%,60%"
      ];
    };
  };
}
