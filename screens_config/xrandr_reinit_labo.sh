#!/bin/bash

sleep 1
if [[ $(xrandr --verbose | grep 'DP2 connected') ]]; then
    echo 'DP2 connected..'
    echo 'Launch of DP2 new resolution'
    xrandr --output DP2 --mode 1680x1050 --scale 1x1
else
    echo 'DP2 disconnected..'
fi
