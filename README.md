# docker-ubuntu-vnc-desktop

> A Docker image to provide web VNC interface, vscode, google-chrome, and tailscale!

## 1. Introduction

* YXHXianYu customized version of [docker-ubuntu-vnc-desktop](https://github.com/fcwu/docker-ubuntu-vnc-desktop)
* Supports
  * web VNC interface (Access http://localhost:6080 to enter a docker contain)
  * desktop environment (LXDE/LxQT)
  * vscode
  * google-chrome
  * edge
  * tailscale
* Applications
  * Using 2 VPNs at the same PC
  * Play with complete Linux without worrying about your own machine
  * Be a basic docker image

## 2. Quick Start

### 2.1 Build Docker Image

```bash
git clone git@github.com:YXHXianYu/docker-ubuntu-vnc-desktop.git
cd docker-ubuntu-vnc-desktop
docker build -t vnc-desktop .
```

* Then, you'll get a docker image named **vnc-desktop**

### 2.2 Run 

* Run with non-root user and some configs (YXHXianYu Using)

  * **You should customize this command**


  ```bash
  docker run -p 6080:80 -v /dev/shm:/dev/shm -e USER=user -e PASSWORD=elefant --name elefant -e RESOLUTION=1920x1080 -v E:\docker-ubuntu-vnc-desktop:/home/user/workspace --cap-add=NET_ADMIN --device=/dev/net/tun vnc-desktop
  ```

  * `-e USER=user -e PASSWORD=elefant`: Set default non-root user

  * `--name elefant`: Container's name
  
  * `-e RESOLUTION=1920x1080`: Using a fixed resolution.
    * **I don't recommend using this parameter!**
    * I have double screens, so I can use fullscreen all the time.
    * [Reference](https://github.com/fcwu/docker-ubuntu-vnc-desktop?tab=readme-ov-file#screen-resolution)

  * `-v E:\docker-ubuntu-vnc-desktop:/home/user/workspace`: Mount a directory to container
  
  * `--cap-add=NET_ADMIN --device=/dev/net/tun`: Enable TUN device

* Run with root user:

  ```bash
  docker run -p 6080:80 -v /dev/shm:/dev/shm --name elefant vnc-desktop
  ```

* Run with non-root user:

  ```bash
  docker run -p 6080:80 -v /dev/shm:/dev/shm --name elefant -e USER=user -e PASSWORD=password vnc-desktop
  ```

### 2.3 Access container

* Browse http://localhost:6080/

<img src="https://raw.github.com/fcwu/docker-ubuntu-vnc-desktop/master/screenshots/lxde.png?v1" width=700/>

* You can see a *bird logo* on the left side of the menu below.

### 2.4 Control container

* Restart: execute `docker restart elefant`
* Stop: execute `docker stop elefant`
* Start: execute `docker start elefant`

### 2.5 Tools

* Bash Shell
  * the bird logo -> System Tools -> LXTerminal
* Fish Shell
  * the bird logo -> System Tools -> fish
* Google Chrome
  * Non-root User & Root User
    * Open A Terminal (Bash Shell or Fish Shell)
    * Then execute `~/chrome.sh`
* VS Code
  * Non-root User
    * Method 1: the bird logo -> System Tools -> Visual Studio Code
    * Method 2: Execute `code`
  * Root User
    * Execute `~/code.sh`
* Tailscale
  * Non-root User
    * Execute `sudo ~/tailscale.sh`
  * Root User
    * Execute `~/tailscale.sh`
* Microsoft Edge
  * **You need to INSTALL edge manually**
  * Browse: https://www.microsoft.com/en-us/edge/business/download
  * Click: Linux -> .deb -> Download
  * Execute `sudo dpkg -i microsoft-edge-stable_*.deb` under your `~/Downloads`  directory
    * You may need install some extra package (see your logs)
  * After the installation, exec `microsoft-edge-stable` to start Edge
