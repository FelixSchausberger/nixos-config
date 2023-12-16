{
  programs.starship = {
    enable = true;

    # https://starship.rs/config/#prompt
    settings = {
      git_status = {
        ahead = "⇡($count)";
        diverged = "⇕⇡($ahead_count)⇣($behind_count)";
        behind = "⇣($count)";
        modified = "!($count)";
        staged = "[++($count)](green)";
      };
    };
  };
}
