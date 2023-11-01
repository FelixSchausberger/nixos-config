{host, ...}: {
  programs.nushell = {
    enable = true;
    configFile.text = ''
      let $config = {
        filesize_metric: false
        table_mode: rounded
        use_ls_colors: true
      }
    '';
    envFile.text = ''  
      $env.config = {
        show_banner: false
      }
    '';
    shellAliases = {
      br = "broot";
      cat = "bat";
      cd = "z";
      cleanup = "sudo nix-collect-garbage";
      cp = "cp -rpv";
      homeconfig = "hx ~/.nixos/home/default.nix";
      ls = "broot -sdp";
      merge = "rsync -avhu --progress";
      nixconfig = "hx ~/.nixos/configuration.nix";
      rebuild = "sudo nixos-rebuild --flake ~/.nixos/#${host} switch";
      # rip = "rip --graveyard $HOME/.local/share/Trash";
      swayconfig = "hx ~/.nixos/home/modules/sway/default.nix";
      upgrade = "rebuild --upgrade";
    };
  };
}
