use std::env;
use std::io::{self, Write};
use std::fs;

fn main() -> io::Result<()> {
    // Get the user's PATH environment variable
    let path_var = env::var_os("PATH").expect("PATH environment variable not set");
    let paths = env::split_paths(&path_var);

    // Collect all executable files in the user's PATH
    let executables: Vec<String> = paths
        .flat_map(|path| {
            fs::read_dir(path)
                .ok() // Handle the Result returned by read_dir
                .map(|entries| {
                    entries
                        .filter_map(|entry| {
                            entry.ok().and_then(|e| {
                                e.file_name().into_string().ok()
                            })
                        })
                        .collect::<Vec<_>>()
                })
                .unwrap_or_else(Vec::new)
        })
        .collect();

    // Run fzf with the collected executables
    let mut fzf = std::process::Command::new("fzf")
        .args(&["--prompt", "Select a command:"])
        .stdin(std::process::Stdio::piped())
        .stdout(std::process::Stdio::piped())
        .spawn()?;

    if let Some(ref mut stdin) = fzf.stdin {
        for exe in executables {
            writeln!(stdin, "{}", exe)?;
        }
    }

    // Read the selected command from fzf
    let selected_command = {
        let output = fzf.wait_with_output()?;
        String::from_utf8_lossy(&output.stdout).trim().to_string()
    };

    // Execute swaymsg with the selected command
    let swaymsg = std::process::Command::new("swaymsg")
        .args(&["-q", &format!("exec {}", selected_command)])
        .status()?;

    if swaymsg.success() {
        println!("swaymsg command executed successfully");
    } else {
        eprintln!("swaymsg command failed to execute");
    }

    Ok(())
}
