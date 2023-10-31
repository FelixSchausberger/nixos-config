extern crate swayipc;
extern crate image;

use swayipc::{Connection, Fallible};

fn main() -> Fallible<()> {
    // Connect to the Sway IPC socket
    let connection = Connection::new()?;

    // Get the current workspace
    let tree = connection.get_tree()?;
    let workspace = tree.find_focused_workspace();

    if let Some(workspace) = workspace {
        // Get the resolution of the focused workspace
        let resolution = workspace.rect;

        // Determine the wallpaper based on the resolution
        let wallpaper_name = if resolution.width == 1920 && resolution.height == 1080 {
            "wallpaper_1920x1080.jpg"
        } else if resolution.width == 2736 && resolution.height == 1824 {
            "wallpaper_2736x1824.jpg"
        } else {
            // Set a default wallpaper if the resolution doesn't match
            "default_wallpaper.jpg"
        };

        // Print the selected wallpaper name
        println!("{}", wallpaper_name);
    }

    Ok(())
}

