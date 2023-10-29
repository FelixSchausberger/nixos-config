{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    # C env
    gcc
    gnumake

    # Python
    # jq
    python3

    # Rust
    cargo
    rustc

    # Language Servers
    nodePackages.bash-language-server # bash
    clang-tools # c / cpp
    marksman # markdown
    nil # nix
    python311Packages.python-lsp-server # python
    rust-analyzer # rust
    taplo # toml
    yaml-language-server # yaml
  ];
}
