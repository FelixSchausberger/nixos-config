#! /usr/bin/env bash

# Check if the bar-12 is visible
if ironbar get-visible ironbar | grep -q "true"; then
    # If visible, set it to invisible
    ironbar set-visible ironbar
else
    # If invisible, set it to visible
    ironbar set-visible ironbar -v
fi

