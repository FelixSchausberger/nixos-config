{
  config,
  host,
  ...
}: {
  imports = [
    ./bash.nix
    ./fish.nix
    ./nushell.nix
  ];

  home.shellAliases = {
    build = "nix build -L";
    br = "broot";
    cat = "bat";
    # cd = "z";
    clone = "git clone";
    cleanup = "sudo nix store gc --debug"; # "sudo nix-collect-garbage";
    cp = "cp -rpv";
    fetch = "git fetch";
    gaa = "git add .";
    gcm = "git commit -m";
    gst = "git status";
    guiconfig = "hx ${config.home.homeDirectory}/.nixos/home/modules/gui/";
    homeconfig = "hx ${config.home.homeDirectory}/.nixos/home/default.nix";
    ll = "br -sdp";
    merge = "rsync -avhu --progress";
    nixconfig = "hx ${config.home.homeDirectory}/.nixos/configuration.nix";
    nixinfo = "nix-shell -p nix-info --run 'nix-info -m'";
    pull = "git pull";
    push = "git push";
    rebuild = "sudo nixos-rebuild --flake ${config.home.homeDirectory}/.nixos/#${host} switch";
    repair = "sudo nix-store --verify --check-contents --repair";
    rip = "rip --graveyard ${config.home.homeDirectory}/.local/share/Trash";
    tuiconfig = "hx ${config.home.homeDirectory}/.nixos/home/modules/tui/";
    wmconfig = "hx ${config.home.homeDirectory}/.nixos/home/modules/wm/";
    update = "sudo nix flake update ${config.home.homeDirectory}/.nixos"; # -I
    upgrade = "sudo nixos-rebuild --upgrade --flake ${config.home.homeDirectory}/.nixos/#${host} switch";
  };
}
