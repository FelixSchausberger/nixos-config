{
  programs.helix = {
    enable = true;
    settings = {
      editor = {
        gutters = [ "diff" "line-numbers" "spacer" "diagnostics" ];
        cursorline = true;
        cursor-shape.insert = "bar";
        true-color = true;
        lsp.display-messages = true;
        mouse = false;
      };
      theme = "charm";
      keys = {
        insert = { esc = [ "collapse_selection" "normal_mode" ]; };
        normal = {
          esc = [ "collapse_selection" "normal_mode" ];
          X = "extend_line_above";
          a = [ "append_mode" "collapse_selection" ];
          g.q = ":reflow";
          i = [ "insert_mode" "collapse_selection" ];
          ret = [ "move_line_down" "goto_line_start" ];
          space = {
            w = ":write";
            q = ":quit";
          };
        };
        select = { esc = [ "collapse_selection" "keep_primary_selection" "normal_mode" ]; };
      };
    };
    languages = {
      language = [
        { name = "bash"; auto-format = true; }
        { name = "nix"; auto-format = true; formatter = { command = "alejandra"; }; }
        { name = "markdown"; auto-format = true; }
        { name = "python"; auto-format = true; }
        { name = "rust"; auto-format = true; formatter = { command = "clippy"; }; }
        { name = "toml"; auto-format = true; formatter = { command = "taplo fmt"; }; }
        { name = "typst"; auto-format = true; }
        { name = "yaml"; auto-format = true; }
      ];
    };
  };
}
