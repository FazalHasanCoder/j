#!/bin/bash
set -e

# Download and install Godot 4.5 stable
GODOT_VERSION="4.5-stable"
DOWNLOAD_URL="https://github.com/godotengine/godot/releases/download/${GODOT_VERSION}/Godot_v${GODOT_VERSION}_linux.x86_64.zip"

echo "Downloading Godot ${GODOT_VERSION}..."
wget -q "$DOWNLOAD_URL" -O /tmp/godot.zip

echo "Extracting Godot..."
unzip -q /tmp/godot.zip -d /tmp/
rm /tmp/godot.zip

EXE_NAME=$(ls /tmp/ | grep -E "Godot_v.*_linux.*")

echo "Installing Godot executable..."
sudo mv "/tmp/${EXE_NAME}" /usr/local/bin/godot
sudo chmod +x /usr/local/bin/godot

# Ensure a default Godot 4.5 project configuration is in place
if [ ! -f "project.godot" ]; then
  echo "Creating default project.godot file..."
  cat << 'EOF' > project.godot
config_version=5

[application]
config/name="My Codespaces Game"
config/features=PackedStringArray("4.5", "Compatibility")

[rendering]
renderer/rendering_method="gl_compatibility"
renderer/rendering_method.mobile="gl_compatibility"
EOF
fi

# Create a desktop launcher on the VNC Fluxbox desktop to force software-based OpenGL
mkdir -p ~/Desktop
cat << 'EOF' > ~/Desktop/Launch_Godot.sh
#!/bin/bash
export LIBGL_ALWAYS_SOFTWARE=1
export GALLIUM_DRIVER=llvmpipe
godot -e --rendering-driver opengl3 --rendering-method gl_compatibility
EOF
chmod +x ~/Desktop/Launch_Godot.sh

# Create a launcher to start the on-screen keyboard (onboard)
cat << 'EOF' > ~/Desktop/Launch_Onscreen_Keyboard.sh
#!/bin/bash
# Start onboard (on-screen keyboard)
onboard &
EOF
chmod +x ~/Desktop/Launch_Onscreen_Keyboard.sh

echo "Installation complete!"
