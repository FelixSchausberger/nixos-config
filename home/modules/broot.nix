{ lib, pkgs, ... }:

lib.mkDefault {
  programs.broot = {
    enable = true;
    settings.verbs = [
      {
        # Navigate to parent directory
        invocation = "p";
        execution = ":parent";
      }
      {
        # Edit file using specified editor
        invocation = "edit";
        shortcut = "e";
        execution = "$EDITOR {file}";
      }
      {
        # Create new file in specified directory
        invocation = "create {subpath}";
        execution = "$EDITOR {directory}/{subpath}";
      }
      {
        # View file using 'less' command
        invocation = "view";
        execution = "less {file}";
      }
      {
        # Custom verb for creating a directory and running a command
        invocation = "blop {name}\\.{type}";
        execution = ''
          mkdir {parent}/{type}
          && ${pkgs.helix}/bin/hx {parent}/{type}/{name}.{type}
        '';
        from_shell = true;
      }
    ];
  };
}

