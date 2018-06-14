#!/bin/bash

echo "Enter a Twitch.TV streamer name and press enter..."

read STREAMER

livestreamer twitch.tv/$STREAMER best --player-passthrough hls  --http-header Client-ID=jzkbprff40iqj646a697cyrvl0zt2m6

echo "alias twitch='./twitch-livestreamer.sh'" >> ~/.bash_aliases && source ~/.bash_aliases
