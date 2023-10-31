extern crate image;
extern crate swayipc;

use swayipc::{Connection, Fallible};

fn main() -> Fallible<()> {
    // Connect to the Sway IPC socket
    let mut connection = Connection::new()?;

    // Get the current workspace
    let tree = connection.get_tree()?;
    let workspace = tree.find_focused(|_w| true);

    if let Some(workspace) = workspace {
        // Get the resolution of the focused workspace
        let resolution = workspace.rect;

        // Determine the wallpaper based on the resolution
        let wallpaper_name = if resolution.width == 1920 && resolution.height == 1080 {
            "~/.nixos/home/wallpaper_1920x1080.gif"
        } else if resolution.width == 2736 && resolution.height == 1824 {
            "~/.nixos/home/wallpaper_2736x1824.gif"
        } else {
            // Set a default wallpaper if the resolution doesn't match
            "default_wallpaper.jpg"
        };

        // Print the selected wallpaper name
        println!("{}", wallpaper_name);
    }

    Ok(())
}
