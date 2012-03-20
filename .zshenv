export LANG=ja_JP.UTF-8

typeset -U path
path=(/bin(N-/)
      $HOME/bin(N-/)
      /usr/local/bin(N-/)
      /usr/bin(N-/))

typeset -xT SUDO_PATH sudo_path
typeset -U sudo_path
sudo_path=({,/usr/local,/usr}/sbin(N-/))

typeset -U manpath
manpath=(/usr/local/share/man(N-/)
         /usr/share/man(N-/))

if type lv > /dev/null 2>&1; then
    export PAGER="lv"
else
    export PAGER="less"
fi

if [ "$PAGER" = "lv" ]; then
    export LV="-c -l"
else
    alias lv="$PAGER"
fi

if type ggrep > /dev/null 2>&1; then
    alias grep=ggrep
fi

export GREP_OPTIONS
GREP_OPTIONS="--binary-files=without-match"
GREP_OPTIONS="--directories=recurse $GREP_OPTIONS"
GREP_OPTIONS="--exclude=\*.tmp $GREP_OPTIONS"
if grep --help | grep -q -- --exclude-dir; then
    GREP_OPTIONS="--exclude-dir=.svn $GREP_OPTIONS"
    GREP_OPTIONS="--exclude-dir=.git $GREP_OPTIONS"
fi
if grep --help | grep -q -- --color; then
    GREP_OPTIONS="--color=auto $GREP_OPTIONS"
fi

export EDITOR=vim
if ! type vim > /dev/null 2>&1; then
    alias vim=vi
fi
