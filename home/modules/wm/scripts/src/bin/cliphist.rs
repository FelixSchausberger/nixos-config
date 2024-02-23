use std::process::{Command, Stdio};

fn main() {
    // Check if cliphist, fzf, and wl-copy exist in $PATH
    let binaries = ["cliphist", "fzf", "wl-copy"];

    // Check if each binary exists in $PATH
    for binary in &binaries {
        if !is_binary_in_path(binary) {
            eprintln!("{} not found in $PATH, make sure to install it before running this script", binary);
            std::process::exit(1);
        }
    }

    fn is_binary_in_path(binary: &str) -> bool {
    Command::new("which")
        .arg(binary)
        .stdout(std::process::Stdio::null())
        .stderr(std::process::Stdio::null())
        .status()
        .map(|status| status.success())
        .unwrap_or(false)
    }
 
    // Execute 'cliphist list' and capture its output
    let cliphist_list = Command::new("cliphist")
        .arg("list")
        .stdout(Stdio::piped())
        .spawn()
        .expect("Failed to execute cliphist list");

    // Execute 'fzf' and pipe the output of 'cliphist list' to it
    let fzf = Command::new("fzf")
        .stdin(
            cliphist_list
                .stdout
                .expect("Failed to capture cliphist list output"),
        )
        .stdout(Stdio::piped())
        .spawn()
        .expect("Failed to execute fzf");

    // Execute 'cliphist decode' and pipe the output of 'fzf' to it
    let cliphist_decode = Command::new("cliphist")
        .arg("decode")
        .stdin(fzf.stdout.expect("Failed to capture fzf output"))
        .stdout(Stdio::piped())
        .spawn()
        .expect("Failed to execute cliphist decode");

    // Execute 'wl-copy' and pipe the output of 'cliphist decode' to it
    let mut wl_copy = Command::new("wl-copy")
        .stdin(
            cliphist_decode
                .stdout
                .expect("Failed to capture cliphist decode output"),
        )
        .spawn()
        .expect("Failed to execute wl-copy");

    // Wait for 'wl-copy' to finish
    let status = wl_copy.wait().expect("Failed to wait for wl-copy");
    if !status.success() {
        eprintln!("Error: wl-copy failed with status {:?}", status);
    }
}
