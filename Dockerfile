# 使用 phusion/baseimage 作为基础镜像
FROM dorowu/ubuntu-desktop-lxde-vnc

# apt 使用清华大学的镜像源
RUN printf "deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ noble main restricted universe multiverse\n\
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ noble-updates main restricted universe multiverse\n\
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ noble-backports main restricted universe multiverse\n\
deb http://security.ubuntu.com/ubuntu/ noble-security main restricted universe multiverse\n" > /etc/apt/sources.list

# add google chrome repository public key
RUN wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | sudo apt-key add -

# install some tools
RUN apt-get update
# For microsoft edge
RUN apt-get install -y libu2f-udev

# VSCode
RUN curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg \
    && install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/ \
    && sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list' \
    && apt-get install -y apt-transport-https \
    && apt-get update \
    && apt-get install -y code \
    && rm microsoft.gpg

# Fish Shell
RUN apt-get install -y fish
RUN chsh -s /usr/bin/fish

# Tailscale
RUN curl -fsSL https://tailscale.com/install.sh | sh

# VSCode DONT_PROMPT_WSL_INSTALL
ENV DONT_PROMPT_WSL_INSTALL=1


# ===== Root User (NOT Recommended) =====
# Tailscale Start Script (For root user)
RUN echo '#!/bin/bash' > /root/tailscale.sh
RUN echo 'nohup tailscaled > ~/tailscaled.log 2>&1 &' >> /root/tailscale.sh
RUN echo 'tailscale up --accept-routes' >> /root/tailscale.sh
RUN chmod +x /root/tailscale.sh
# VSCode Start Script (For root user)
RUN echo '#!/bin/bash' > /root/code.sh
RUN echo 'code --no-sandbox --user-data-dir=/root/.vscode' >> /root/code.sh
RUN chmod +x /root/code.sh
# Google Chrome Start Script (For root user)
RUN echo '#!/bin/bash' > /root/chrome.sh
RUN echo 'google-chrome-stable --no-sandbox' >> /root/chrome.sh
RUN chmod +x /root/chrome.sh


# ===== "User" User (Recommended) =====
RUN mkdir -p /home/user
# Tailscale Start Script
RUN echo '#!/bin/bash' > /home/user/tailscale.sh
RUN echo 'nohup tailscaled > ~/tailscaled.log 2>&1 &' >> /home/user/tailscale.sh
RUN echo 'tailscale up --accept-routes' >> /home/user/tailscale.sh
RUN chmod +x /home/user/tailscale.sh
# please run with "sudo"

# VSCode Start Script (No need)

# Google Chrome Start Script
RUN echo '#!/bin/bash' > /home/user/chrome.sh
RUN echo 'google-chrome-stable --no-sandbox' >> /home/user/chrome.sh
RUN chmod +x /home/user/chrome.sh

# My Toolset
RUN apt-get install -y tldr tree