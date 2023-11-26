{ config, ... }:

{
  wayland.windowManager.sway.extraSessionCommands = ''
    ## Internal variables
    SWAY_EXTRA_ARGS=""

    ## General exports
    export XDG_CURRENT_DESKTOP=sway
    export XDG_SESSION_DESKTOP=sway
    export XDG_SESSION_TYPE=wayland

    ## Hardware compatibility
    case $(systemd-detect-virt --vm) in
        "none" | "")
            ;;
        "kvm")
            # Workaround for https://github.com/swaywm/sway/issues/6581
            export WLR_NO_HARDWARE_CURSORS=1

            # Choose the renderer based on 3D acceleration flag state
            export WLR_RENDERER=pixman
            ;;
        *)
            # Workaround for https://github.com/swaywm/sway/issues/6581
            export WLR_NO_HARDWARE_CURSORS=1
            ;;
    esac

    ## Load environment customizations
    load_environment() {
        local file="$1"
        if [ -f "$file" ]; then
            set -o allexport
            . "$file"
            set +o allexport
        fi
    }

    load_environment /etc/sway/environment
    load_environment "${config.home.homeDirectory}/.config/sway/environment"

    ## Unexport internal variables
    _SWAY_EXTRA_ARGS="$SWAY_EXTRA_ARGS"
    unset SWAY_EXTRA_ARGS

    # Start sway with extra arguments and send output to the journal
    exec systemd-cat -- sway $_SWAY_EXTRA_ARGS "$@"
  '';
}

