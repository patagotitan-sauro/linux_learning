# Local AI Stack Setup Guide
## Ollama + Open WebUI + SearXNG on Kubuntu 26.04

This guide walks you through setting up a fully local, private AI assistant with web search capabilities on Kubuntu 26.04.

---

## What We Are Building

A complete local AI stack made of three components:

- **Ollama** — runs AI language models locally on your machine
- **Open WebUI** — a beautiful chat interface (similar to ChatGPT) that connects to Ollama
- **SearXNG** — a private, open source search engine that gives the AI access to the internet

All three run entirely on your machine. Your data never leaves your computer.

---

## Prerequisites

### Hardware Requirements

| Component | Minimum | Recommended |
|---|---|---|
| RAM | 8GB | 16GB+ |
| Disk Space | 20GB free | 50GB+ |
| GPU | Optional | Nvidia or AMD dGPU |

> The Ryzen 5 8500G with 16GB RAM works well for 7B parameter models running on CPU.

### Software Requirements

- Kubuntu 26.04 LTS (Resolute Raccoon)
- Internet connection (only for initial setup and downloading models)

---

## Step 1 — Install Docker

Docker is the platform that runs our applications inside isolated containers. Think of containers as lightweight virtual machines that package everything an app needs to run.

### Check if Docker is already installed:
```bash
docker --version
docker compose version
```

If both return version numbers, skip to Step 2.

### Install Docker:
```bash
# Remove any old versions
sudo apt remove docker docker-engine docker.io

# Install dependencies
sudo apt update
sudo apt install ca-certificates curl gnupg

# Add Docker's GPG key
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

# Add Docker repository
echo \
"deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
https://download.docker.com/linux/ubuntu \
$(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Install Docker
sudo apt update
sudo apt install docker-ce docker-ce-cli containerd.io docker-compose-plugin
```

### Add your user to the Docker group (run Docker without sudo):
```bash
sudo usermod -aG docker $USER
newgrp docker
```

### Verify Docker works:
```bash
docker run hello-world
```

You should see: **"Hello from Docker!"**

### Enable Docker to start on boot:
```bash
sudo systemctl enable docker
```

This ensures Docker and all containers start automatically when you turn on your machine.

---

## Step 2 — Install Ollama

Ollama is the engine that downloads and runs AI models locally on your machine.

```bash
curl -fsSL https://ollama.com/install.sh | sh
```

### Verify Ollama is running:
```bash
curl http://localhost:11434
```

Should return: **"Ollama is running"**

### Download AI models:

Choose models based on your available RAM:

```bash
# Good all-around model (4.4GB) — recommended to start
ollama pull mistral

# Coding focused model (3.8GB)
ollama pull codellama

# Advanced coding model (4.7GB)
ollama pull qwen2.5-coder

# List all downloaded models
ollama list
```

> **Note:** Ollama is installed natively (not in Docker) so it can directly access your hardware for better performance.

---

## Step 3 — Create the Project Folder

Create a dedicated folder to keep all configuration files organized:

```bash
mkdir ~/ai-stack
cd ~/ai-stack
```

---

## Step 4 — Create the SearXNG Configuration

SearXNG needs a settings file to configure its behavior. First create the folder:

```bash
mkdir ~/ai-stack/searxng
```

Then create the settings file:

```bash
micro ~/ai-stack/searxng/settings.yml
```

Paste this content:

```yaml
use_default_settings: true

server:
  secret_key: "change-this-to-a-random-string-123456"
  limiter: false
  image_proxy: true

ui:
  static_use_hash: true

search:
  safe_search: 0
  autocomplete: ""
  default_lang: ""
  formats:
    - html
    - json
```

Save with **Ctrl+S** then quit with **Ctrl+Q**.

### Key settings explained:

| Setting | Value | Why |
|---|---|---|
| `secret_key` | any random string | Security key for SearXNG |
| `limiter: false` | false | Disables rate limiting so Open WebUI can query freely |
| `default_lang: ""` | empty | Auto-detects language — handles English and Portuguese |
| `formats: json` | json | **Critical** — allows Open WebUI to read search results |

---

## Step 5 — Create the Docker Compose File

The `docker-compose.yml` file defines all services and how they connect. This is the heart of our setup.

```bash
micro ~/ai-stack/docker-compose.yml
```

Paste this content:

```yaml
services:
  open-webui:
    image: ghcr.io/open-webui/open-webui:latest
    container_name: open-webui
    restart: unless-stopped
    network_mode: host
    environment:
      - PORT=3000
      - OLLAMA_BASE_URL=http://localhost:11434
      - ENABLE_WEB_SEARCH=True
      - WEB_SEARCH_ENGINE=searxng
      - SEARXNG_QUERY_URL=http://localhost:8080/search?q=<query>
    volumes:
      - openwebui_data:/app/backend/data

  searxng:
    image: searxng/searxng:latest
    container_name: searxng
    restart: unless-stopped
    ports:
      - "8080:8080"
    volumes:
      - ./searxng:/etc/searxng:rw

volumes:
  openwebui_data:
```

