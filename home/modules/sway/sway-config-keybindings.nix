{ pkgs, ... }:

let
  audioControl = "${pkgs.wireplumber}/bin/wpctl";
  browser = "${pkgs.firefox}/bin/firefox";
  dunst = "${pkgs.dunst}/bin/dunstctl";
  mod = "Mod4";
  playerctl = "${pkgs.playerctl}/bin/playerctl";
  terminal = "${pkgs.wezterm}/bin/wezterm";
in
{
  wayland.windowManager.sway.config.keybindings = pkgs.lib.mkOptionDefault {
    "${mod}+w" = "kill";
    "${mod}+t" = "layout tabbed";

    # Application launcher
    "${mod}+a" = "exec ${pkgs.nwg-drawer}/pkgs/nwg-drawer";

    # Browser
    "${mod}+b" = "exec ${browser}";

    # Clipboard pickers
    "${mod}+v" = "exec ${terminal} start --class=floating-mode ${scripts/result/bin/cliphist}";

    # Cycle through workspaces
    "${mod}+tab" = "workspace next_on_output";
    "${mod}+Shift+tab" = "workspace prev_on_output";

    # File Manager
    "${mod}+e" = "exec ${terminal} start --class=floating-mode ${pkgs.broot}/pkgs/broot";

    # Find
    "${mod}+space" = "exec ${terminal} start --class=floating-mode ${pkgs.ripgrep-all}/pkgs/rga-fzf";

    # Manual lock
    "--release ${mod}+l" = "exec loginctl lock-session";

    # Multimedia
    "--locked XF86AudioRaiseVolume" = "exec ${audioControl} set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+";
    "--locked XF86AudioLowerVolume" = "exec ${audioControl} set-volume @DEFAULT_AUDIO_SINK@ 5%-";
    "--locked XF86AudioMute" = "exec ${audioControl} set-mute @DEFAULT_AUDIO_SINK@ toggle";
    "--locked XF86AudioPlay" = "exec ${playerctl} play-pause";
    "--locked XF86AudioNext" = "exec ${playerctl} next";
    "--locked XF86AudioPrev" = "exec ${playerctl} previous";

    # Move focused window
    "${mod}+Shift+h" = "move left";
    "${mod}+Shift+j" = "move down";
    "${mod}+Shift+k" = "move up";
    "${mod}+Shift+l" = "move right";
    # Ditto, with arrow keys
    "${mod}+Shift+Left" = "move left";
    "${mod}+Shift+Down" = "move down";
    "${mod}+Shift+Up" = "move up";
    "${mod}+Shift+Right" = "move right";

    # Notification daemon
    "Control+Space" = "exec ${dunst} close";
    "Control+Shift+Space" = "exec ${dunst} close-all";
    "Control+m" = "exec ${dunst} set-paused toggle";

    # Scratchpad
    "${mod}+Shift+minus" = "move scratchpad";
    "${mod}+minus" = "scratchpad show";

    # Screenshots
    "Print" = "exec ${pkgs.shotman}/pkgs/shotman --capture region --copy";

    # Show waybar
    "${mod}" = "swaymsg bar hidden_state show";
  };
}
