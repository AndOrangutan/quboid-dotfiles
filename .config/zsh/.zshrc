
export PATH=$PATH:/usr/bin:/use/bin/python3

export LC_ALL=en_US.UTF-8
export LANG="UTF-8"

###########
# Aliases #
###########


export ZDOTDIR="$HOME/.config/zsh/"
source $ZDOTDIR/aliases
source $ZDOTDIR/.zshenv

########################
# Set color and prompt #
########################
autoload -U colors && colors

###########
# History #
###########
HISTFILE=~/.cache/zsh/history
HISTSIZE=10000
SAVEHIST=10000

############################
# Set Keyboard Repeat Rate #
############################

###########################
# Basic auto/tab complete #
###########################
autoload -Uz compinit 
compinit
zstyle ':completion::complete:*' gain-privileges 1
zstyle ':completion:*' menu select
zstyle ':completion:*' rehash true
zmodload zsh/complist
_comp_options+=(globdots)

#################
# Sane defaults #
#################
setopt autocd
setopt COMPLETE_ALIASES
unsetopt beep

###########
# vi mode #
###########
bindkey -v
export KEYTIMEOUT=1

############
# Setup ZK #
#############
#export ZK_NOTEBOOK_DIR="$HOME/Dropbox/Notebooks/Compendium"
export ZK_NOTEBOOK_DIR="$HOME/Dropbox/Notebooks/Compendium"



##################
# History search #
##################
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

[[ -n "${key[Up]}"   ]] && bindkey -- "${key[Up]}"   up-line-or-beginning-search
[[ -n "${key[Down]}" ]] && bindkey -- "${key[Down]}" down-line-or-beginning-s

##################
# bareback setup #
##################
#alias bareback='/usr/bin/git --git-dir=$HOME/.bareback --work-tree=$HOME'
#alias bb='/usr/bin/git --git-dir=$HOME/.bareback --work-tree=$HOME'
#alias bblg='/usr/bin/lazygit --git-dir=$HOME/.bareback --work-tree=$HOME'
# Moved to alias

################################
# Edit line in vim with ctrl+e #
################################
autoload edit-command-line
zle -N edit-command-line
bindkey '^e' edit-command-line

#################################
# Add vim-keys to control menue #
#################################
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char

############################################
# Change cursor shape depending on vi mode #
############################################
function zle-keymap-select {
    if [[ ${KEYMAP} == vicmd ]] ||
        [[ $1 = 'block' ]];
        then echo -ne '\e[1 q'
    elif [[ ${KEYMAP} == main ]] ||
        [[ ${KEYMAP} == viins ]] ||
        [[ ${KEYMAP} = '' ]] ||
        [[ $1 = 'beam' ]]
        then echo -ne '\e[5 q'
    fi
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q'


##########################
# Neovim config switcher #
##########################
alias nvim-astro="NVIM_APPNAME=AstroNvim nvim"

function nvims() {
    items=("default" "AstroNvim")
    config=$(printf "%s\n" "${items[@]}" | fzf --prompt="  Neovim Config >" --height=~50% --layout=reverse --border --exit-0)
    if [[ -z $config ]]; then
        echo "Nothing selected"
        return 0
    elif [[ $config == "default" ]]; then
        config=""
    fi
    NVIM_APPNAME=$config nvim $@
}

bindkey -s ^a "nvims\n"

# Set starship as prompt
eval "$(starship init zsh)"

###########
# Plugins #
###########
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/doc/pkgfile/command-not-found.zsh

# pnpm
export PNPM_HOME="/home/vm/.local/share/pnpm"
export PATH="$PNPM_HOME:$PATH"
# pnpm end
