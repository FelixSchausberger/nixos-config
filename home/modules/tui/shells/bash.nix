{pkgs, ...}: {
  programs.bash = {
    enable = true;
    profileExtra = "
      if [ \"$(tty)\" == \"/dev/tty1\" ]; then
        Hyprland
      fi
    ";

    initExtra = ''
      if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != \"fish\" && -z ''${BASH_EXECUTION_STRING} ]]
      then
        shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
        exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
      fi
    '';
  };
}
