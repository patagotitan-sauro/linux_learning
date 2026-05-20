## Access and create OneDrive folders

1. Install `rclone`

```bash
sudo apt install rclone
```
2. Configure it: `rclone config` - follow the prompts to add OneDrive as a remote.

3. Mount it as a folder
Vc precisa montar (mount) o OneDrive folder toda vez
```bash
mkdir ~/OneDrive/<name_of_folder>
rclone mount onedrive: ~/OneDrive/<name_of_folder> --daemon
```
4. Criar um cronjob `crontab -e`

5. adiocionar o seguinte
```bash
@reboot rclone mount OneDrive:/<folder_name> ~/<folder_in_local_machine_name> --daemon
```
### pesquisar opção de incluir no systemd
1. `sudo micro /etc/systemd/system/rclone-onedrive.service`

2. editar arquivo ...
```bash
#ini
[Unit]
Description=RClone OneDrive Mount
After=network-online.target
Wants=network-online.target

[Service]
User=rouse
ExecStart=rclone mount OneDrive:/Linux_Documents /home/rouse/Linux_Documents
ExecStop=/bin/fusermount -u /home/rouse/Linux_Documents
Restart=on-failure

[Install]
WantedBy=default.target
```
3. enable it
```bash
sudo systemctl enable rclone-onedrive
sudo systemctl start rclone-onedrive
``
---