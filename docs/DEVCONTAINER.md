# Devcontainer for Godot 4.5 (Codespaces)

Summary
- Adds a Codespaces devcontainer that installs Godot 4.5 (linux.x86_64), noVNC desktop, and an on-screen keyboard (`onboard`) to allow typing from the browser VNC.

Files added
- `.devcontainer/Dockerfile` — base image + dependencies including `onboard` and `x11vnc`.
- `.devcontainer/setup-godot.sh` — downloads Godot, installs binary to `/usr/local/bin/godot`, creates desktop launchers: `Launch_Godot.sh` and `Launch_Onscreen_Keyboard.sh`.
- `.devcontainer/devcontainer.json` — config for Codespaces; `postCreateCommand` makes the script executable and runs it.

Plan & Workflow
1. Create `.devcontainer` files and push to repo.
2. Create a Codespace (2 vCPU) for this repo.
3. Wait for build; `postCreateCommand` runs and installs Godot.
4. Open forwarded port 6080 (noVNC Desktop) and connect with password `vscode`.
5. Use the desktop icons: double-click `Launch_Onscreen_Keyboard.sh` to open an on-screen keyboard, then use `Launch_Godot.sh` to start Godot with software rendering.

Notes / Issues & Fixes
- Keyboard input in browser VNC can sometimes not map correctly; installing `onboard` provides an on-screen keyboard that works inside the VNC desktop.
- Codespaces containers have no GPU; Godot must be forced to use software GL: `LIBGL_ALWAYS_SOFTWARE=1` and `GALLIUM_DRIVER=llvmpipe` are exported in the Godot launcher script.
- Shell scripts in the container must be executable: devcontainer's `postCreateCommand` ensures `setup-godot.sh` is made executable and run. If running locally, run `chmod +x .devcontainer/setup-godot.sh`.

How to commit and create Codespace
```
git add .devcontainer docs/DEVCONTAINER.md
git commit -m "Add Codespaces devcontainer for Godot 4.5 with onboard keyboard"
git push origin main
```

What I implemented for you
- Created the devcontainer files and added an on-screen keyboard launcher.

Next steps you must do (cannot be done from here)
- Commit & push the changes (commands above).
- Create a Codespace on this repository and choose the 2 vCPU machine.
- Open port 6080 from the Codespace Ports view and click Open in Browser.

If anything fails when building the Codespace, capture the build logs and I will iterate fixes (common fixes: missing packages, network timeouts when downloading Godot, or permission errors).
