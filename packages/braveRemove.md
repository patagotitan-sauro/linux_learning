
# BRAVE BROWSER
## COMMANDS TO REMOVE THE BRAVE BROWSER
In Zorin OS 18 Brave is the default browser.
***
As shown in the video, enter each of these commands in a terminal:
```bash
sudo apt purge brave-browser brave-keyring
```
```bash
sudo apt autoremove 
```
```bash
sudo rm /etc/apt/sources.list.d/brave-browser-*.list
```
***
And the additional commands to remove Brave files from the user’s home folder are:
```bash
rm -rf ~/.config/BraveSoftware
```
```bash
rm -rf ~/.cache/BraveSoftware
```
```bash
rm -rf ~/.local/share/keyrings/brave-browser*
```
***
>Fonte: 
> 1. [ExplainingComputer|Zorin OS 18: Linux for Windows 10 Users](https://www.youtube.com/watch?v=nplI2lvKu94&t=800s)  
> 2. All of the above terminal commands are believed to be accurate, but are entered into your system at your own risk. :)f  
> 3. [Reasons to uninstall Brave - artigo XDA](https://www.xda-developers.com/brave-most-overrated-browser-dont-recommend/)

