extern crate image;
extern crate swayipc;
extern crate serde;
extern crate serde_json;

use std::env;
use std::process::{Command, Stdio};
use swayipc::{Connection, Fallible};

#[derive(serde::Deserialize, Debug)]
struct OutputInfo {
    #[allow(dead_code)]
    rect: Rect,
    current_mode: Mode,
}

#[derive(serde::Deserialize, Debug)]
struct Rect {
    #[allow(dead_code)]
    width: u32,
    #[allow(dead_code)]
    height: u32,
}

#[derive(serde::Deserialize, Debug)]
struct Mode {
    width: u32,
    height: u32,
}

fn get_resolution() -> Fallible<(u32, u32)> {
    let output = Command::new("swaymsg")
        .arg("-t")
        .arg("get_outputs")
        .stdout(Stdio::piped())
        .output()?;

    let output_str = String::from_utf8_lossy(&output.stdout);
    
    let output_info: Vec<OutputInfo> = serde_json::from_str(&output_str)?;

    if let Some(info) = output_info.get(0) {
        let resolution = (info.current_mode.width, info.current_mode.height);
        Ok(resolution)
    } else {
        Err(swayipc::Error::Io(std::io::Error::new(
            std::io::ErrorKind::Other,
            "Unable to retrieve resolution",
        )))
    }
}

fn main() -> Fallible<()> {
    // Connect to the Sway IPC socket
    let _connection = Connection::new()?;

    // Get the resolution of the current output
    let resolution = get_resolution()?;

    // Determine the wallpaper based on the resolution
    let wallpaper_name = if resolution.0 == 2736 && resolution.1 == 1824 {
        format!("{}/.nixos/home/wallpaper_2736x1824.gif", env::var("HOME").unwrap())
    } else {
        // Set a default wallpaper if the resolution doesn't match
        format!("{}/.nixos/home/wallpaper_1920x1080.gif", env::var("HOME").unwrap())
    };

    // Print the selected wallpaper name
    println!("{}", wallpaper_name);

    Ok(())
}
