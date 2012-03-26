# prompt settings
autoload colors
colors
case ${UID} in
  0)
    PROMPT="%{${fg[cyan]}%}$(echo ${HOST%%.*} | tr '[a-z]' '[A-Z]') %B%{${fg[red]}%}%/#%{${reset_color}%}%b "
    PROMPT2="%B%{${fg[red]}%}%_#%{${reset_color}%}%b "
    SPROMPT="%B%{${fg[red]}%}%r is correct? [n,y,a,e]:%{${reset_color}%}%b "
    ;;
  *)
    PROMPT="%{${fg[red]}%}%/%%%{${reset_color}%} "
    PROMPT2="%{${fg[red]}%}%_%%%{${reset_color}%} "
    SPROMPT="%{${fg[red]}%}%r is correct? [n,y,a,e]:%{${reset_color}%} "
    [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] && PROMPT="%{${fg[cyan]}%}$(echo ${HOST%%.*} | tr '[a-z]' '[A-Z]') ${PROMPT}"
    ;;
esac

# emacs keybind
bindkey -e

# completion settings
autoload -Uz compinit
compinit
zstyle ':completion:*' completer _oldlist _complete _match _ignored
zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'r:|[._-]=* r:|=*'
zstyle ':completion:*' format '%B%d%b'
zstyle ':completion:*' group-name ''
zstyle ':completion:*:default' menu select=2
zstyle ':completion:sudo:*' environ PATH="$SUDO_PATH:$PATH"
zstyle ':completion:*' use-cache yes
zstyle ':completion:*' verbose yes
setopt no_beep
setopt magic_equal_subst
setopt auto_list
setopt auto_menu
setopt hist_expand
setopt numeric_glob_sort

# history settings
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt extended_history
setopt hist_ignore_dups
setopt hist_ignore_space
setopt inc_append_history
setopt share_history
setopt no_flow_control

# history search keybind
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^p" history-beginning-search-backward-end
bindkey "^n" history-beginning-search-forward-end

# color settings
zstyle ':completion:*:default' list-colors ''
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([%0-9]#)*=0=01;31'

# directory navigation settings
setopt auto_cd
setopt auto_pushd
setopt pushd_ignore_dups
cdpath=(~)
chpwd_functions=($chpwd_functions dirs)

# zsh editor
autoload zed

# aliases
if ls --help | grep -q -- --color; then
  alias ls="ls --color=auto"
fi
alias ll="ls -l"
alias la="ls -a"
alias aps="aptitude search"
alias emacs="emacsclient -c"

# for screen
case ${TERM} in
  screen*)
    preexec() {
      echo -ne "\ek#${1%% *}\e\\"
    }
    precmd() {
      echo -ne "\ek$(basename $(pwd))\e\\"
    }
esac

# google it now
function google() {
  local str opt
  if [ $# != 0 ]; then
    for i in $*; do
      str="$str+$i"
    done
    str=`echo $str | sed 's/^\+//'`
    opt='search?num=50&hl=ja&lr=lang_ja'
    opt="${opt}&q=${str}"
  fi
  w3m http://www.google.co.jp/$opt
}

# cd .. with ^
function cdup() {
  echo
  cd ..
  zle reset-prompt
}
zle -N cdup
bindkey "\^" cdup

# for emacs shell-mode
[[ $EMACS = t ]] && unsetopt zle
