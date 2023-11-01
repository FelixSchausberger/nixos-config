{
  programs.zellij = {
    enable = true;
    settings = {
      theme = "nord";
      ui = {
        pane_frames = {
          hide_session_name = true;
          rounded_corners = true;
        };
      };
    };
  };
}
