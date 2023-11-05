{
  programs.wezterm = {
    enable = true;
    extraConfig = ''
      -- Your lua code / config here
      -- local mylib = require 'mylib';
      return {
        -- usemylib = mylib.do_fun();
        -- font = wezterm.font("Fira Code NF"),
        font_size = 14.0,
        color_scheme = "Tomorrow Night",
        hide_tab_bar_if_only_one_tab = true,
        window_background_opacity = 0.3,
      }
    '';
  };
}
