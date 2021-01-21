source $HOME/.profile
source $HOME/.antigen/antigen.zsh

antigen use oh-my-zsh

antigen bundle dotenv
antigen bundle git
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle hlissner/zsh-autopair
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zpm-zsh/clipboard
antigen bundle peterhurford/git-it-on.zsh
antigen bundle DarrinTisdale/zsh-aliases-exa

# Autoupdate
antigen bundle unixorn/autoupdate-antigen.zshplugin

# Load the theme
antigen theme miloshadzic

antigen apply

{{#if (is_executable "zoxide")~}}
eval "$(zoxide init zsh)"
{{/if~}}