# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
#ZSH_THEME="robbyrussell"
#ZSH_THEME="wezm"
#ZSH_THEME="tjkirch"
#ZSH_THEME="steeef"
#ZSH_THEME="xiong-chiamiov-plus"
ZSH_THEME="juanghurtado"

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
plugins=(ant brew bundler compleat gem git github heroku history-substring-search node npm osx rails rails3 rake ruby rbenv svn vi-mode debian perl vagrant cap ssh-agent mvn sublime)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...

autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end


alias ls='ls -G -CF'
alias ll='ls -ltrh'
alias la='ls -A'
alias l='ls -CF'
alias mv='mv -i'
alias cp='cp -i'
alias grep='grep --color'
export GREP_OPTIONS=$GREP_OPTIONS' --binary-files=without-match'
alias lv='lv -c'
alias less=lv
alias findgrep='find . -name "*.*" | grep -v .svn | grep -v "/\." | xargs grep'
alias drails='rails --database=postgresql'
alias svngrep='svn list -R | xargs grep'
alias ub='ssh ubuntu'
#alias cdgem='cd $GEM_HOME'
alias cdgem='cd `gem env gemdir`'
alias memcachedstat='echo -e "stats\r\nquit\r\n" | nc localhost 11211'
alias rm_trailing_ws_rb="find . -name '*.rb' -exec sed -i '' 's/[ ]*$//' {} \;"
alias v8="rlwrap v8"
alias rhino="rlwrap rhino"

[[ -r $HOME/.alias ]] && source $HOME/.alias

#[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"  # This loads RVM into a shell session.

# set running process name for screen
# preexec () {
#   [ ${STY} ] && echo -ne "\ek${1%% *}\e\\"
# }

function neobundle-update () {
  vim -c "execute \"NeoBundleInstall!\" | q | q"
}

if ! [ "$TMUX" = "" ]; then
  cat /proc/version 2>/dev/null | grep -qi debian && IS_DEBIAN=1
  cat /proc/version 2>/dev/null | grep -qi ubuntu && IS_UBUNTU=1
  uname -a | grep -qi darwin && IS_MAC=1
  if ! [ -z $IS_DEBIAN ]; then
      tmux set-option status-bg cyan | cat > /dev/null
  elif ! [ -z $IS_UBUNTU ]; then
      tmux set-option status-bg yellow | cat > /dev/null
  elif ! [ -z $IS_MAC ]; then
      tmux set-option status-bg blue | cat > /dev/null
  else
      tmux set-option status-bg $(perl -MList::Util=sum -e'print+(red,green,blue,yellow,cyan,magenta,white)[sum(unpack"C*",shift)%7]' $(hostname)) | cat > /dev/null
  fi
fi

export JAVA_OPTS='-Dfile.encoding=UTF-8'
#export JAVA_OPTS="-Dfile.encoding=UTF-8 -Dline.separator=$'\n'"

export NODE_PATH=/usr/local/lib/node_modules

