{
  # Import configurations of tty applications
  imports = [
    ./modules/bat.nix
    ./modules/broot.nix
    ./modules/cliphist.nix
    ./modules/fzf.nix
    ./modules/git.nix
    ./modules/helix.nix
    ./modules/nushell.nix
    ./modules/rbw.nix
    ./modules/rclone.nix
    ./modules/starship.nix
    ./modules/tealdeer.nix
    ./modules/topgrade.nix
  ];

  # Enable tty applications
  programs = {
    bottom.enable = true;
    nix-index.enable = true;
    ripgrep.enable = true;
    ssh.enable = true;
    zoxide.enable = true;
  };
}
