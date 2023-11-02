use std::process::{Command, Stdio};

fn main() {
    // Execute 'cliphist list' and capture its output
    let cliphist_list = Command::new("cliphist")
        .arg("list")
        .stdout(Stdio::piped())
        .spawn()
        .expect("Failed to execute cliphist list");

    // Execute 'fzf' and pipe the output of 'cliphist list' to it
    let fzf = Command::new("fzf")
        .stdin(cliphist_list.stdout.unwrap())
        .stdout(Stdio::piped())
        .spawn()
        .expect("Failed to execute fzf");

    // Execute 'cliphist decode' and pipe the output of 'fzf' to it
    let cliphist_decode = Command::new("cliphist")
        .arg("decode")
        .stdin(fzf.stdout.unwrap())
        .stdout(Stdio::piped())
        .spawn()
        .expect("Failed to execute cliphist decode");

    // Execute 'wl-copy' and pipe the output of 'cliphist decode' to it
    let wl_copy = Command::new("wl-copy")
        .stdin(cliphist_decode.stdout.unwrap())
        .spawn()
        .expect("Failed to execute wl-copy");

    // Wait for 'wl-copy' to finish
    let status = wl_copy.wait().expect("Failed to wait for wl-copy");
    if !status.success() {
        eprintln!("Error: wl-copy failed with status {:?}", status);
    }
}

