{ config, ... }:

{
  wayland.windowManager.sway.extraConfig = ''
    # Bar configuration
    bar {
      swaybar_command waybar
      mode hide
      hidden_state show
      hidden_state hide
    }
    
    # bar {
    #   font pango:FiraCode Nerd Font, FontAwesome 6 Free 16
    #   position bottom
    #   status_command i3status-rs ${config.home.homeDirectory}/.config/i3status-rust/config-bottom.toml
    #   mode hide
    #   hidden_state show
    #   hidden_state hide
    #   colors {
    #     separator #666666
    #     background #181818
    #     statusline #dddddd
    #     focused_workspace #0088CC #0088CC #ffffff
    #     active_workspace #333333 #333333 #ffffff
    #     inactive_workspace #181818 #181818 #888888
    #     urgent_workspace #2f343a #900000 #ffffff
    #   }
    # }

    # Window rules
    for_window [class="."] inhibit_idle fullscreen
    for_window [app_id="."] inhibit_idle fullscreen
    for_window [app_id="floating-mode"] floating enable

    # SwayFX settings
    shadows enable
    corner_radius 12
    blur enable
    blur_radius 7
    blur_passes 4

    # Layer effects
    layer_effects "gtk-layer-shell" blur enable; shadows enable; corner_radius 12
    layer_effects "ironbar" blur enable; shadows enable; corner_radius 12
    layer_effects "notifications" blur enable; shadows enable; corner_radius 12
    # layer_effects "panel" blur enable; shadows enable; corner_radius 12
  '';
}
