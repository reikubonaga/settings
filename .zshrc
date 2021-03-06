export LSCOLORS=gxfxcxdxbxegedabagacad
export PATH=$PATH:~/pear/bin
alias ls='ls -G -v'
alias sl='ls'
alias pdw='pwd'
alias gti='git'
alias la="ls -a"
alias e="emacs"
alias lsg='ls | grep '
alias behat="~/bin/behat"
export PATH=/usr/local/bin:~/bin:/opt/local/bin:/opt/local/sbin/:$PATH
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

# http://shirusu-ni-tarazu.hatenablog.jp/entry/2013/01/18/034233
setopt nonomatch

#git alias
alias gl="git log"
alias gs='git status'
alias gb='git branch'
alias gc='git checkout'
alias git_branch_delete_old="git branch --merged master | grep -v 'master$' | xargs git branch -d"
alias gdc='git diff --cached'
alias gd='git diff'

#gitの保管
autoload -U compinit
compinit
zstyle ':completion:*:*:git:*' script ~/.zsh.d/git-completion.bash

autoload -U colors
colors

#保管をemacsキーバインドで移動
zstyle ':completion:*:default' menu select=1

# ベルを鳴らさない。
setopt no_beep

if [ -e .alias_list ] ; then
  source .alias_list
fi

if [ -e .zshrc_other ] ; then
  source .zshrc_other
fi

function o() {
  if [ "$1" -eq "" ] ; then
    return;
  fi
  open "http://$1.com"
}
function s() {
  if [ "$1" -eq "" ] ; then
    return;
  fi
  open "http://google.jp#hl=ja&gs_nf=1&cp=4&gs_id=11&xhr=t&q=$1"
}

function gm(){
  if [ -e ~/.confirm_before_git_commit ] ; then
    cat ~/.confirm_before_git_commit
    read NEXT
    git diff --cached
  fi
  print "y or n"
  read YES
  if [ "$YES" = "n" ] ; then
    return;
  fi
  git commit -m "$1"
}

alias a="./a.out"

alias datafart='curl --data-binary @- datafart.com'
