{ config
, pkgs
, ...
}:
let
  gnomeSettings = "${pkgs.glib}/bin/gsettings";
in
{
  xdg.configFile."sway/environment".source = ./sway-environment.nix;

  home.packages = with pkgs; [
    slurp
    swayimg
  ];

  wayland.windowManager.sway = {
    enable = true;
    package = pkgs.swayfx;
    wrapperFeatures.gtk = true;

    config = rec {
      terminal = "${pkgs.wezterm}/bin/wezterm";
      menu = "exec ${terminal} start --class=floating-mode ${scripts/result/bin/launcher}";
      modifier = "Mod4";

      startup = [
        { command = "${pkgs.autotiling}/bin/autotiling"; }
        { command = "${gnomeSettings} set org.gnome.desktop.interface gtk-theme 'Adwaita-dark"; }
        { command = "${gnomeSettings} set org.gnome.desktop.interface icon-theme 'Adwaita"; }
        { command = "exec ${pkgs.swayest-workstyle}/bin/sworkstyle &> /tmp/sworkstyle.log"; }
      ];

      output = {
        "*" = { bg = "${../../wallpaper.jpg} fill"; };
      };

      seat = {
        "*" = {
          hide_cursor = "10000";
          xcursor_theme = "breeze_cursors 10";
        };
      };

      window.commands = [
        { criteria = { app_id = "pavucontrol"; }; command = "floating enable"; }
        { criteria = { class = "Steam"; }; command = "floating enable"; }
      ];

      modes = {
        resize = {
          h = "resize shrink width 25px";
          j = "resize grow height 25px";
          k = "resize shrink height 25px";
          l = "resize grow width 25px";

          Left = "resize shrink width 25px";
          Down = "resize grow height 25px";
          Up = "resize shrink height 25px";
          Right = "resize grow width 25px";

          Return = "mode \"default\"";
          Escape = "mode \"default\"";
        };
      };

      bars = [{
        # command = "waybar";
        command = "i3status-rs";
        mode = "hide";
      }];

      gaps.inner = 10;

      floating.border = 3;
      window.border = 3;
      window.titlebar = false;

      colors = {
        focused = {
          background = "#181818"; # "#${config.colorScheme.colors.base00}";
          border = "#1a1a1a"; # "#${config.colorScheme.colors.base00}";
          childBorder = "#1a1a1a"; # "#${config.colorScheme.colors.base00}";
          indicator = "#1a1a1a"; # "#${config.colorScheme.colors.base00}";
          text = "#b7bcb9";
        };
        focusedInactive = {
          background = "#181818"; # "#${config.colorScheme.colors.base00}";
          border = "#1a1a1a"; # "#${config.colorScheme.colors.base00}";
          childBorder = "#1a1a1a"; # "#${config.colorScheme.colors.base00}";
          indicator = "#1a1a1a"; # "#${config.colorScheme.colors.base00}";
          text = "#b7bcb9";
        };
        unfocused = {
          background = "#181818"; # "#${config.colorScheme.colors.base00}";
          border = "#1a1a1a"; # "#${config.colorScheme.colors.base00}";
          childBorder = "#1a1a1a"; # "#${config.colorScheme.colors.base00}";
          indicator = "#1a1a1a"; # "#${config.colorScheme.colors.base00}";
          text = "#b7bcb9";
        };
        urgent = {
          background = "#${config.colorScheme.colors.base08}";
          border = "#${config.colorScheme.colors.base08}";
          childBorder = "#${config.colorScheme.colors.base08}";
          indicator = "#${config.colorScheme.colors.base08}";
          text = "#b7bcb9";
        };
      };
    };
  };
}
