#setopt XTRACE
#setopt VERBOSE

# Path to your oh-my-zsh configuration.
ZSH=$HOME/.zsh/oh-my-zsh

# zsh-completions
fpath=($HOME/.zsh/zsh-completions/src $fpath)

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
#ZSH_THEME="steeef"
#ZSH_THEME="xiong-chiamiov-plus"
#ZSH_THEME="candy"
ZSH_THEME="avit"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want disable red dots displayed while waiting for completion
# DISABLE_COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(
  autojump
  brew
  bundler
  bower
  cap
  compleat
  emoji-clock
  gem
  git
  git-extras
  git-flow
  git-remote-branch
  github
  gradle
  history
  mvn
  node
  osx
  perl
  rails
  rake
  rbenv
  ruby
  ssh-agent
  svn
  vagrant
  vi-mode
  # The position *is* important.
)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...

# シンタックスハイライト
source $HOME/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# 履歴の検索(部分マッチ)
source $ZSH/plugins/history-substring-search/history-substring-search.zsh
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

# 履歴の検索(xxxから始まる)
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey '^P' history-beginning-search-backward-end
bindkey '^N' history-beginning-search-forward-end

# 履歴のインクリメンタル検索でワイルドカード利用可能
bindkey '^R' history-incremental-pattern-search-backward
bindkey '^S' history-incremental-pattern-search-forward

# 自動定義されてしまうhistoryのaliasを解除
unalias history
# 全履歴
function history-all { history -iE 1 }
alias ha='history-all'

# man zshoptions
#
# 先頭スペースだと履歴に残らない
#setopt HIST_IGNORE_SPACE
#
# typoの修正をOFF
set -o nocorrectall

# コマンドラインをエディタで編集
bindkey -M vicmd 'v' edit-command-line

alias ls='ls -G -CF'
alias ll='ls -ltrh'
alias la='ls -A'
alias l='ls -CF'
alias mv='mv -i'
alias cp='cp -i'
alias grep='grep --color'
export GREP_OPTIONS=$GREP_OPTIONS' --binary-files=without-match'
alias diff='colordiff'
alias lv='lv -c'
alias less=lv
alias tss='tig status'
alias tst='tig stash'
alias ub='ssh ubuntu'
#alias cdgem='cd $GEM_HOME'
alias cdgem='cd `gem env gemdir`'
alias memcachedstat='echo -e "stats\r\nquit\r\n" | nc localhost 11211'
alias rm_trailing_ws_rb="find . -name '*.rb' -exec sed -i '' 's/[ ]*$//' {} \;"
alias v8="rlwrap v8"
alias rhino="rlwrap rhino"
alias ag='ag --pager="less -R"'
alias grt='$(git rev-parse --show-toplevel)'
alias bower='noglob bower'

# Global aliases -- These do not have to be
# at the beginning of the command line.
alias -g .....='../../../..'
alias -g ....='../../..'
alias -g ...='../..'
alias -g A="| awk '{print \$2}'"
alias -g B='`git branch | peco | cut -b 3-`'
alias -g C='| wc -l'
alias -g CA="2>&1 | cat -A"
alias -g D="DISPLAY=:0.0"
alias -g DN=/dev/null
alias -g ED="export DISPLAY=:0.0"
alias -g EG='|& grep'
alias -g EH='|& head'
alias -g EL='|& less'
alias -g ELS='|& less -S'
alias -g ET='|& tail'
alias -g ETL='|& tail -20'
alias -g F=' | fmt -'
alias -g G='| grep'
alias -g H='| head'
alias -g HL='|& head -20'
alias -g L='| lv'
alias -g LL="2>&1 | less"
alias -g LS='| less -S'
alias -g M='| more'
alias -g MM='| most'
alias -g N='| cat -n'
alias -g NE="2> /dev/null"
alias -g NS='| sort -n'
alias -g NUL="> /dev/null 2>&1"
alias -g P='| peco'
alias -g PIPE='|'
alias -g R=' > /c/aaa/tee.txt '
alias -g RNS='| sort -nr'
alias -g S='| sort'
alias -g Sk="*~(*.bz2|*.gz|*.tgz|*.zip|*.z)"
alias -g T='| tail'
alias -g TL='| tail -20'
alias -g US='| sort -u'
alias -g V='| vim -'
alias -g VM=/var/log/messages
alias -g X0='| xargs -0'
alias -g X0G='| xargs -0 grep'
alias -g X='| xargs'
alias -g XG='| xargs grep'
alias -g W='| wc -l'

[[ -r $HOME/.alias.private ]] && source $HOME/.alias.private
[[ -r $HOME/.alias ]] && source $HOME/.alias

# set running process name for screen
# preexec () {
#   [ ${STY} ] && echo -ne "\ek${1%% *}\e\\"
# }

