{
  xdg.configFile."ironbar/config.toml".text = ''
    anchor_to_edges = true
    position = "bottom"

    [[end]]
    type = "clock"

    [[start]]
    type = "workspaces"
    # name_map = "FiraCode"
    sort = "added"
  '';

  xdg.configFile."ironbar/style.css".text = ''
    @define-color color_bg #2d2d2d;
    @define-color color_bg_dark #1c1c1c;
    @define-color color_border #424242;
    @define-color color_border_active #6699cc;
    @define-color color_text #ffffff;
    @define-color color_urgent #8f0a0a;

    /* -- base styles -- */

    * {
        font-family: Noto Sans Nerd Font, sans-serif;
        font-size: 16px;
        border: none;
        border-radius: 0;
    }

    box, menubar, button {
        background-color: @color_bg;
        background-image: none;
    }

    button, label {
        color: @color_text;
    }

    button:hover {
        background-color: @color_bg_dark;
    }

    #bar {
        border-top: 1px solid @color_border;
    }

    .popup {
        border: 1px solid @color_border;
        padding: 1em;
    }

    /* -- clock -- */

    .clock {
        font-weight: bold;
        margin-left: 5px;
    }

    .popup-clock .calendar-clock {
        color: @color_text;
        font-size: 2.5em;
        padding-bottom: 0.1em;
    }

    .popup-clock .calendar {
        background-color: @color_bg;
        color: @color_text;
    }

    .popup-clock .calendar .header {
        padding-top: 1em;
        border-top: 1px solid @color_border;
        font-size: 1.5em;
    }

    .popup-clock .calendar:selected {
        background-color: @color_border_active;
    }

    /* -- launcher -- */

    .launcher .item {
        margin-right: 4px;
    }

    .launcher .item:not(.focused):hover {
        background-color: @color_bg_dark;
    }

    .launcher .open {
        border-bottom: 1px solid @color_text;
    }

    .launcher .focused {
        border-bottom: 2px solid @color_border_active;
    }

    .launcher .urgent {
        border-bottom-color: @color_urgent;
    }

    .popup-launcher {
        padding: 0;
    }

    .popup-launcher .popup-item:not(:first-child) {
        border-top: 1px solid @color_border;
    }

    /* -- script -- */

    .script {
        padding-left: 10px;
    }

    /* -- tray -- */

    .tray {
        margin-left: 10px;
    }

    /* -- workspaces -- */

    .workspaces .item.focused {
        box-shadow: inset 0 -3px;
        background-color: @color_bg_dark;
    }

    .workspaces .item:hover {
        box-shadow: inset 0 -3px;
    }
  '';
}
