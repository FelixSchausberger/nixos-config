{ pkgs ? import <nixpkgs> {} }:

with pkgs;
let nixBin = writeShellScriptBin "nix" ''
  ${nixFlakes}/bin/nix --option experimental-features "nix-command flakes" "$@"
'';

in mkShell {
  nativeBuildInputs = with pkgs; [ rustc cargo gcc rustfmt clippy ];
  
  buildInputs = [ git ];
  
  shellHook = ''
    export FLAKE="$(pwd)"
    export PATH="$FLAKE/bin:${nixBin}/bin:$PATH"
  '';

  # Certain Rust tools won't work without this
  # This can also be fixed by using oxalica/rust-overlay and specifying the rust-src extension
  # See https://discourse.nixos.org/t/rust-src-not-found-and-other-misadventures-of-developing-rust-on-nixos/11570/3?u=samuela. for more details.
  RUST_SRC_PATH = "${pkgs.rust.packages.stable.rustPlatform.rustLibSrc}";
}
