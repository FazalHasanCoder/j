FROM mcr.microsoft.com/devcontainers/base:ubuntu-22.04

# Install standard dependencies for Godot's GUI and software-based OpenGL rendering
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
    && apt-get clean && rm -rf /var/lib/apt/lists/*
FROM mcr.microsoft.com/devcontainers/base:ubuntu-22.04

# Install standard dependencies for Godot's GUI and software-based OpenGL rendering
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
    && apt-get clean && rm -rf /var/lib/apt/lists/*
