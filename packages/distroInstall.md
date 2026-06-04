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
|2| 1GB | ext4| /boot| - |
|3| 16 GB | linuxswap | - | -|
|4| resto do NVMe (min 80 GB) | ext4 | / | - |
|4|  todo o ssd | ext4 | /home | - |
---
**Ponto de atenção**: Durante a instalação, escolha particionamento manual.
* /boot/efi — Necessário para sistemas UEFI (praticamente todo hardware moderno). Se o seu computador usar BIOS legado, pule essa partição e crie uma pequena partição de BIOS boot de 1MB no lugar.
* /boot separado — Opcional, mas recomendado quando o / está em um NVMe, pois alguns bootloaders funcionam de forma mais confiável com ele em uma partição dedicada.
* Tamanho do swap — Com um NVMe rápido, o desempenho do swap é razoável, mas se quiser usar hibernação (suspend-to-disk), o swap precisa ter tamanho igual ou maior que a sua RAM.
* /home no SSD — Durante a instalação pelo Calamares, escolha particionamento manual, formate /dev/sda1 como ext4 e defina o ponto de montagem como /home. Em reinstalações futuras, não formate essa partição para preservar seus dados.
* Sistema de arquivos — ext4 é a opção mais segura e estável. Você pode usar btrfs no / se quiser suporte a snapshots — o Timeshift funciona muito bem com ele no Kubuntu.
---
Observações: 
1. sugestão de partição manual na situação de ter dois drives (NVMe e SSD). Utilizar o NVMe para instalar o Sistema Operacional por ser um tipo de armazenamento mais rápido.
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
Instalação do Micro via apt
```bash
sudo apt install micro
```

4. Neofetch
Instalação do fastfetch via apt
```bash
sudo apt install fastfetch
```
Incuir o fastfetch no arquivo .bashrc para apresentar os dados dos sistema no terminal de forma automática.
```bash
sudo micro .bashrc
# incluir no fim do arquivo para executar o fastfetch to vez que entrar no terminal
fastfetch
```
7. GIMP
Instalação do GIMP via apt.
```bash
sudo apt gimp
```

8. Video Studio Code
Instalação do VS Code via flatpak.
```bash
flatpak install com.visualstudio.code
```

9. Virtual Machine - KVM e QEMU  
    - KVM: Kernel-based Virtual Machine - hipervisor, ou seja, permite transformar o Linux em sistema de virtualização. Usa recursos do processador (Intel VT-x / AMD-V)
    - QEMU: Quick Emulator - emulador/gerenciador de máquinas virtuais. Cria e roda as VMs, emula hardware (disco, rede, CPU, etc), interface para controlar as VMs.
Instalação do KVM and do Virtual Machine Manager via apt. No Kubuntu o Calamaris tem opção de instalação no momento da instalação do Sistema Operacional.
```bash
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
Instalação do Sober via Flatpak. Para jogar Robox.
```bash
flatpak install flathub org.vinegarhq.Sober -y
```  

11. Steam
Instalação do Steam via Flatpak. Launcher for the Steam software distribution service 
```bash
flatpak install com.valvesoftware.Steam
```

12. Bitwarden
Instalação do Bitwarde via Flatpak. A secure and free password manager for all of your devices.
```bash
flatpak install com.bitwarden.desktop
```

13. WinBoat  
- Instalar Linux Toys para depois instalar WinBoat
- Manual Installation
- If you prefer to review the script before running it, you can download and execute it manually:
```bash
# Instação do Linux Toys do psygreg.
curl -fsSLJO https://linux.toys/install.sh
chmod +x install.sh
./install.sh
``` 
- LinuxToys is available in several official and community repositories for easier package management.
- Ubuntu (PPA)
- You can install LinuxToys from our official PPA on [Launchpad:](https://launchpad.net/~psygreg/+archive/ubuntu/linuxtoys)
> Fontes:
>> [Linux Toys no Github](https://github.com/psygreg/linuxtoys) <br>
>> [Artigo Diolinux: entenda o que é o linux toys](https://diolinux.com.br/editorial/entenda-o-que-e-o-linux-toys.html)  

14. digiKam 
Instação do Digikam via Flatpak.
```bash
flatpak install org.kde.digikam
```

15. ZapZap
Instalação do ZapZap um clinte para o Linux do Whatsapp.
```bash
flatpak install com.rtosta.zapzap
```
16. Instalação do Flatseal para Gerenciar as permissões do Flatpak.
Flatseal is a graphical utility to review and modify permissions from your Flatpak applications.

```bash
flatpak install flathub com.github.tchx84.Flatseal
```
17. [Instruções para utilizar serviços de nuvem (p. ex.: Onedrive)](/notes/rclone_cloudService_Setup.md)

18. Utilitários interessantes
- htop
```bash
sudo apt install htop
``` 
- nvtop <br>
Instalar o nv_top via apt.
NVTOP is a powerful GPU monitoring tool designed for Linux systems, including Ubuntu. It provides real-time statistics on GPU usage, memory consumption, temperature, and power draw. This tool is particularly useful for users who need to monitor multiple GPUs simultaneously, such as gamers, developers, and those working in machine learning. 
```bash
sudo apt install nvtop -y
``` 

## Tweeks Kubuntu - KDE Plasma 

1. System Setings: Wallpaper

---
> [Back to main](../main.md)
