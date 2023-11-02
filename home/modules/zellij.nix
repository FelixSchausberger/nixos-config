{
  programs.zellij = {
    enable = true;
    settings = {
      pane_frames = false;      
    };
  };

  home.file.".config/zellij/layouts/default.kdl".text = ''
    layout {
      pane    
    }
    '';
}
