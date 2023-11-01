{
  programs.tmux = {
    aggressiveResize = true;
    baseIndex = 1;
    enable = true;
    terminal = "screen-256color";
    customPaneNavigationAndResize = true;
    escapeTime = 0;
    historyLimit = 50000;
    extraConfig = ''
      set -g mouse on
      set -g window-status-current-format ""
      set -g window-status-format ""

      set -g status-justify centre
      set -g status-left ""
      set -g status-right ""
      set-option -g status-style bg=default
    '';
  };
}
