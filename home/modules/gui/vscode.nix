{ pkgs, ... }:
{
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      kamadorueda.alejandra
      ms-python.black-formatter
      llvm-vs-code-extensions.vscode-clangd
      bbenoist.nix
      tomoki1207.pdf
      esbenp.prettier-vscode
      rust-lang.rust-analyzer
      # nvarner.typst-lsp
      redhat.vscode-yaml
    ];
  };
}
