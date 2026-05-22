 RClone OneDrive Setup Guide

## 1. Install rclone

```bash
sudo apt install rclone        # Debian/Ubuntu
sudo dnf install rclone        # Fedora
```

---

## 2. Configure OneDrive remote

```bash
rclone config
```

- `n` → new remote
- Name it `OneDrive`
- Choose `Microsoft OneDrive` from the list
- Leave Client ID and Secret **blank** (press Enter)
- Follow the OAuth browser authentication flow
- Choose your OneDrive type (personal or business)
- Confirm and save

Verify your remote:
```bash
rclone listremotes
```

---

## 3. Sync Documents to OneDrive

```bash
/usr/bin/rclone sync $HOME/Documents OneDrive:Linux_Documents \
    --log-file=$HOME/rclone-backup.log \
    --log-level INFO
```

---

## 4. Create the backup script - precisa a

Create the script:
```bash
sudo nano /usr/local/bin/rclone_backup.sh
```

Add this content:
```bash
#!/bin/bash

/usr/bin/rclone sync $HOME/Documents OneDrive:Linux_Documents \
    --log-file=$HOME/rclone-backup.log \
    --log-level INFO
```

Make it executable:
```bash
chmod +x /usr/local/bin/rclone_backup.sh
```

Run it manually:
```bash
/usr/local/bin/rclone-backup.sh
```

---

## 5. Schedule with cron (every day at 8h)

Open crontab:
```bash
crontab -e
```

Add this line at the bottom (followed by a blank line):
```
0 8 * * * /usr/local/bin/rclone-backup.sh ; /usr/local/bin/backup.sh
```

Verify:
```bash
crontab -l
```

---

## 6. Mount OneDrive at boot (systemd)

### Create the mount point

```bash
sudo mkdir -p /mnt/onedrive
sudo chown $USER:$USER /mnt/onedrive
```

### Create the systemd service file

```bash
sudo nano /etc/systemd/system/rclone-onedrive.service
```
to find the username use this command:
```bash
whoami
```

Add this content (replace `YOUR_USERNAME` with your actual username):
```ini
[Unit]
Description=RClone OneDrive Mount
After=network-online.target
Wants=network-online.target

[Service]
Type=simple
User='<YOUR_USERNAME>'
ExecStart=/usr/bin/rclone mount OneDrive: /mnt/onedrive --vfs-cache-mode full --log-file=/home/'<YOUR_USERNAME>'/rclone-mount.log --log-level INFO
ExecStop=/bin/fusermount -u /mnt/onedrive
Restart=on-failure

[Install]
WantedBy=multi-user.target
```

### Enable and start the service

```bash
sudo systemctl daemon-reload
sudo systemctl enable rclone-onedrive
sudo systemctl start rclone-onedrive
```

### Check status

```bash
systemctl status rclone-onedrive
ls /mnt/onedrive
```

### Troubleshooting

```bash
systemctl status rclone-onedrive.service
journalctl -xe | grep rclone
```

---

## 7. Test mount manually

Foreground (blocks terminal):
```bash
rclone mount OneDrive: /mnt/onedrive --vfs-cache-mode full
```

Background (daemon mode):
```bash
rclone mount OneDrive: /mnt/onedrive --vfs-cache-mode full --daemon
```

Unmount:
```bash
fusermount -u /mnt/onedrive
```

---

## Quick Reference

| Command | Description |
|---|---|
| `rclone listremotes` | List configured remotes |
| `rclone sync src dest` | Sync source to destination (destructive) |
| `rclone copy src dest` | Copy only, no deletions |
| `rclone mount remote: /mnt/point` | Mount remote as local folder |
| `fusermount -u /mnt/point` | Unmount |
| `crontab -e` | Edit cron jobs |
| `crontab -l` | List cron jobs |
| `systemctl status rclone-onedrive` | Check mount service status |

>Fontes:
>>[rclone on onedrive](https://itsfoss.com/use-onedrive-linux-rclone/) <br>
>>[rclone on googledrive](https://rclone.org/drive/?ref=itsfoss.com)