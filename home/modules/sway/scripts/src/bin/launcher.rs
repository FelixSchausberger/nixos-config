use std::io::{BufRead, BufReader};
use std::process::{Command, Stdio};

fn main() {
    let opts = "--info=inline --print-query --bind=ctrl-space:print-query,tab:replace-query";

    // Run the compgen -c | fzf $OPTS | tail -1 command and capture its output
    let compgen_fzf = Command::new("sh")
        .args(&["-c", &format!("compgen -c | fzf {}", opts)])
        .stdout(Stdio::piped())
        .spawn()
        .expect("Failed to execute command");

    // Read the output of the compgen -c | fzf $OPTS | tail -1 command
    let output = compgen_fzf.stdout.expect("Failed to capture output");
    let output_lines = BufReader::new(output).lines();

    // Get the last line of the output
    let last_line = output_lines.last().expect("No output lines").unwrap();

    // Execute swaymsg with the selected command
    let swaymsg = Command::new("swaymsg")
        .args(&["-q", &format!("exec --no-startup-id {}", last_line)])
        .status()
        .expect("Failed to execute swaymsg");

    if swaymsg.success() {
        println!("swaymsg command executed successfully");
    } else {
        eprintln!("swaymsg command failed to execute");
    }
}
