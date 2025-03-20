#!/bin/bash

# Define the base path for models and custom nodes
BASE_PATH="../models"
CUSTOM_NODES_PATH="../custom_nodes"

# Create necessary directories if they don't exist
mkdir -p "$BASE_PATH/checkpoints"
mkdir -p "$BASE_PATH/pulid"
mkdir -p "$BASE_PATH/loras"
mkdir -p "$BASE_PATH/pulidflux"
mkdir -p "$CUSTOM_NODES_PATH"

# Function to download file if it doesn't exist
download_if_not_exist() {
    local file_path="$1"
    local url="$2"
    
    if [ ! -f "$file_path" ]; then
        echo "Downloading: $file_path"
        wget -O "$file_path" "$url"
    else
        echo "File already exists: $file_path"
    fi
}

# Function to clone or update a custom node repository
clone_or_update_repo() {
    local repo_url="$1"
    local folder_name="$2"
    local repo_path="$CUSTOM_NODES_PATH/$folder_name"

    if [ ! -d "$repo_path" ]; then
        echo "Cloning repository: $repo_url into $repo_path"
        git clone "$repo_url" "$repo_path"
    else
        echo "Repository already exists: $repo_path. Updating..."
        cd "$repo_path" && git pull origin main
    fi
}

# Download Stable Diffusion models

download_if_not_exist "$BASE_PATH/checkpoints/flux1-dev-fp8.safetensors" "https://huggingface.co/Kijai/flux-fp8/resolve/main/flux1-dev-fp8.safetensors"


# Clone or update the required custom nodes
clone_or_update_repo "https://github.com/Gourieff/ComfyUI-ReActor.git" "ComfyUI-ReActor"
clone_or_update_repo "https://github.com/Goktug/comfyui-saveimage-plus.git" "comfyui-saveimage-plus"

# Install dependencies for the custom nodes
echo "Installing dependencies for ComfyUI..."
pip install -r "$CUSTOM_NODES_PATH/comfyui-saveimage-plus/requirements.txt"
pip install -r "$CUSTOM_NODES_PATH/ComfyUI-ReActor/requirements.txt"

# Completion message
echo "Installation complete! Models and custom nodes are installed."