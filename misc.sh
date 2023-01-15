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

# Termux alias
PTH=/data/data/com.termux/files/usr/etc/bash.bashrc
if [ -f "$PTH" ]; then
        echo Termux path found
        CHKR="$(grep 'alias*' $PTH)"
        if [ "$CHKR" == "" ]; then
                echo Changes does not exist, Adding...
cat <<'EOF' >> $PTH

# custom alias to make life ez
alias c='clear'
alias l='ls'
alias la='ls -a'
alias ll='ls -l'

EOF
                echo Added changes successfully
        else
                echo Changes already exist
        fi
else
        echo Termux path not found
fi
# Termux alias
