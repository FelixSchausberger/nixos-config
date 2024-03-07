#!/bin/bash

if pgrep -x "systemd-inhibit" > /dev/null
then
    pkill -f "systemd-inhibit --what=idle --who=Caffeine --why=Caffeine --mode=block sleep inf"
else
    systemd-inhibit --what=idle --who=Caffeine --why=Caffeine --mode=block sleep inf &
fi

