#!/bin/bash

# get parameters
height=$1
width=$2

sleep 1
if [[ $(xrandr --verbose | grep 'DP2 connected') ]]; then
    echo 'DP2 connected..'
    echo 'Launch of DP2 new resolution'
    xrandr --output DP2 --mode ${height}x${width} --scale 2x2
else
    echo 'DP2 disconnected..'
fi
