
### Utilities

# ls
{{#if (is_executable "exa")~}}
alias l="exa --time-style long-iso --color=auto -F"
alias ll="l -Fahl"
alias la="l -a"

{{else~}}
alias l="ls --color=auto -F"
alias ll="l -Ahl"
alias la="l -a"

{{/if~}}

# navigation 
alias b="cd - > /dev/null && l" # back

# Package management
alias install='{{ install }}'
alias uninstall='{{ uninstall }}'
alias update='{{ update }}'

# CD
cd ()
{
    # Pass all arguments to cd
    builtin cd "$@" || return $?
    # If everything OK, print ls and todo
    l
    {{#if (is_executable "todo")~}}
    todo
    {{/if~}}
}

# Sorted diff
function diffs()
{
    diff "${@:3}" <(sort "$1") <(sort "$2")
}


{{#if (is_executable "bat")~}}
# cat
alias cat="bat"

{{/if~}}

{{#if (is_executable "thefuck")~}}

# fuck
eval $(thefuck --alias)

{{/if~}}

{{#if (is_executable "nvim")~}}
# Neovim
alias vim="nvim"

{{/if~}}

# Source the scripts environment file
source $HOME/.scripts/env

{{#if dotter.packages.cargo~}}
# Rust
soruce $HOME/.cargo/env
alias rust-esp='docker run --rm -ti -v "$PWD":/home/project:z quay.io/ctron/rust-esp'
alias rust-musl='docker run --rm -it -v "$PWD":/home/rust/src ekidd/rust-musl-builder'

{{/if~}}

{{#if dotter.packages.gpg~}}
# gpg-agent

{{#if is_wsl2~}}
# WSL2 gpg relay (https://blog.nimamoh.net/yubi-key-gpg-wsl2/)
gpg-agent-relay start
export SSH_AUTH_SOCK=$HOME/.gnupg/S.gpg-agent.ssh

{{else~}}
# Any native Linux
export GPG_TTY="$(tty)"
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
gpgconf --launch gpg-agent
gpg-connect-agent updatestartuptty /bye > /dev/null

{{/if~}}

# Sometimes key refuses to sign the messages after some time with the session being open
# but gpg-agent does not reset the session, hence some ducttape here
alias ssh="gpg-connect-agent updatestartuptty /bye > /dev/null; ssh"
alias scp="gpg-connect-agent updatestartuptty /bye > /dev/null; scp"
alias git="gpg-connect-agent updatestartuptty /bye > /dev/null; git"

{{/if~}}

{{#if (is_executable "/opt/texlive/2021/bin/x86_64-linux/tex")~}}
# texlive
export PATH="$PATH:/opt/texlive/2021/bin/x86_64-linux"
export MANPATH="$MANPATH:/opt/texlive/2021/texmf-dist/doc/man"
export INFOPATH="$INFOPATH:/opt/texlive/2021/texmf-dist/doc/info"

{{/if~}}

export PATH="$PATH:$HOME/.local/bin"

{{#if (is_executable "brew")~}}
eval "$(brew shellenv)"
{{/if~}}

