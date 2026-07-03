FROM mcr.microsoft.com/devcontainers/base:ubuntu-22.04

# Install standard dependencies for Godot's GUI, a lightweight desktop, and software-based OpenGL rendering
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends \
       wget \
       unzip \
       libgl1-mesa-dri \
       libgl1-mesa-glx \
       libvulkan1 \
       mesa-vulkan-drivers \
       xvfb \
       xterm \
       jq \
       x11vnc \
       onboard \
       fluxbox \
       python3 python3-pip \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Install Python-based noVNC support and websockify
RUN python3 -m pip install --no-cache-dir websockify==0.10.0
