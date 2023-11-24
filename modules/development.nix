{ pkgs, ... }: {
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
    nodePackages.bash-language-server   # Bash
    clang-tools                         # C/C++
    marksman                            # Markdown
    nil                                 # Nix
    python311Packages.python-lsp-server # Python
    rust-analyzer                       # Rust
    taplo                               # TOML
    yaml-language-server                # YAML
  ];
}