Save with **Ctrl+S** then quit with **Ctrl+Q**.

### File structure explained:

| Section | What it does |
|---|---|
| `image` | Which Docker image to download and run |
| `container_name` | Name of the running container |
| `restart: unless-stopped` | Auto-restart if it crashes or on machine reboot |
| `network_mode: host` | Uses host network so Open WebUI can reach native Ollama |
| `PORT=3000` | Forces Open WebUI to use port 3000 |
| `OLLAMA_BASE_URL` | Where Open WebUI finds Ollama |
| `ENABLE_WEB_SEARCH` | Turns on web search feature |
| `SEARXNG_QUERY_URL` | Where Open WebUI sends search queries |
| `volumes` | Persists data even if container is deleted |

---

## Step 6 — Launch Everything

Make sure you are in the project folder:

```bash
cd ~/ai-stack
```

Start all services in the background:

```bash
docker compose up -d
```

Docker will automatically download all required images on first run. This may take a few minutes depending on your internet speed.

### Verify everything is running:
```bash
docker ps
```

You should see two containers running:
- `open-webui` — status: healthy
- `searxng` — status: Up

---

## Step 7 — Access the Applications

Open your browser and navigate to:

| Service | URL | What it is |
|---|---|---|
| **Open WebUI** | http://localhost:3000 | Your AI chat interface |
| **SearXNG** | http://localhost:8080 | Your private search engine |

### First time setup in Open WebUI:
1. Create an **admin account** — the first user is always the administrator
2. Your downloaded models appear automatically in the **model selector** at the top of the chat
3. To use web search, click the **🌐 globe icon** in the chat input bar before sending a message

---

## Step 8 — Create a Desktop Launcher (Optional)

Create a KDE desktop launcher to open Open WebUI with one click:

```bash
micro ~/.local/share/applications/openwebui.desktop
```

Paste this content:

```ini
[Desktop Entry]
Version=1.0
Type=Application
Name=Open WebUI
Comment=Local AI Chat Interface
Exec=xdg-open http://localhost:3000
Icon=internet-web-browser
Terminal=false
Categories=Network;AI;
```

Make it executable:

```bash
chmod +x ~/.local/share/applications/openwebui.desktop
```

It will now appear in your KDE application menu. Right click it to add to desktop or pin to taskbar.

---

## Daily Usage

### Your stack starts automatically on boot!
Because of `restart: unless-stopped` and Docker being enabled on boot, everything starts automatically when you turn on your machine. Just wait ~30 seconds and open your browser.

### Useful commands:

| Command | What it does |
|---|---|
| `docker compose up -d` | Start all services |
| `docker compose down` | Stop all services |
| `docker compose restart` | Restart all services |
| `docker ps` | Check running containers |
| `docker logs open-webui` | See Open WebUI logs |
| `docker logs searxng` | See SearXNG logs |
| `ollama list` | List downloaded models |
| `ollama pull <model>` | Download a new model |

---

## Using Web Search

1. Open http://localhost:3000
2. Start a new chat
3. Click the **🌐 globe icon** in the chat input to enable web search
4. Ask any question requiring current information
5. The response will include **source links** showing which websites were searched

---

## Switching Between Models

In Open WebUI, at the top of any chat window there is a **model selector dropdown**. Click it to switch between your downloaded models:

- `mistral` — best for general questions
- `codellama` — best for coding help
- `qwen2.5-coder` — advanced coding assistant
- `deepseek-coder-v2` — powerful coding model

You can also use **multi-model mode** to send the same prompt to multiple models simultaneously and compare their responses side by side.

---

## Folder Structure

After completing this guide your project folder looks like this:

```
~/ai-stack/
├── docker-compose.yml       ← main configuration file
└── searxng/
    └── settings.yml         ← SearXNG configuration
```

Docker manages all data volumes automatically. Chat history, users, and settings are stored in the `openwebui_data` Docker volume.

---

## Troubleshooting

### Open WebUI not loading on port 3000
```bash
# Check if containers are running
docker ps

# Check logs for errors
docker logs open-webui --tail 50

# Restart everything
docker compose down && docker compose up -d
```

### Web search not working
```bash
# Test SearXNG directly
curl "http://localhost:8080/search?q=test&format=json"

# Should return JSON with search results
# If empty, check ~/ai-stack/searxng/settings.yml has json in formats
```

### Ollama not reachable
```bash
# Check Ollama is running
curl http://localhost:11434

# Restart Ollama service
sudo systemctl restart ollama
```

### Models not appearing in Open WebUI
```bash
# Verify models are downloaded
ollama list

# Restart Open WebUI
docker restart open-webui
```

---

*Guide created for Kubuntu 26.04 LTS with Ryzen 5 8500G and 16GB RAM.*
