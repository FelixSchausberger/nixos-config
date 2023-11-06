use std::io;
use std::io::Write;
use std::process::{Command, Stdio};

fn main() -> io::Result<()> {
    let directory_path = "/etc/profiles/per-user/fesch/share/applications/";

    // List .desktop files in the specified directory
    let output = Command::new("fd")
        .arg(".desktop")
        .arg(&directory_path)
        .output()?;

    if !output.status.success() {
        eprintln!("Failed to list .desktop files in the directory.");
        return Ok(());
    }

    let file_list = String::from_utf8_lossy(&output.stdout);
    let files: Vec<&str> = file_list.lines().collect();

    if files.is_empty() {
        eprintln!("No .desktop files found in the specified directory.");
        return Ok(());
    }

    // Create a Vec to store the application names
    let mut app_names: Vec<String> = Vec::new();

    for file in files.iter() {
        let desktop_contents = std::fs::read_to_string(file)?;

        // Extract the Name field from the .desktop file
        for line in desktop_contents.lines() {
            if line.starts_with("Name=") {
                app_names.push(line[5..].to_string());
                break;
            }
        }
    }

    // Use fzf to interactively choose an application name
    let mut fzf_result = Command::new("fzf")
        .stdin(Stdio::piped())
        .stdout(Stdio::piped())
        .spawn()?;

    if let Some(ref mut stdin) = fzf_result.stdin {
        for name in app_names.iter() {
            stdin.write_all(name.as_bytes())?;
            stdin.write_all(b"\n")?;
        }
    }

    let fzf_output = fzf_result.wait_with_output()?;

    if !fzf_output.status.success() {
        eprintln!("Failed to use fzf for selection.");
        return Ok(());
    }

    let binding = String::from_utf8_lossy(&fzf_output.stdout);
    let selected_name = binding.trim();

    // Find the file path associated with the selected application name
    let selected_file = files.iter().find(|&&file| {
        let desktop_contents = std::fs::read_to_string(file).unwrap_or_default();
        desktop_contents
            .lines()
            .any(|line| line.starts_with("Name=") && line[5..] == *selected_name)
    });

    match selected_file {
        Some(file) => {
            // Read the chosen .desktop file
            let desktop_contents = std::fs::read_to_string(file)?;

            // Extract the Exec field from the .desktop file
            let mut exec: Option<String> = None;

            for line in desktop_contents.lines() {
                if line.starts_with("Exec=") {
                    exec = Some(line[5..].to_string());
                    break;
                }
            }

            match exec {
                Some(exec) => {
                    // Execute swaymsg with the selected command
                    let _ = Command::new("swaymsg")
                        .arg("-q")
                        .arg("exec")
                        .arg(&exec)
                        .spawn();
                }
                None => {
                    eprintln!("Exec field not found in the chosen .desktop file.");
                }
            }
        }
        None => {
            eprintln!("No .desktop file found for the selected application name.");
        }
    }

    Ok(())
}
