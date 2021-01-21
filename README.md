# mersinvald's dotfiles

This repo holds every piece of common configuration for my workstations.

The dotfiles templating is powered by an awesome [dotter](https://github.com/SuperCuber/dotter), with some scripts to manage the root configuration files on top of that (systemd services, udev rules, etc).

To see how to apply those dotfiles, see the dotter documentation. Below you can find format descripton for the systemd services and udev rules.

### Adding a systemd service

Services are defined in `root/systemd`, by name: for example `root/systemd/docker` will be copied into `/etc/systemd/system/docker.service`.

To enable a service post-deploy, create a `service-name.enable` file in the same directory, containing a single line -- "true" or "false".

Those files can be templated with handlebars

### Adding a udev rule

Add a rule file into `root/udev`. Those files are copied as-is.

### Adding a pam rule

Pam rules are located in `root/pam`, but aren't applied automatically, and are supposed to be manually copied/edited into the `/etc/pam.d`, since it's just asking for trouble otherwise -- with the base rules usually being different on different operation systems. (анус себе можно заблокировать).