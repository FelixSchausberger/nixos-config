#!/bin/bash

# Check if the bar-12 is visible
if ironbar get-visible bar-12 | grep -q "true"; then
    # If visible, set it to invisible
    ironbar set-visible bar-12 -v
else
    # If invisible, set it to visible
    ironbar set-visible bar-12
fi

