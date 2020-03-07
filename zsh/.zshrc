# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/Users/michae.lmelody/.oh-my-zsh"
export TERM="xterm-256color"

# Environment Variables
source .env_vars

# Powerlevel9k

ZSH_THEME="powerlevel9k/powerlevel9k"
POWERLEVEL9K_MODE='nerdfont-complete'

plugins=(
 git
 jira
 virtualenv
)

zsh_docker_containers(){
    # containers=$(docker ps -q | wc -l)
    # echo -n '\uE7B0 $containers'
    local containers=$(docker ps -q | wc -l | awk '{$1=$1};1')
    local color='%F{blue}'
    if (( $containers > 0 )); then
      echo -n "%{$color%}\uE7B0 $containers%{%f%}" # \uf230 is 
    fi  
}

POWERLEVEL9K_CUSTOM_DOCKER_CONTAINERS="zsh_docker_containers"
POWERLEVEL9K_CUSTOM_DOCKER_CONTAINERS_BACKGROUND="P9KGT_TERMINAL_BACKGROUND"

POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(dir vcs newline custom_docker_containers virtualenv)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=()

# Prompt
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_PROMPT_ADD_NEWLINE=true
POWERLEVEL9K_SHORTEN_DIR_LENGTH=3

# Set 'dir' segment colors
# https://github.com/bhilburn/powerlevel9k/blob/next/segments/dir/README.md
POWERLEVEL9K_DIR_HOME_BACKGROUND="clear"
POWERLEVEL9K_DIR_HOME_SUBFOLDER_BACKGROUND="clear"
POWERLEVEL9K_DIR_ETC_BACKGROUND="clear"
POWERLEVEL9K_DIR_DEFAULT_BACKGROUND="clear"

POWERLEVEL9K_DIR_HOME_FOREGROUND="dodgerblue1"
POWERLEVEL9K_DIR_HOME_SUBFOLDER_FOREGROUND="dodgerblue1"
POWERLEVEL9K_DIR_ETC_FOREGROUND="dodgerblue1"
POWERLEVEL9K_DIR_DEFAULT_FOREGROUND="dodgerblue1"

# IP 
POWERLEVEL9K_PUBLIC_IP_BACKGROUND='P9KGT_TERMINAL_BACKGROUND'
POWERLEVEL9K_PUBLIC_IP_FOREGROUND='lightgreen'

# Virtualenv
POWERLEVEL9K_VIRTUALENV_BACKGROUND="clear"
POWERLEVEL9K_VIRTUALENV_FOREGROUND="green"

# VCS

POWERLEVEL9K_VCS_CLEAN_BACKGROUND='clear'
POWERLEVEL9K_VCS_CLEAN_FOREGROUND='green'
POWERLEVEL9K_VCS_MODIFIED_BACKGROUND='clear'
POWERLEVEL9K_VCS_MODIFIED_FOREGROUND='yellow'
POWERLEVEL9K_VCS_UNTRACKED_BACKGROUND='clear'
POWERLEVEL9K_VCS_UNTRACKED_FOREGROUND='green'

# 
POWERLEVEL9K_LEFT_SEGMENT_SEPARATOR=''
POWERLEVEL9K_LEFT_SUBSEGMENT_SEPARATOR=' '
POWERLEVEL9K_WHITESPACE_BETWEEN_LEFT_SEGMENTS=''

ENABLE_CORRECTION="true"

source $ZSH/oh-my-zsh.sh

# aliases

## zsh
alias zshrc='. ~/.zshrc'
alias zshconfig="mate ~/.zshrc"

## Git
alias gfl='git fetch && git pull'
alias gg='git gui &'

## Docker
alias stopcons='docker stop $(docker ps -aq)'
alias removecons='docker rm $(docker ps -a -q)'
alias killcons='stopcons && removecons'

## Directory
alias repos='cd ~/Repositories'
alias ls='ls -ltha'

alias show-all='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'
alias hide-all='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app'

## Open apps
alias ij='idea .'
alias subl="sublime ."
alias vc='code .'

## IP
alias ip='curl ifconfig.io'

## Python
alias activate='. venv/bin/activate'

## AWS
alias lamb='sam build && sam local invoke SpotifyPlayHistoryListener  --event events/event.json'

## Java

## Brew
alias services='brew services list'

# Functions
hist(){
  history | grep "$1"
}

mk(){
  mkdir "$1"
  cd "$1"
}

# Super top secret things I don't want the outside world to see!
source .secret_stuff

# NVM
export NVM_DIR=~/.nvm
source $(brew --prefix nvm)/nvm.sh

# Jenv
export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"