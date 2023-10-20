{
  home.file.".blerc".text = ''
    function blerc/vim-mode-hook {
    ble-bind -m vi_nmap --cursor 2
    ble-bind -m vi_imap --cursor 5
    ble-bind -m vi_omap --cursor 4
    ble-bind -m vi_xmap --cursor 2
    ble-bind -m vi_cmap --cursor 0
  }
  blehook/eval-after-load keymap_vi blerc/vim-mode-hook
  '';
}
