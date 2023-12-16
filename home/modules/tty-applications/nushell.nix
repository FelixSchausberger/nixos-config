{ config, host, ... }:

{
  programs.nushell = {
    enable = true;
    envFile.text = ''
      $env.config = { show_banner: false };
    '';

    loginFile.text = ''
      if (tty) == "/dev/tty1" { sway };
    '';

    # Move to home config once https://github.com/nushell/nushell/issues/10088 is closed 
    shellAliases = {
      build = "nix build -L";
      br = "broot";
      cat = "bat";
      cd = "z";
      clone = "git clone";
      cleanup = "sudo nix-collect-garbage";
      cp = "cp -rpv";
      fetch = "git fetch";
      gaa = "git add .";
      gcm = "git commit -m";
      gst = "git status";
      homeconfig = "hx ${config.home.homeDirectory}/.nixos/home/default.nix";
      ll = "br -sdp";
      merge = "rsync -avhu --progress";
      nixconfig = "hx ${config.home.homeDirectory}/.nixos/configuration.nix";
      nixinfo = "nix-shell -p nix-info --run 'nix-info -m'";
      pull = "git pull";
      push = "git push";
      rebuild = "sudo nixos-rebuild --flake ${config.home.homeDirectory}/.nixos/#${host} switch";
      rip = "rip --graveyard ${config.home.homeDirectory}/.local/share/Trash";
      swayconfig = "hx ${config.home.homeDirectory}/.nixos/home/modules/sway/";
      update = "nix flake update ${config.home.homeDirectory}/.nixos"; # -I
      upgrade = "sudo nixos-rebuild --upgrade --flake ${config.home.homeDirectory}/.nixos/#${host} switch";
    };
  };
}
