#!/bin/sh

# Check if the selected entry exists 
get_entry () {
    NAME=$(rbw ls | fzf)

    if [ $? -eq 1 ]; then 
        printf '%s\n' "Please, select a valid entry."
        exit 1
    elif [ -z "$NAME" ]; then
        printf '%s\n' "No entry selected, quitting."
	exit 0
    else
        get_username
    fi
}

get_username () {
    # If the selected entry has a username, copy it to clipboard and ask if user also wants to copy the password
    USERNAME=$(rbw get --field username "$NAME"|sed 's/Username: //')
    if [ -n "$USERNAME" ]; then
        wl-copy -n "$USERNAME"
        # printf '%s\n' "\"$NAME\" username copied to clipboard, press enter if you also want the password"
        # read -r ans
        get_password
    # else
    #     printf '%s\n' "\"$NAME\" doesn't have a username, copying password instead"
    #     get_password
    fi
}

get_password () {
    # Copy password to clipboard
    rbw get --clipboard "$NAME"
    printf '%s\n' "\"$NAME\" password copied to clipboard"

    # Wait 10 seconds before clearing the clipboard, you can raise or decrease the wait time by changing the WTIME variable value
    WTIME=10
    while [ $WTIME -gt 0 ]; do
        if [ $WTIME -gt 1 ]; then
            printf '%s\n' "Clearing password from clipboard in $WTIME seconds"
        else
            printf '%s\n' "Clearing password from clipboard in $WTIME second"
        fi
	sleep 1
	WTIME=$((WTIME-1))
    done

    # Clear password from clipboard
    wl-copy -c

    get_notes
}

get_notes () {
    NOTE=$(rbw get --field notes "$NAME")
    if [ -n "$NOTE" ]; then
        printf '%s\n\n' "\"$NAME\" notes:"
	printf '%s\n\n' "$NOTE"
	printf '%s\n' "Press enter to exit."
	# read -r ans
	exit 0
    fi
}

# Check if fzf, rbw and wl-copy exists in $PATH
for binary in rbw fzf wl-copy; do
    command -v $binary 2>/dev/null 1>&2 || \
        { printf '%s\n' "$binary not found in \$PATH, make sure to install it before running this script" ; exit 1 ;}
done

# Unlock the vault before running the script
if rbw unlocked 2>/dev/null 1>&2; then
    get_entry
else
    rbw unlock && get_entry
fi

