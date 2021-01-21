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