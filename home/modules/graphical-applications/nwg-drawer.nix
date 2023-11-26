{
  xdg.configFile."nwg-drawer/drawer.css".text = ''
    /* General styles */
    window {
        background-color: rgba(24, 24, 24, 0.3);
        color: #eeeeee;
    }

    /* Search entry */
    entry {
        background-color: rgba(0, 0, 0, 0.2);
    }

    /* Buttons and images */
    button, image {
        background: none;
        border: none;
    }

    button:hover {
        background-color: rgba(255, 255, 255, 0.1);
    }

    /* Category button */
    #category-button {
        margin: 0 10px 0 10px;
    }

    /* Pinned box */
    #pinned-box {
        padding-bottom: 5px;
        border-bottom: 1px dotted gray;
    }

    /* Files box */
    #files-box {
        padding: 5px;
        border: 1px dotted gray;
        border-radius: 15px;
    }
  '';
}
