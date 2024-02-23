use std::process::{Command, exit, Stdio};
use std::io::{self, Write};
use std::thread::sleep;
use std::time::Duration;

fn main() {    
    // Check if fzf, rbw, and wl-copy exist in $PATH
    let binaries = ["rbw", "fzf", "wl-copy"];

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
    
    // Check if the vault is unlocked
    if Command::new("rbw").arg("unlocked").output().is_ok() {
        get_entry();
    } else {
        unlock_vault();
    }
}

fn unlock_vault() {
    if Command::new("rbw").arg("unlock").status().is_ok() {
        get_entry();
    } else {
        eprintln!("Failed to unlock the vault");
        exit(1);
    }
}

fn get_entry() {
    let output = Command::new("rbw").arg("ls").output().unwrap();
    let entries = String::from_utf8_lossy(&output.stdout);

    if entries.is_empty() {
        println!("No entries found, quitting.");
        exit(0);
    }

    let selected_entry = select_entry(&entries);

    if selected_entry.is_empty() {
        println!("No entry selected, quitting.");
        exit(0);
    }

    get_username(&selected_entry);
}

fn select_entry(entries: &str) -> String {
    let mut echo_child = Command::new("echo")
        .arg(entries)
        .stdout(Stdio::piped())
        .spawn()
        .expect("Failed to spawn echo process");

    let output = Command::new("fzf")
        .stdin(echo_child.stdout.take().unwrap())
        .stdout(Stdio::piped())
        .spawn()
        .expect("Failed to spawn fzf process")
        .wait_with_output()
        .expect("Failed to wait for fzf process");

    if output.status.success() {
        String::from_utf8_lossy(&output.stdout).trim().to_string()
    } else {
        eprintln!("Error while getting entry: {:?}", String::from_utf8_lossy(&output.stderr));
        exit(1);
    }
}

fn get_username(name: &str) {
    let output = Command::new("rbw").arg("get").arg("--field").arg("username").arg(name).output().unwrap();
    let username = String::from_utf8_lossy(&output.stdout).trim_start_matches("Username: ").to_string();

    if !username.is_empty() {
        Command::new("wl-copy").arg("-n").arg(&username).output().unwrap();
        print!("\"{}\" username copied to clipboard, press enter if you also want the password: ", name);
        io::stdout().flush().unwrap();
        let _ = io::stdin().read_line(&mut String::new());
        get_password(name);
    } else {
        println!("\"{}\" doesn't have a username, copying password instead", name);
        get_password(name);
    }
}

fn get_password(name: &str) {
    Command::new("rbw").arg("get").arg("--clipboard").arg(name).output().unwrap();
    println!("\"{}\" password copied to clipboard", name);

    let mut wait_time = 10;
    while wait_time > 0 {
        if wait_time > 1 {
            println!("Clearing password from clipboard in {} seconds", wait_time);
        } else {
            println!("Clearing password from clipboard in 1 second");
        }
        sleep(Duration::from_secs(1));
        wait_time -= 1;
    }

    Command::new("wl-copy").arg("-c").output().unwrap();
    get_notes(name);
}

fn get_notes(name: &str) {
    let output = Command::new("rbw").arg("get").arg("--field").arg("notes").arg(name).output().unwrap();
    let note = String::from_utf8_lossy(&output.stdout).trim().to_string();

    if !note.is_empty() {
        println!("\n\"{}\" notes:\n\n{}", name, note);
        print!("Press enter to exit.");
        io::stdout().flush().unwrap();
        let _ = io::stdin().read_line(&mut String::new());
        exit(0);
    }
}
