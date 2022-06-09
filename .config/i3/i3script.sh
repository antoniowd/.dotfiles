#!/bin/bash

i3status --config ~/.i3status.conf | while :
do
    read line
    LG=$(/home/antonio/.config/i3/xkblayout-state/xkblayout-state print "%n")
    dat="[{ \"full_text\": \"$LG\", \"color\":\"#009E00\" },"
    echo "${line/[/$dat}" || exit 1
done
