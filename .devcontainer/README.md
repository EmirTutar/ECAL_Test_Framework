===============================
Dev Container Setup for VS Code
===============================

Goal:
-----
This setup helps you develop inside a ready-to-use eCAL environment using Visual Studio Code and Docker.

What you need:
--------------
- Docker (must be installed and running)
- Visual Studio Code
- "Dev Containers" extension for VS Code:
  https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers

What this setup includes:
-------------------------
- Based on a custom Docker image (ecal_base)
- Preinstalled tools:
  - tclap (for command line parsing)
  - robotframework and docker (for integration tests)
  - Python 3 and Pip
- Useful VS Code extensions:
  - C/C++ support
  - Python support
  - Robot Framework support (RobotCode by Daniel Biehl)

Folder structure:
-----------------
<your-project-folder>/
├── .devcontainer/
│   ├── devcontainer.json
│   ├── Dockerfile
│   └── requirements.txt

How to use it:
--------------
1. Open this folder in Visual Studio Code.

2. Start the dev container:
   - Click the green icon in the bottom-left corner
   - Or run this from the command palette (F1):
     "Dev Containers: Reopen in Container"

3. Wait for the setup to build the image.
   - First time build may take 20–30 minutes.

4. Ready!
   - You now work inside a complete development environment.
   - Headers like `ecal.h` or `tclap/CmdLine.h` will be recognized.
   - Build, test, and run everything inside the container.

Notes:
------
- If you change Dockerfile or requirements.txt, run:
  "Dev Containers: Rebuild Container"

- Your source code is mounted in the container under /workspace.

- All changes are synced with your local files.

Troubleshooting:
----------------
- Make sure Docker is running.
- Try "Dev Containers: Rebuild Container"
- Check logs under: View → Output → Dev Containers