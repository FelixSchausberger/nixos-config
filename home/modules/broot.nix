{ pkgs, ... }:
{
  programs.broot = {
    enable = true;
    settings.verbs = [
      { invocation = "p"; execution = ":parent"; }
      { invocation = "edit"; shortcut = "e"; execution = "$EDITOR {file}" ; }
      { invocation = "create {subpath}"; execution = "$EDITOR {directory}/{subpath}"; }
      { invocation = "view"; execution = "less {file}"; }
      {
        invocation = "blop {name}\\.{type}";
        execution = "mkdir {parent}/{type} && ${pkgs.helix}/bin/hx {parent}/{type}/{name}.{type}";
        from_shell = true;
      }
    ];
  };
}
