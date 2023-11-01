{
  programs.bash = {
    enable = true;
    enableCompletion = true;
    bashrcExtra = ''
      if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
        tmux a -t default || exec tmux new -s default && exit;
      fi

      if [[ $- == *i* ]]; then # in interactive session
        set -o vi
      fi
    '';
  };
}
