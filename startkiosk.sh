#!/bin/bash

# disable DPMS (Energy Star) features
xset -dpms

# disable screen saver
xset s off

# don't blank video device
xset s noblank

# disable mouse pointer
unclutter &

# run window manager
matchbox-window-manager -use_cursor no -use_titlebar no &
#matchbox-window-manager &

# run browser
midori -i 720 -e Fullscreen -e ZoomIn -e ZoomIn -a "http://reservierung.tennisclub-braunlage.de/"

