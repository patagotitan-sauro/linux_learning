# INSTALAÇÃO KUBUNTU 26.04

## BACKUP DOS DADOS ANTES DA INSTALAÇÃO

## BAIXAR O SISTEMA OPERACIONAL
1. Criar o pendrive butável (bootable USB drive) utilizando o programa [Ventoy](https://www.ventoy.net/en/index.html);


## PARTIÇÃO MANUAL - NA INSTALAÇÃO
1. GPT Partition Table
2. Select Drive 
3. Manual Particion  

|nro | Partição | tipo | mount | Flags|  
|:-- |:-------:|:------:|:-------|:------:|  
|1 |512 MB |FAT32 | /boot/efi | boot, esp  |  
|2 | 1 GB | ext4 |/boot | -  | 
|3| 16 GB | linuxswap | - | -|
|4| resto nvme (min 80 GB) | ext4 | / | - |
|5|  todo o ssd | ext4 | /home | - |
---
Observações: 
1. sugestão de partição manual na situação de ter
dois drives (NVMe e SSD). Utilizar o NVMe para instalar o Sistema Operacional por ser um tipo de armazenamento
mais rápido.
2. No caso de apenas um drive de armazenamento (NVMe / SSD) a Partição 4 utiliza todo o espaço restante no / (root);
2. Faça a instalação completa, mas deixe para fazer o 
update depois de instalado o sistema.

## INSTALAÇÃO DE PACOTES

Instalação de pacotes após instalação da Distro.

1. Update de sistema
```bash
sudo apt update
sudo apt upgrade
```

2. Firewall
```bash
sudo apt install -f ufw
sudo ufw enable
```

3. Multimidia Codecs (dúvida: O Calamares não instala?)  
- instala um pacote de extras “restritos” do Ubuntu — ou seja, software que não vem instalado por padrão por questões de licença ou patente.
- o que instalal? Codecs de mídia (MP3, MP4/H.264, AAC), Fontes da Microsoft (Arial, Times New Roman, Verdana), 
```bash
sudo apt install ubuntu-restricted-extras
```



4. **Instalação do Flatpak**  
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

5. Micro Text Editor
```bash
# Installing Micro (apt)?
```

4. Neofetch
```bash
# ver o código de instalação do fastfetch
sudo apt install fastfetch
```

```bash
#incuir o fastfetch no arquivo .bashrc 
sudo micro .bashrc
# incluir no fim do arquivo para executar o fastfetch to vez que entrar no terminal
fastfetch
```
7. GIMP
```bash
# Installing GIMP (apt)?
```

8. Video Studio Code
```bash
# Installing VS Code (flatpak)?
```

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
```bash
# Installing Steam (Flatpak ou Apt)?
```

12. Bitwarden
```bash
# Installing Bitwarde (Flatpak ou Apt)?
```

13. WinBoat  
- Instalar Linux Toys para depois instalar WinBoat
- LinuxToys is available in several official and community repositories for easier package management.
- Ubuntu (PPA)
- You can install LinuxToys from our official PPA on [Launchpad:](https://launchpad.net/~psygreg/+archive/ubuntu/linuxtoys)
```bash
# Instação do Linux Toys do psygreg.
sudo add-apt-repository ppa:psygreg/linuxtoys
sudo apt update
sudo apt install linuxtoys
```   
> Fonte: [Linux Toys on Github](https://github.com/psygreg/linuxtoys)  

14. digiKam 
```bash
# Instação do Digikam do Flatpak.
#flatpak install digikam?
```

15. ZapZap
    
17. Utilitários interessantes
- htop
```bash
sudo apt install htop
``` 
- amdgpu_top
```bash
# ver o pacote a instalar o amdgpu_top
``` 
---

## Tweeks Kubuntu - KDE Plasma 

1. 


---
> [Back to main](../main.md)
