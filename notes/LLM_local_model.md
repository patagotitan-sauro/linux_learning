# LLM local model


Here's your complete roadmap:

---
### Phase 1 — Ollama (the engine)

1. Open terminal <br>   

2. Install Ollama

Copy and paste this command
```bash
curl -fsSL https://ollama.com/install.sh | sh
```
This will take 1-2 minutes. You'll see output scrolling — that's normal.

3. Verify Ollama is running

```bash
ollama --version
```
```bash
systemctl status ollama
```

4. Test in terminal <br>

check Ollama service is active
```bash
curl http://localhost:11434
```

---

### Phase 2 — Install Mistral (the model)

1. Download Mistral 7B via Ollama


2. Run a quick test in terminal
3. Exit terminal chat
---

### Phase 3 — Docker (the platform)

1. Remove any old Docker versions

```bash
# Remove any old versions
sudo apt remove docker docker-engine docker.io
# Install dependencies
sudo apt update
sudo apt install ca-certificates curl
```
2. Add Docker's official repository
```bash
# Add Docker's official repo
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg \
  -o /etc/apt/keyrings/docker.asc

echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/docker.asc] \
  https://download.docker.com/linux/ubuntu noble main" | \
  sudo tee /etc/apt/sources.list.d/docker.list
```

3. Install Docker

```bash
# Install Docker
sudo apt update
sudo apt install docker-ce docker-ce-cli containerd.io
```

4. Add your user to Docker group
```bash
# Allow running Docker without sudo
sudo usermod -aG docker $USER
newgrp docker
```


5. Verify Docker is working

---

### Phase 4 — Open WebUI (the interface)

1. Run Open WebUI container via Docker
2. Open browser at localhost:3000
3. Create admin account
4. Connect to Ollama
5. Select Mistral model
6. First chat test
---

### Phase 5 — Daily use

1. Learn to start/stop services
```bash
docker run -d -p 3000:80 ghcr.io/open-webui/open-webui:main
```

2. Download more models to test
3. Switch between models in Open WebUI
---


### Install ROCm (AMD iGPU acceleration)
```bash
# Add ROCm repository
sudo apt update
wget https://repo.radeon.com/amdgpu-install/6.1/ubuntu/jammy/amdgpu-install_6.1.60100-1_all.deb
sudo apt install ./amdgpu-install_6.1.60100-1_all.deb

# Install ROCm
sudo amdgpu-install --usecase=rocm

# Add user to render and video groups
sudo usermod -aG render,video $USER
```


## 

## Install docker 
