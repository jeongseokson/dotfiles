case $- in
    *i*) ;;
      *) return;;
esac

HISTCONTROL=ignoreboth

shopt -s histappend

HISTSIZE=1000
HISTFILESIZE=2000

shopt -s checkwinsize

shopt -s globstar

[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias sl='ls'

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

source ~/.bash/completion/*

alias tmux="tmux -2"

NC="\033[0m"
GRAY="\033[0;37m"
WHITE="\033[1;37m"
BLACK="\033[0;30m"
DARKGRAY="\033[1;30m"
BLUE="\033[0;34m"
BBLUE="\033[1;34m"
GREEN="\033[0;32m"
BGREEN="\033[1;32m"
CYAN="\033[0;36m"
BCYAN="\033[1;36m"
RED="\033[0;31m"
BRED="\033[1;31m"
PURPLE="\033[0;35m"
BPURPLE="\033[1;35m"
BROWN="\033[0;33m"
YELLOW="\033[1;33m"
DEF="\033[0;39m"
BDEF="\033[1;39m"

git_branch () {
    local git_status="$(git status 2> /dev/null)"
    local on_branch="On branch ([^${IFS}]*)"
    local on_commit="HEAD detached at ([^${IFS}]*)"

    if [[ $git_status =~ $on_branch ]]; then
        local branch=${BASH_REMATCH[1]}
        echo "$branch"
    elif [[ $git_status =~ $on_commit ]]; then
        local commit=${BASH_REMATCH[1]}
        echo "$commit"
    fi
}

git_color () {
    local git_status="$(git status 2> /dev/null)"

    if [[ ! $git_status =~ "working tree clean" ]]; then
        echo -e $RED
    elif [[ $git_status =~ "Your branch is ahead of" ]]; then
        echo -e $BROWN
    elif [[ $git_status =~ "nothing to commit" ]]; then
        echo -e $GREEN
    else
        echo -e $PURPLE
    fi
}

PS1="┌─"
PS1+="[\`if [ \$? = 0 ]; then echo '\[$GREEN\]✔\[$NC\]'; else echo '\[$RED\]✘\[$NC\]'; fi\`]──"
PS1+="[\[$BDEF\]\u\[$NC\]\[$BDEF\]@\H\[$NC\]]──"
PS1+="[\[$BLUE\]\W\[$NC\]]"
PS1+="\`[ \j -gt 0 ] && echo '──[\[$BROWN\]\j jobs\[$NC\]]'\`"
PS1+="\`if git rev-parse --is-inside-work-tree > /dev/null 2>&1; then echo '──[\['\$(git_color)'\]'\$(git_branch)'\[$NC\]]'; fi\`"
PS1+="\`if tmux ls > /dev/null 2>&1; then echo '──[\[$CYAN\]'\$(tmux ls 2> /dev/null | wc -l) sessions'\[$NC\]]'; fi\`"
PS1+="\n└───▶ "
PS1="\[\033[G\]$PS1"

# pip
export PATH=$PATH:$HOME/.local/bin

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# editor setting
command -v vim > /dev/null 2>&1 && {
    export VISUAL=vim
    export EDITOR="$VISUAL"
    alias vi="vim"
}
command -v nvim >/dev/null 2>&1 && {
    alias vim="nvim"
}
