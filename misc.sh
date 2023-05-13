#!/bin/bash

git config --global user.name RahifM
git config --global user.email rahifmanjatha372@gmail.com
git config --global core.editor vim
git config --global alias.b 'branch'
git config --global alias.c 'commit'
git config --global alias.cp 'cherry-pick'
git config --global alias.ck 'checkout'
git config --global alias.d 'diff'
git config --global alias.f 'fetch'
git config --global alias.l 'log --oneline'
git config --global alias.p 'push'
git config --global alias.r 'revert'
git config --global alias.rh 'reset --hard'
git config --global alias.rr 'revert --no-edit'
git config --global alias.s 'status'
git config --global alias.rmv 'remote -v'
git config --global alias.rma 'remote add'
git config --global alias.rmd 'remote remove'
git config --global alias.pl 'pull'
git config --global credential.helper store
git config --global --add --bool push.autoSetupRemote true

TPTH=/data/data/com.termux/files/usr/etc/bash.bashrc
if [ -f "$TPTH" ]; then
        echo Termux path found
        CHKR="$(grep 'alias*' $TPTH)"
        if [ "$CHKR" == "" ]; then
                echo Changes does not exist, Adding...
cat <<'EOF' >> $TPTH

# Custom aliases
if [ -f ~/.bash_aliases ]; then
   . ~/.bash_aliases
fi
EOF
                echo Added changes successfully
        else
                echo Changes already exist
        fi
else
        echo Termux path not found
fi

PTH=~/.bash_aliases
if [ -f "$PTH" ]; then
        echo bash_aliases already exist
else
        echo Adding aliases
        touch $PTH
cat <<'EOF' >> $PTH
# custom alias to make life ez
alias c='clear'
alias l='ls'
alias la='ls -a'
alias ll='ls -l'
EOF
fi
