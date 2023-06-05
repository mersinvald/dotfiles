#!/bin/bash

# Abort if git is not installed
if ! [ -x "$(command -v git)" ]; then
    echo 'Error: git is not installed.' >&2
    exit 1
fi

# Abort if cargo is not installed
if ! [ -x "$(command -v cargo)" ]; then
    echo 'Error: cargo is not installed.' >&2
    exit 1
fi

# Install dotter if not installed
if ! [ -x "$(command -v dotter)" ]; then
    cargo install dotter --git https://github.com/mersinvald/dotter.git -f
fi

# Clone dotfiles repo via ssh if ssh-keys exist
# Skip if ~/.dotfiles already exists
if [ ! -d ~/.dotfiles ]; then
    if [ -f ~/.ssh/id_rsa.pub ]; then
        git clone git@github.com:mersinvald/dotfiles.git ~/.dotfiles
    else 
        git clone git@github.com:mersinvald/dotfiles.git ~/.dotfiles
    fi
fi

# Run dotter

