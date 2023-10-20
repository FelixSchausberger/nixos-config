use std::fs;

fn main() {
    let args: Vec<String> = std::env::args().collect();

    if args.len() != 2 {
        eprintln!("Usage: {} <widget_name>", args[0]);
        std::process::exit(1);
    }

    widget(&args[1]);
}

fn widget(widget_name: &str) {
    let lock_file = format!("{}/.cache/eww-calendar.lock", std::env::var("HOME").unwrap());
    let eww_config = format!("{}/.nixos/home/modules/eww", std::env::var("HOME").unwrap());

    if !fs::metadata(&lock_file).is_ok() {
        match fs::File::create(&lock_file) {
            Ok(_) => {
                run_eww(&eww_config, "open", &widget_name);
                println!("opened");
            }
            Err(e) => {
                eprintln!("Error creating lock file: {}", e);
            }
        }
    } else {
        run_eww(&eww_config, "close", &widget_name);
        match fs::remove_file(&lock_file) {
            Ok(_) => {
                println!("closed");
            }
            Err(e) => {
                eprintln!("Error removing lock file: {}", e);
            }
        }
    }
}

fn run_eww(eww_command: &str, action: &str, widget_name: &str) {
    let result = std::process::Command::new("eww")
        .arg("-c")
        .arg(eww_command)
        .arg(action)
        .arg(widget_name)
        .status();

    if let Err(e) = result {
        eprintln!("Error running eww: {}", e);
        std::process::exit(1);
    }
}

