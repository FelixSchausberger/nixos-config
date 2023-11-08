{ host, ... }: {
  programs.nushell = {
    enable = true;
    envFile.text = ''  
      $env.config = {
        show_banner: false
      }
    '';
    loginFile.text = ''
      if (tty) == "/dev/tty1" {
        sway
      }
    '';
    shellAliases = {
      br = "broot";
      cat = "bat";
      cd = "z";
      cleanup = "sudo nix-collect-garbage";
      cp = "cp -rpv";
      fetch = "git fetch";
      gaa = "git add .";
      gcm = "git commit -m";
      gst = "git status";
      homeconfig = "hx ~/.nixos/home/default.nix";
      ll = "br -sdp";
      merge = "rsync -avhu --progress";
      nixconfig = "hx ~/.nixos/configuration.nix";
      pull = "git pull";
      push = "git push";
      rebuild = "sudo nixos-rebuild --flake ~/.nixos/#${host} switch";
      rip = "rip --graveyard ~/.local/share/Trash";
      swayconfig = "hx ~/.nixos/home/modules/sway/default.nix";
      update = "nix flake update -I ~/.nixos";
      upgrade = "rebuild --upgrade";
    };
  };
}
