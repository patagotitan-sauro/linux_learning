# INSTALAÇÃO KUBUNTU 26.04

## PARTIÇÃO MANUAL - NA INSTALAÇÃO
1. GPT Partition Table
2. Select Drive 
3. Manual Particion  

|nro | espaço | tipo | mount | Flags|  
|:-- |:-------:|:------:|:-------:|:------:|  
|1 |512 MB |FAT32 | /boot/efi | boot, esp  |  
|2 | 1 GB | ext4 |boot | -  | 
|3| 16 GB | linuxswap | - | -|
|4| > 80 GB | ext4 | / | - |
|5| resto  | ext4 | /home | - |
---

## INSTALAÇÃO DE PACOTES

Instalação de pacotes após instalação da Distro.

1. Update de sistema
```bash
sudo apt update
sudo apt upgrade
```

2. Multimidia Codecs (dúvida: O Calamares não instala?)  
- instala um pacote de extras “restritos” do Ubuntu — ou seja, software que não vem instalado por padrão por questões de licença ou patente.
- o que instalal? Codecs de mídia (MP3, MP4/H.264, AAC), Fontes da Microsoft (Arial, Times New Roman, Verdana), 
```bash
sudo apt install ubuntu-restricted-extras
```

3. Firewall
```bash
sudo apt install -f ufw
sudo ufw enable
```

4. Neofetch
```bash
# ver o código de instalação do neofetch
```

5. **Instalação do Flatpak**  
No, modern versions of Kubuntu (23.04 and later) do not come with Flatpak pre-installed or enabled by default.
While previous versions did include it, recent Ubuntu flavors have moved away from default Flatpak support to focus on Snaps.
However, adding Flatpak support to Kubuntu is easy:

- Install the necessary packages in the terminal:
```bash
sudo apt update
sudo apt install flatpak plasma-discover-backend-flatpak
```
- Add the Flathub repository for access to apps:
```bash
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
```
- Restart your computer to allow Discover to detect the changes

6. Micro Text Editor

7. GIMP

8. Video Studio Code

9. Virtual Machine - KVM e QEMU  
    - KVM: Kernel-based Virtual Machine - hipervisor, ou seja, permite transformar o Linux em sistema de virtualização. Usa recursos do processador (Intel VT-x / AMD-V)
    - QEMU: Quick Emulator - emulador/gerenciador de máquinas virtuais. Cria e roda as VMs, emula hardware (disco, rede, CPU, etc), interface para controlar as VMs.
```bash
# Installing KVM and Virtual Machine Manager
sudo apt install -y qemu-kvm libvirt-daemon-system libvirt-clients bridge-utils virt-manager
```
```bash
# Enabling and starting libvirtd service
sudo systemctl enable --now libvirtd
```
```bash
# Adding $USER to libvirt and kvm groups
sudo usermod -aG libvirt $USER
sudo usermod -aG kvm $USER
```  

10. Sober  
```bash
# Installing Sober (Flatpak app)
flatpak install flathub org.vinegarhq.Sober -y
```  

11. Steam

12. Bitwarden

13. WinBoat
```bash
# Instação do Linux Toys do psygreg.
```  
14. Utilitários interessantes
- htop
- amdgpu_top
---

## Tweeks Kubuntu

---
> [Back to main](../main.md)