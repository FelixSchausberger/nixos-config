use std::fs;
use std::io::Write;
use std::process::{Command, Stdio};

fn main() {
    let desktop_files_dir = "/etc/profiles/per-user/fesch/share/applications/";

    // List all the .desktop files in the specified directory
    let entries = fs::read_dir(desktop_files_dir).expect("Failed to read directory");
    let desktop_files: Vec<String> = entries
        .filter_map(|entry| {
            let entry = entry.expect("Failed to read entry");
            let path = entry.path();
            if path.is_file() {
                if let Some(ext) = path.extension() {
                    if ext == "desktop" {
                        Some(path.to_string_lossy().to_string())
                    } else {
                        None
                    }
                } else {
                    None
                }
            } else {
                None
            }
        })
        .collect();

    if desktop_files.is_empty() {
        eprintln!("No .desktop files found in the specified directory");
        return;
    }

    // Use fzf to select a .desktop file
    let mut fzf = Command::new("fzf")
        .arg("--preview")
        .arg("cat {}")
        .stdin(Stdio::piped())
        .stdout(Stdio::piped())
        .spawn()
        .expect("Failed to execute fzf");

    let fzf_stdin = fzf.stdin.as_mut().expect("Failed to open fzf stdin");
    for desktop_file in &desktop_files {
        fzf_stdin
            .write_all(format!("{}\n", desktop_file).as_bytes())
            .expect("Failed to write to fzf stdin");
    }

    let fzf_output = fzf.wait_with_output().expect("Failed to read fzf output");
    let binding = String::from_utf8_lossy(&fzf_output.stdout);
    let selected_desktop_file = binding.trim();
    // let selected_desktop_file = String::from_utf8_lossy(&fzf_output.stdout).trim();

    if selected_desktop_file.is_empty() {
        eprintln!("No .desktop file selected");
        return;
    }

    // Execute the selected .desktop file using swaymsg
    let swaymsg = Command::new("swaymsg")
        .args(&[
            "-q",
            &format!("exec --no-startup-id {}", selected_desktop_file),
        ])
        .status()
        .expect("Failed to execute swaymsg");

    if swaymsg.success() {
        println!("swaymsg command executed successfully");
    } else {
        eprintln!("swaymsg command failed to execute");
    }
}
