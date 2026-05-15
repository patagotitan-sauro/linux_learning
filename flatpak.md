# Instalação do Flatpak 
***
No, modern versions of Kubuntu (23.04 and later) do not come with Flatpak pre-installed or enabled by default.
While previous versions did include it, recent Ubuntu flavors have moved away from default Flatpak support to focus on Snaps.
***

However, adding Flatpak support to Kubuntu is easy:

1. Install the necessary packages in the terminal:

```bash
sudo apt updatesudo apt install flatpak plasma-discover-backend-flatpak
```

2. Add the Flathub repository for access to apps:

```bash
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
```

3. Restart your computer to allow Discover to detect the changes

