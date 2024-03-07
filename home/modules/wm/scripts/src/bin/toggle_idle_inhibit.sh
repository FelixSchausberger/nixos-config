#! /usr/bin/env bash

if pgrep -x "systemd-inhibit" > /dev/null
then
    pkill -f "systemd-inhibit --what=idle --who=Caffeine --why=Caffeine --mode=block sleep inf"
    dunstify "Caffeine Deactivated"
else
    systemd-inhibit --what=idle --who=Caffeine --why=Caffeine --mode=block sleep inf &
    dunstify "Caffeine Activated"
fi

