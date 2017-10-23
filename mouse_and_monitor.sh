#!/bin/bash

# This sets a variable for the mouse ID
idnum="$(xinput list | grep -m 1 'Mouse' | awk {'print $7'}| cut -d = -f 2)"

# This uses the mouse ID variable to apply settings
xinput --set-prop "${idnum}" "Device Accel Velocity Scaling" 1
xinput --set-prop "${idnum}" "Device Accel Profile" $2
xinput --set-prop "${idnum}" "Device Accel Constant Deceleration" $1

# These are to set the monitors to 144hz mode
xrandr --output DisplayPort-0 --mode 1920x1080 --rate 144.00
xrandr --output DisplayPort-2 --mode 1920x1080 --rate 144.00
