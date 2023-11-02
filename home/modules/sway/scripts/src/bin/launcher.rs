use std::process::{exit, Command};

fn main() {
    let opts = "--info=inline --print-query --bind=ctrl-space:print-query,tab:replace-query";

    let fzf_result = Command::new("fzf")
        .args(opts.split_whitespace())
        .stdin(std::process::Stdio::piped())
        .stdout(std::process::Stdio::piped())
        .spawn()
        .expect("Failed to start fzf process");

    let compgen_result = Command::new("compgen")
        .arg("-c")
        .stdout(std::process::Stdio::piped())
        .spawn()
        .expect("Failed to start compgen process");

    let fzf_stdout = fzf_result.stdout.expect("Failed to get fzf stdout");
    let compgen_stdout = compgen_result.stdout.expect("Failed to get compgen stdout");

    let last_command = std::io::BufReader::new(fzf_stdout)
        .lines()
        .filter_map(|line| line.ok())
        .last()
        .unwrap_or_else(|| {
            eprintln!("No command selected in fzf");
            exit(1);
        });

    let exec_command = format!("exec --no-startup-id {}", last_command);
    let swaymsg_result = Command::new("swaymsg")
        .arg("-q")
        .arg(&exec_command)
        .status()
        .expect("Failed to execute swaymsg");

    if !swaymsg_result.success() {
        eprintln!("swaymsg failed with exit code: {:?}", swaymsg_result.code());
        exit(1);
    }
}