function neobundle-update () {
  vim -c "execute \"NeoBundleInstall!\" | q | q"
}

# http://d.hatena.ne.jp/tyru/20100828/run_tmux_or_screen_at_shell_startup
uname -a | grep -qi darwin && [[ -z "$TMUX" && -z "$WINDOW" && ! -z "$PS1" ]] && tmux

if [[ ! -z "$TMUX" ]]; then
  cat /proc/version 2>/dev/null | grep -qi debian && IS_DEBIAN=1
  cat /proc/version 2>/dev/null | grep -qi ubuntu && IS_UBUNTU=1
  uname -a | grep -qi darwin && IS_MAC=1
  if ! [ -z $IS_DEBIAN ]; then
      tmux set-option status-bg cyan | cat > /dev/null
  elif ! [ -z $IS_UBUNTU ]; then
      tmux set-option status-bg yellow | cat > /dev/null
  elif ! [ -z $IS_MAC ]; then
      #tmux set-option status-bg blue | cat > /dev/null
  else
      tmux set-option status-bg $(perl -MList::Util=sum -e'print+(red,green,blue,yellow,cyan,magenta,white)[sum(unpack"C*",shift)%7]' $(hostname)) | cat > /dev/null
  fi
fi

# [tmuxのlaunchctlエラー対策](http://qiita.com/naoty_k/items/2eb2b201782c038e38f6)
# -> パスワードが必要になる
#if [[ ! -z "$TMUX" ]]; then
#  alias pbcopy="ssh 127.0.0.1 pbcopy"
#  alias launchctl="ssh 127.0.0.1 launchctl"
#fi

export JAVA_TOOL_OPTIONS='-Dfile.encoding=UTF8'
export JAVA_OPTS='-Dfile.encoding=UTF-8'
export MAVEN_OPTS='-Djava.awt.headless=true'
export CATALINA_OPTS="-server -Xmx128M -Xms64M -Xss256k -Djava.awt.headless=true"
#export JAVA_OPTS="-Dfile.encoding=UTF-8 -Dline.separator=$'\n'"

export NODE_PATH=/usr/local/lib/node_modules:/usr/local/share/npm/lib/node_modules

# expanding global alias
# http://blog.patshead.com/2011/07/automatically-expanding-zsh-global-aliases-as-you-type.html
globalias() {
   if [[ $LBUFFER =~ ' [A-Z0-9]+$' ]]; then
     zle _expand_alias
   fi
   zle self-insert
}

zle -N globalias

bindkey " " globalias
bindkey "^ " magic-space           # control-space to bypass completion
bindkey -M isearch " " magic-space # normal space during searches


autoload -Uz compinit && compinit

which npm >/dev/null 2>&1 && eval "$(npm completion 2>/dev/null)"
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

function zman() {
    PAGER="less -g -s '+/^       "$1"'" man zshall
}

########################################
# peco
function peco-select-history() {
    local tac
    if which tac > /dev/null; then
        tac="tac"
    else
        tac="tail -r"
    fi
    BUFFER=$(\history -n 1 | eval $tac | peco --query "$LBUFFER")
    CURSOR=$#BUFFER
    zle clear-screen
}
zle -N peco-select-history
bindkey '^r' peco-select-history

# process kill
function peco-pkill() {
  for pid in `ps -ef | peco | awk '{print $2}'`
  do
    kill $pid
    echo "Killed ${pid}"
  done
}
alias pk="peco-pkill"

function peco-rebase-all() {
  git branch | peco | cut -b 3- | while read line; do echo -e "\e[0;31m--- $line ---\e[0m"; git rebase origin/master $line; done
}
########################################
# cdr
zstyle ':completion:*' menu select
zstyle ':completion:*:cd:*' ignore-parents parent pwd
zstyle ':completion:*:descriptions' format '%BCompleting%b %U%d%u'

typeset -ga chpwd_functions

autoload -Uz is-at-least
if is-at-least 4.3.11; then
  autoload -U chpwd_recent_dirs cdr
  chpwd_functions+=chpwd_recent_dirs
  zstyle ":chpwd:*" recent-dirs-max 500
  zstyle ":chpwd:*" recent-dirs-default true
  zstyle ":completion:*" recent-dirs-insert always
fi

### search a destination from cdr list
function peco-get-destination-from-cdr() {
    cdr -l | sed -e 's/^[[:digit:]]*[[:blank:]]*//' | peco --query "$LBUFFER"
}

### search a destination from cdr list and cd the destination
function peco-cdr() {
    local destination="$(peco-get-destination-from-cdr)"
    if [ -n "$destination" ]; then
        BUFFER="cd $destination"
        zle accept-line
    else
        zle reset-prompt
    fi
}
zle -N peco-cdr
bindkey '^j' peco-cdr
