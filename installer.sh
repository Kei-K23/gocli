#!/bin/bash

# Project name
PROJECT_NAME="gocli"

# Determine the OS type
OS=$(uname -s)

# Set the appropriate installation path based on the OS
if [ "$OS" == "Linux" ]; then
    INSTALL_PATH="/usr/local/bin"
elif [ "$OS" == "Darwin" ]; then
    INSTALL_PATH="/usr/local/bin"
elif [[ "$OS" == CYGWIN* || "$OS" == MINGW* || "$OS" == MSYS* ]]; then
    INSTALL_PATH="/usr/bin"
    SUDO_CMD=""
else
    echo "Unsupported OS: $OS"
    exit 1
fi

# Remove binary file if it exists
if [ -f "$PROJECT_NAME" ]; then
    echo "Removing existing binary file"
    rm -rf "$PROJECT_NAME"
fi

# Check if the project binary already exists
if [ -f "$INSTALL_PATH/$PROJECT_NAME" ]; then
    echo "$PROJECT_NAME already exists in $INSTALL_PATH. Removing existing binary..."
    if [[ "$OS" == CYGWIN* || "$OS" == MINGW* || "$OS" == MSYS* ]]; then
        rm -f "$INSTALL_PATH/$PROJECT_NAME"
    else
        sudo rm -f "$INSTALL_PATH/$PROJECT_NAME"
    fi
    
    # Check if the removal was successful
    if [ $? -ne 0 ]; then
        echo "Failed to remove existing $PROJECT_NAME binary. Please check your permissions."
        exit 1
    fi
fi

# Print a message
echo "Building $PROJECT_NAME..."

# Build the Go project
go build -o $PROJECT_NAME

# Check if the build was successful
if [ $? -ne 0 ]; then
    echo "Build failed. Please check your Go code for errors."
    exit 1
fi

# Move the binary to the installation path
echo "Installing $PROJECT_NAME to $INSTALL_PATH..."

if [[ "$OS" == CYGWIN* || "$OS" == MINGW* || "$OS" == MSYS* ]]; then
    mv $PROJECT_NAME $INSTALL_PATH
else
    sudo mv $PROJECT_NAME $INSTALL_PATH
fi

# Check if the move was successful
if [ $? -ne 0 ]; then
    echo "Failed to move the binary to $INSTALL_PATH. Please check your permissions."
    exit 1
fi

# Print a success message
echo "$PROJECT_NAME installed successfully to $INSTALL_PATH. You can now use '$PROJECT_NAME' from anywhere in your terminal."

# Exit the script
exit 0
