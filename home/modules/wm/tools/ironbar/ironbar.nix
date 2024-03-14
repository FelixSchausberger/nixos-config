{
  programs.ironbar = {
    enable = true;
    config = {
      "name" = "ironbar";
      "anchor_to_edges" = true;
      "position" = "bottom";
      "icon_theme" = "Paper";
      "start" = [
        {
          "type" = "workspaces";
          "all_monitors" = false;
          "hidden" = ["special:magic"];
          "sort" = "added";
        }
      ];
      "end" = [
        {
          "type" = "sys_info";
          "interval" = {
            "memory" = 30;
            "cpu" = 1;
            "temps" = 5;
            "disks" = 300;
            "networks" = 3;
          };
          "format" = [
            " {cpu_percent}%"
            " {memory_used} / {memory_total} GB ({memory_percent}%)"
            # "| {swap_used} / {swap_total} GB ({swap_percent}%)"
            "󰋊 {disk_used:/} / {disk_total:/} GB ({disk_percent:/}%)"
            # "󰓢 {net_down:enp39s0} / {net_up:enp39s0} Mbps"
            # "󰖡 {load_average:1} | {load_average:5} | {load_average:15}"
            # "󰥔 {uptime}"
          ];
        }
        {
          "type" = "clock";
        }
      ];
    };
    style = "
      * {
      	border: none;
      	border-radius: 0;
      	border-image: none;
      	outline: none;
      	background-image: none;
      	background-color: rgba(0,0,0,0);
      	box-shadow: none;
      	text-shadow: none;
      	color: inherit;
      }

      @define-color onedark_bg_color #282c34;
      @define-color onedark_bg_50_color rgba(40, 44, 52, 0.5);
      @define-color onedark_fg_color #abb2bf;
      @define-color onedark_fg_50_color rgba(171, 178, 191, 0.5);
      @define-color onedark_red_color #e06c75;
      @define-color onedark_red_50_color rgba(224, 108, 117, 0.5);
      @define-color onedark_orange_color #d19a66;
      @define-color onedark_orange_50_color rgba(209, 154, 102, 0.5);
      @define-color onedark_yellow_color #e5c07b;
      @define-color onedark_yellow_50_color rgba(229, 192, 123, 0.5);
      @define-color onedark_green_color #98c379;
      @define-color onedark_green_50_color rgba(152, 195, 121, 0.5);
      @define-color onedark_cyan_color #56b6c2;
      @define-color onedark_cyan_50_color rgba(86, 182, 194, 0.5);
      @define-color onedark_blue_color #61afef;
      @define-color onedark_blue_50_color rgba(97, 175, 239, 0.5);
      @define-color onedark_indigo_color #4B0082;
      @define-color onedark_indigo_50_color rgba(75, 0, 130, 0.5);
      @define-color onedark_violet_color #8F00FF;
      @define-color onedark_violet_50_color rgba(143, 0, 255, 0.5);
      @define-color transparent rgba(0,0,0,0);


      #bar {
      	background-color: @onedark_bg_50_color;
      	color: @onedark_green_color;
      	font-weight: 900;
      	font-size: 16px;
        font-family: \"Iosevka Medium\";
      	border-bottom: 2px solid transparent;
      	border-image: linear-gradient(to bottom right, @onedark_red_color, @onedark_orange_color, @onedark_yellow_color, @onedark_green_color, @onedark_cyan_color, @onedark_blue_color, @onedark_indigo_color, @onedark_violet_color) 1;
      	border-image-slice: 4;
      }

      #bar #end {
      	margin-right: 10px;
      }
      #bar #start {
      	margin-left: 10px;
      }

      .workspaces {
      }
      .workspaces .item {
      	font-size: 0px;
      	padding: 0px 3px;
      	background-color: @onedark_green_color;
      	color: rgba(0,0,0,0);
      	border-radius: 5px;
      	margin: 2px;
      	margin-top: 5px;
      	margin-bottom: 5px;
      }
      .workspaces .item.focused {
      	background-color: @onedark_red_color;
      	color: @onedark_bg_color;
      	font-size: 14px;
      }
      .workspaces .item:hover {
      	background-color: @onedark_blue_color;
      	color: @onedark_bg_color;
      	font-size: 14px;
      	border-bottom: 2px solid @onedark_blue_color;
      	border-right: 2px solid @onedark_blue_color;
      	margin-bottom: 3px;
      	margin-right: 0px;
      }
      .popup {
      	background-color: @onedark_bg_50_color;
      	color: @onedark_fg_color;
      	border: 2px solid @onedark_blue_50_color;
      	border-radius: 5px;
      	padding: 5px;

      }
      .workspaces .item:nth-child(1) {
      	background-color: @onedark_red_color;
      }
      .workspaces .item:nth-child(2) {
      	background-color: @onedark_orange_color;
      }
      .workspaces .item:nth-child(3) {
      	background-color: @onedark_yellow_color;
      }
      .workspaces .item:nth-child(4) {
      	background-color: @onedark_green_color;
      }
      .workspaces .item:nth-child(5) {
      	background-color: @onedark_blue_color;
      }
      .workspaces .item:nth-child(6) {
      	background-color: @onedark_indigo_color;
      	color: @onedark_fg_color;
      }
      .workspaces .item:nth-child(7) {
      	background-color: @onedark_violet_color;
      }
      .workspaces .item:nth-child(8) {
      	background-color: @onedark_red_color;
      }
      .workspaces .item:nth-child(9) {
      	background-color: @onedark_orange_color;
      }
      .workspaces .item:nth-child(10) {
      	background-color: @onedark_yellow_color;
      }
      .workspaces .item:nth-child(11) {
      	background-color: @onedark_green_color;
      }
      .workspaces .item:nth-child(12) {
      	background-color: @onedark_blue_color;
      }
      .workspaces .item:nth-child(13) {
      	background-color: @onedark_indigo_color;
      }
      .workspaces .item:nth-child(14) {
      	background-color: @onedark_violet_color;
      }
      .workspaces .item:nth-child(1):hover {
      	border-bottom: 2px solid @onedark_orange_color;
      	border-right: 2px solid @onedark_orange_color;
      }
      .workspaces .item:nth-child(2):hover {
      	border-bottom: 2px solid @onedark_yellow_color;
      	border-right: 2px solid @onedark_yellow_color;
      }
      .workspaces .item:nth-child(3):hover {
      	border-bottom: 2px solid @onedark_green_color;
      	border-right: 2px solid @onedark_green_color;
      }
      .workspaces .item:nth-child(4):hover {
      	border-bottom: 2px solid @onedark_blue_color;
      	border-right: 2px solid @onedark_blue_color;
      }
      .workspaces .item:nth-child(5):hover {
      	border-bottom: 2px solid @onedark_indigo_color;
      	border-right: 2px solid @onedark_indigo_color;
      }
      .workspaces .item:nth-child(6):hover {
      	border-bottom: 2px solid @onedark_violet_color;
      	border-right: 2px solid @onedark_violet_color;
      }
      .workspaces .item:nth-child(7):hover {
      	border-bottom: 2px solid @onedark_red_color;
      	border-right: 2px solid @onedark_red_color;
      }
      .workspaces .item:nth-child(8):hover {
      	border-bottom: 2px solid @onedark_orange_color;
      	border-right: 2px solid @onedark_orange_color;
      }
      .workspaces .item:nth-child(9):hover {
      	border-bottom: 2px solid @onedark_yellow_color;
      	border-right: 2px solid @onedark_yellow_color;
      }
      .workspaces .item:nth-child(10):hover {
      	border-bottom: 2px solid @onedark_green_color;
      	border-right: 2px solid @onedark_green_color;
      }
      .workspaces .item:nth-child(11):hover {
      	border-bottom: 2px solid @onedark_blue_color;
      	border-right: 2px solid @onedark_blue_color;
      }
      .workspaces .item:nth-child(12):hover {
      	border-bottom: 2px solid @onedark_indigo_color;
      	border-right: 2px solid @onedark_indigo_color;
      }
      .workspaces .item:nth-child(13):hover {
      	border-bottom: 2px solid @onedark_violet_color;
      	border-right: 2px solid @onedark_violet_color;
      }
      .workspaces .item:nth-child(14):hover {
      	border-bottom: 2px solid @onedark_red_color;
      	border-right: 2px solid @onedark_red_color;
      }
    ";
    systemd = true;
  };
}
