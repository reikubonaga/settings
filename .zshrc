export LSCOLORS=gxfxcxdxbxegedabagacad
export PATH=$PATH:~/pear/bin
alias ls='ls -G -v'
alias la="ls -a"
alias e="emacs"
alias lsg='ls | grep '
alias behat="~/bin/behat"
export PATH=~/bin:/opt/local/bin:/opt/local/sbin/:$PATH
export LANG=ja_JP.UTF-8

# コマンド履歴
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt hist_ignore_dups     # ignore duplication command history list
setopt share_history        # share command history data

# 移動したディレクトリを記録しておく。"cd -[Tab]"で移動履歴を一覧
setopt auto_pushd

# タブキー連打で補完候補を順に表示
setopt auto_menu

#git alias
alias gl="git log"
alias gs='git status'
alias gb='git branch'
alias gc='git checkout'

#gitの保管
autoload -U compinit
compinit
source ~/git-completion.bash

autoload -U colors
colors

#保管をemacsキーバインドで移動
zstyle ':completion:*:default' menu select=1

# ベルを鳴らさない。
setopt no_beep

if [ -e .alias_list ] ; then 
  source .alias_list
fi

function o() { 
  open "http://$1.com"
}
function s() { 
  open "http://google.jp#hl=ja&gs_nf=1&cp=4&gs_id=11&xhr=t&q=$1"
}
