{ pkgs, ... }:
{
  # Import configurations of tty applications
  imports = [
    ./bat.nix
    ./broot.nix
    ./direnv.nix
    ./fzf.nix
    ./git.nix
    ./helix.nix
    ./i2p.nix
    ./nushell.nix
    ./rbw.nix
    ./starship.nix
    ./tealdeer.nix
    ./topgrade.nix
    ./zoxide.nix
  ];

  # Enable tty applications
  programs = {
    bottom.enable = true;
    home-manager.enable = true;
    nix-index.enable = true;
    ripgrep.enable = true;
    ssh.enable = true;
  };

  # Add packages
  home = {
    packages = with pkgs; [
      fd
      ouch
      procs
      rm-improved
      ripgrep-all
      tgpt
      typst
      unzip
      wl-clipboard
    ];
  };

  services = {
    cliphist.enable = true;
    lorri.enable = true;
    playerctld.enable = true;
  };
}
