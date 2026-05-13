#!/bin/bash

#COMMANDS TO REMOVE THE BRAVE BROWSER

#As shown in the video, enter each of these commands in a terminal:

sudo apt purge brave-browser brave-keyring

sudo apt autoremove 

sudo rm /etc/apt/sources.list.d/brave-browser-*.list

#And the additional commands to remove Brave files from the user’s home folder are:

rm -rf ~/.config/BraveSoftware

rm -rf ~/.cache/BraveSoftware

rm -rf ~/.local/share/keyrings/brave-browser*

#All of the above terminal commands are believed to be accurate, but are entered into your system at your own risk. :)f
