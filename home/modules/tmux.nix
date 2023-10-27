{ pkgs, ... }:

{
  home.packages = [
    pkgs.acpi  
    pkgs.bc
    pkgs.lm_sensors
  ];
  
  programs.tmux = {
    aggressiveResize = true;
    baseIndex = 1;
    enable = true;
    terminal = "screen-256color";
    clock24 = true;
    plugins = with pkgs; [
        # bind is u
        # https://github.com/NixOS/nixpkgs/blob/nixos-unstable/pkgs/misc/tmux-plugins/default.nix#L269
        tmuxPlugins.fzf-tmux-url
      ];
    customPaneNavigationAndResize = true;
    escapeTime = 0;
    historyLimit = 50000;
    extraConfig = ''
      # set -g status-interval 1
      # set -g window-status-separator " "
      set -g window-status-current-format ""
      set -g window-status-format ""

      set -g status-justify centre
      set -g status-left ""
      set -g status-right ""
      set-option -g status-style bg=default
    '';
  };
}
