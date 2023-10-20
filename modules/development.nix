{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # C env
    gcc
    gnumake

    # Python
    jq
    python3

    # Rust
    cargo
    rustc

    # Language Servers
    rnix-lsp # nix
    clang-tools # c / cpp
  ];
}
