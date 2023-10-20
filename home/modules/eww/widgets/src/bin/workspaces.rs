extern crate serde;
extern crate serde_json;

use std::process::Command;
use std::time::Duration;
use serde::Deserialize;

#[derive(Deserialize)]
struct SwayWorkspace {
    focused: bool,
    #[allow(dead_code)]
    num: u32,
    #[allow(dead_code)]
    output: Option<String>,
    #[allow(dead_code)]
    visible: bool,
}

fn print_workspaces() {
    let output = Command::new("swaymsg")
        .arg("-t")
        .arg("get_workspaces")
        .output()
        .expect("Failed to execute swaymsg command");

    let output_str = String::from_utf8(output.stdout).expect("Invalid UTF-8 in swaymsg output");
    let workspaces: Vec<SwayWorkspace> = serde_json::from_str(&output_str).expect("Failed to parse JSON");

    let mut buf = String::new();

    for workspace in workspaces {
        let icon = if workspace.focused {
            " " // Full circle for focused workspace
        } else {
            " " // Empty circle for unfocused workspaces
        };

        buf.push_str(&format!(" (eventbox :cursor \"hand\" (button :class \"occupied\" \"{}\"))", icon));
    }

    println!("(box :class \"workspaces\" :halign \"center\" :valign \"center\" :vexpand true :hexpand true {})", buf);
}

fn main() {
    loop {
        print_workspaces();
        std::thread::sleep(Duration::from_millis(500));
    }
}
