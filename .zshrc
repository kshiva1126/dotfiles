# Ctrl+Dでログアウトしてしまうことを防ぐ
setopt IGNOREEOF

# 日本語を使用
export LANG=ja_JP.UTF-8

# パスを追加したい場合
export PATH="$HOME/bin:$PATH"

# emacsキーバインド
bindkey -e

# ヒストリーを共有する
setopt share_history

# ヒストリーに重複を表示しない
setopt histignorealldups

export HISTFILE=~/.zsh_history
export HISTSIZE=10000
export SAVEHIST=10000

# cdコマンドを省略して、ディレクトリ名のみの入力で移動
setopt auto_cd

# 自動でpushdを実行
setopt auto_pushd

# pushdから重複を削除
setopt pushd_ignore_dups

# コマンドミスを修正
setopt correct


# グローバルエイリアス
alias -g L='| less'
alias -g H='| head'
alias -g G='| grep'
alias -g GI='| grep -ri'


# エイリアス
alias lst='ls -ltr --color=auto'
alias l='ls -ltr --color=auto'
alias la='ls -la --color=auto'
alias ll='ls -l --color=auto'
alias so='source'
alias vim='nvim'
alias vz='nvim ~/.zshrc'
alias c='cdr'
# historyに日付を表示
alias h='fc -lt '%F %T' 1'
alias cp='cp -i'
alias rm='rm -i'
alias mkdir='mkdir -p'
alias ..='c ../'
alias back='pushd'
alias diff='diff -U1'

# backspace,deleteキーを使えるように
stty erase '^?'
bindkey "^[[3~" delete-char

# どこからでも参照できるディレクトリパス
cdpath=(~)

# 区切り文字の設定
autoload -Uz select-word-style
select-word-style default
zstyle ':zle:*' word-chars "_-./;@"
zstyle ':zle:*' word-style unspecified

# Ctrl+sのロック, Ctrl+qのロック解除を無効にする
setopt no_flow_control

# 補完後、メニュー選択モードになり左右キーで移動が出来る
zstyle ':completion:*:default' menu select=2

# 補完で大文字にもマッチ
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# Ctrl+rでヒストリーのインクリメンタルサーチ、Ctrl+sで逆順
bindkey '^r' history-incremental-pattern-search-backward
bindkey '^s' history-incremental-pattern-search-forward

# コマンドを途中まで入力後、historyから絞り込み
# 例 ls まで打ってCtrl+pでlsコマンドをさかのぼる、Ctrl+bで逆順
autoload -Uz history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^p" history-beginning-search-backward-end
bindkey "^b" history-beginning-search-forward-end

# cdrコマンドを有効 ログアウトしても有効なディレクトリ履歴
# cdr タブでリストを表示
autoload -Uz add-zsh-hook
autoload -Uz chpwd_recent_dirs cdr
add-zsh-hook chpwd chpwd_recent_dirs
# cdrコマンドで履歴にないディレクトリにも移動可能に
zstyle ":chpwd:*" recent-dirs-default true

# 複数ファイルのmv 例　zmv *.txt *.txt.bk
autoload -Uz zmv
alias zmv='noglob zmv -W'

# mkdirとcdを同時実行
function mkcd() {
  if [[ -d $1 ]]; then
    echo "$1 already exists!"
    cd $1
  else
    mkdir -p $1 && cd $1
  fi
}

export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# neovim
export PATH="$PATH:/opt/nvim/"

# cursor
#export PATH="$HOME/.local/bin:$PATH"
function cursor() {
  (nohup cursor "$@" > /dev/null 2>&1 &)
}
alias cur='cursor'

# Go
export PATH=$PATH:$HOME/go/bin

# ghq
cd_git_repo() {
  local selected="$(ghq list | fzf)"

  if [[ -n "$selected" ]]; then
    cd "$(ghq root)/$selected"
  fi
}
# ctrl + gでローカルのGitリポジトリをあいまい検索できるように
bindkey -s '^g' 'cd_git_repo\n'

# git switchあいまい検索
switch_git_branch() {
  local branches branch
  branches=$(git branch -a | sed 's/^\*//g' | sed 's/remotes\/origin\///g' | sort | uniq) && \
  branch=$(echo "$branches" | fzf --height 40% --reverse) && \
  git switch $(echo $branch | sed 's/.* //')
}
alias gs='switch_git_branch'

# historyあいまい検索
history_search() {
  local cmd
  cmd=$(history 1 | fzf | awk '{print substr($0, index($0,$2))}')
  [ -n "$cmd" ] && eval "$cmd"
}
bindkey -s '^r' 'history_search\n'

# starship
eval "$(starship init zsh)"

# Rust
# source $HOME/.cargo/env
export PATH=$PATH:/home/kshiva/.cargo/bin

# Gemini CLI
export GOOGLE_CLOUD_PROJECT="central-mission-464403-r9"

if type mise &>/dev/null; then
  eval "$(mise activate zsh)"
  eval "$(mise activate --shims)"
fi

autoload -U compinit
compinit
