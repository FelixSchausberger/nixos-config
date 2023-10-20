use std::env;
use std::fs;
use std::process::Command;

fn main() {
    let home = env::var("HOME").expect("HOME environment variable not set");
    let file = format!("{}/.cache/eww_launch.xyz", home);
    let eww = format!("eww -c {}/.nixos/home/modules/eww", home);

    // Check if the eww daemon is running
    let eww_pid = Command::new("pidof")
        .arg("eww")
        .output()
        .expect("Failed to check eww daemon")
        .stdout;
    
    if eww_pid.is_empty() {
        Command::new(eww.split_whitespace().next().expect("Invalid eww command"))
            .arg("daemon")
            .spawn()
            .expect("Failed to start eww daemon");
        std::thread::sleep(std::time::Duration::from_secs(1));
    }

    // Define a function to open widgets
    fn run_eww(eww: &str) {
        Command::new(eww.split_whitespace().next().expect("Invalid eww command"))
            .args(&["open-many", "bar"])
            .spawn()
            .expect("Failed to run eww open-many bar");
    }

    // Launch or close widgets accordingly
    if !fs::metadata(&file).is_ok() {
        fs::File::create(&file).expect("Failed to create file");
        run_eww(&eww);
    } else {
        Command::new(eww.split_whitespace().next().expect("Invalid eww command"))
            .args(&["close-all"])
            .spawn()
            .expect("Failed to run eww close-all");

        Command::new("eww")
            .args(&["kill"])
            .spawn()
            .expect("Failed to run eww kill");

        fs::remove_file(&file).expect("Failed to remove file");
    }
}

