use std::fs;
use std::io;

fn find_battery_files(filename: &str) -> io::Result<String> {
    let power_supply_path = "/sys/class/power_supply";

    // Initialize an empty string to store the content
    let mut content = String::new();

    // Read the entries in the power_supply directory
    let entries = fs::read_dir(power_supply_path)?;

    for entry in entries {
        if let Ok(entry) = entry {
            let path = entry.path();
            if path.is_dir() {
                let filepath = path.join(filename); // Use Path::join for file path construction

                // Check if file exists in this directory
                if filepath.exists() {
                    // Read the content and append it to the content variable
                    if let Ok(file_content) = fs::read_to_string(&filepath) {
                        content.push_str(&file_content);
                    }
                }
            }
        }
    }

    // Check if content is still empty after processing all directories
    if content.is_empty() {
        return Ok(String::new());
    }

    Ok(content)
}

fn main() -> io::Result<()> {
    // Call the find_battery_files function for capacity and online
    let capacity_content = find_battery_files("capacity")?;
    let charging_content = find_battery_files("online")?;

    if capacity_content.is_empty() || charging_content.is_empty() {
        // No battery found, print an empty string and return
        println!("");
        return Ok(());
    }

    // Parse the capacity and online status
    let capacity: i32 = capacity_content.trim().parse().unwrap_or(-1);
    let online: i32 = charging_content.trim().parse().unwrap_or(0);

    // Determine the charging symbol based on charging status
    let charging_symbol = if online == 1 {
        "↑" // Charging
    } else {
        "↓" // Discharging
    };

    // Print the capacity and the appropriate battery symbol
    println!("{}{}% | ", charging_symbol, capacity);

    Ok(())
}

