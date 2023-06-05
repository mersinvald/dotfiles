#!/bin/bash

# Deploy systemd services
if [ -d ~/.deploy/systemd ]; then 
    for service in $(ls ~/.deploy/systemd -I *.enable); do
        sudo cp ~/.deploy/systemd/$service /etc/systemd/system/$service.service -v
    done

    sudo systemctl daemon-reload

    shopt -s nullglob
    enablelist=(~/.deploy/systemd/*.enable)
    shopt -u nullglob

    for enable in $enablelist; do
        if [ "$(cat $enable)" == "true" ]; then
            enable=$(basename -- $enable)
            service=${enable%.*}.service
            echo systemctl enable $service
            sudo systemctl enable $service
        fi
    done
fi

# Deploy udev rules
if [ -d  ~/.deploy/udev ]; then 
    for rule in ~/.deploy/udev/*; do
        sudo cp $rule /etc/udev/rules.d/ -v
    done
    sudo udevadm control --reload-rules
fi

# Deploy sudoers rules
if [ -d  ~/.deploy/sudoers ]; then 
    mkdir -p /etc/sudoers.d
    sudo touch /etc/sudoers.d/README
    for rule in ~/.deploy/sudoers/*; do
        sudo cp $rule /etc/sudoers.d/ -v
    done
    sudo chmod -R 0440 /etc/sudoers.d/
fi


{{#if dotter.packages.hid-server~}}
if [ ! -f ~/.cargo/bin/hid_server ]; then 
    git clone git@github.com:mersinvald/hid-server.git /tmp/hid-server
    pushd /tmp/hid-server
    cargo install -f --path .
    popd
fi
{{/if~}}


{{#if dotter.packages.tmux~}}
if [ ! -d ~/.config/tmux/plugins/tpm ]; then 
    git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm
fi
{{/if~}}

{{#if dotter.packages.neovim~}}
if [ ! -d ~/.local/share/nvim/site/pack/packer/start/packer.nvim ]; then
    git clone --depth 1 https://github.com/wbthomason/packer.nvim \
        ~/.local/share/nvim/site/pack/packer/start/packer.nvim
fi  
{{/if~}}
