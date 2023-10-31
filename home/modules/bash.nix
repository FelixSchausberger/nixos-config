{ host, pkgs, ... }: {
  programs.bash = {
    enable = true;
    enableCompletion = true;
    shellAliases = {
      c = "clear";
      cat = "bat";
      cd = "z";
      cleanup = "sudo nix-collect-garbage";
      cp = "cp -rpv";
      df = "df -h";
      # docker = "podman";
      fetch = "git fetch";
      find =
        "echo 'This is not the command you are looking for, use fd instead.'; false";
      gaa = "git add .";
      gcm = "git commit -m";
      gst = "git status";
      homeconfig = "hx ~/.nixos/home/default.nix";
      ls = "eza --icons";
      merge = "rsync -avhu --progress";
      mkdir = "mkdir -p";
      nixconfig = "hx ~/.nixos/configuration.nix";
      pull = "git pull";
      push = "git push";
      rebuild = "sudo nixos-rebuild --flake ~/.nixos/#${host} switch";
      # rm = "echo 'This is not the command you are looking for, use rip instead.'; false";
      rip = "rip --graveyard $HOME/.local/share/Trash";
      swayconfig = "hx ~/.nixos/home/modules/sway.nix";
      upgrade = "rebuild --upgrade";
    };

    bashrcExtra = ''
      source ${pkgs.blesh}/share/blesh/ble.sh

      if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
        tmux a -t default || exec tmux new -s default && exit;
      fi

      if [[ $- == *i* ]]; then # in interactive session
        set -o vi
      fi
    '';
  };
}
