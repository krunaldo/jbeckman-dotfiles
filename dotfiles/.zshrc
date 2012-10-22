# If inside emacs start bash since it actually works with emacs
if [ $INSIDE_EMACS ]; then
    exec bash
fi

function open {
  google-chrome $r
}


autoload colors terminfo

gnu=false
os="$(uname -s)"
os_prompt="$os"
if [ "$os" = "Linux" ]; then
    hostname="$(hostname -f)"
    gnu=true
    if [ -f /etc/debian_version ]; then
        dist="debian"
        os_prompt="Debian $(cat /etc/debian_version)"
    elif [ -f /etc/redhat-release ]; then
        dist="RHEL"
        os_prompt="$(cat /etc/redhat-release)"
    fi
else
    hostname="$(hostname)"
fi

if [ "$os" = "OpenBSD" ]; then
    release="$(uname -r)"
    arch="$(uname -m)"
    export PKG_PATH="http://ftp.sunet.se/pub/OpenBSD/$release/packages/$arch/"
    os_prompt="$os $release"
fi

if [[ "$terminfo[colors]" -ge 8 ]]; then
    colors
fi
for color in RED GREEN YELLOW BLUE MAGENTA CYAN WHITE; do
    eval PR_$color='%{$terminfo[bold]$fg[${(L)color}]%}'
    eval PR_LIGHT_$color='%{$fg[${(L)color}]%}'
    (( count = $count + 1 ))
done
PR_NO_COLOUR="%{$terminfo[sgr0]%}"


# Enable variable expansion in prompt
setopt prompt_subst 

# If this is an ssh-connection, then we should indicate it somehow
if [ $SSH_CLIENT ]; then
    remote_ps1_expansion="${RED}"
else
    remote_ps1_expansion="${PR_NO_COLOUR}"
fi

PROMPT='
${PR_WHITE}---(${PR_NO_COLOUR} ${PR_LIGHT_GREEN}${hostname}\
${PR_WHITE} | ${PR_NO_COLOUR}${PR_LIGHT_CYAN}%n${PR_WHITE}\
${PR_WHITE} | ${PR_NO_COLOUR}${PR_LIGHT_BLUE}${os_prompt}${PR_WHITE}\
%(?..${PR_WHITE} | $PR_LIGHT_RED%?)\
${PR_WHITE} )---${PR_NO_COLOUR}
${remote_ps1_expansion}%#${PR_NO_COLOUR} '
RPS1=$'%B|%b%(1j_%{\e[32m%}%j%{\e[39m%}|_)%{\e[33m%}%4~%{\e[39m%}'
PS2=$'%_> '
PS4=$'%i_?'


# Set some shell options
setopt                \
	RM_STAR_SILENT      \
	APPEND_HISTORY      \
	INC_APPEND_HISTORY  \
	EXTENDED_HISTORY    \
	HIST_IGNORE_DUPS    \
	HIST_FIND_NO_DUPS   \
	HIST_IGNORE_SPACE   \
	AUTO_NAME_DIRS      \
	CDABLEVARS          \
	EXTENDED_GLOB       \
	AUTO_LIST           \
	AUTO_MENU           \
	AUTO_CD

# Auto completion
autoload -U compinit
compinit -u

# Other functionality
zmodload zsh/net/tcp
autoload -U tcp_open

zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format '%BNo match:%b %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*:rm:*' ignore-line yes
zstyle ':completion:*:*:kill*:*:processes' list-colors "=(#b) #([0-9]#)*=36=31"
zstyle ':completion:*:*:kill*:*' menu yes select

# History settings
HISTFILE=~/.zsh_history
HISTSIZE=3000
SAVEHIST=3000

#  EMACS-like bindings
bindkey -e
# Makes the key bindings actually respect that / is a word boundary
export WORDCHARS=''


#  Handy functions for handling merb applications
function §m {
    [ $# -lt 1 ] && return 1
    if [ $# -eq 1]; then # Assuming that we are the in project
       p=$(hash -d -m '-*' | grep "$PWD" | cut -d = -f 1)
       a=$1
    else
        p=$1
        a=$2
    fi

    cd $p

    case $a in
        c) cd app/controllers/;;
        m) cd app/model/;;
        v) cd app/views/;;
    esac


}

# Named directories for projects
if test -d ~/src/ && [[ "$(ls -1 ~/src/ | wc -l)" != "0" ]]; then
  hash -d srcs=~/src
  for src in ~srcs/*; do
    test -f $src || hash -d -- "-$(basename $src)"="$src"
  done
  # Strange, seems to be some kind of scoping here causing src to be created
  # in the dir hash with the value of the last value of the for iterations src
  unset src
fi


# Env variables
export LC_CTYPE='en_US.UTF-8'
export LANG='en_US.UTF-8'
export BROWSER='firefox'
export EDITOR='vim'
export PATH='/usr/local/telenor/bin/:/usr/local/bin:/opt/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/X11R6/bin:/usr/local/sbin/:/usr/local/libexec:/opt/bin:/opt/sbin:/var/lib/gems/1.8/bin/'
export PAGER='less'
export PYTHONSTARTUP=~/.pythonrc


# MPD(music player daemon env)
export MPD_HOST="127.0.0.1" # Does not take dns
export MPD_PORT="6600"


# Idiotic to cache manpaths
unset MAIL MANPATH
# Disable ctrl-s (stops output from hapening, evil shit)
stty -ixany -ixon -ixoff

# Alias
alias j='job-'
alias ls='ls -p'
alias l='ls'
alias ll='ls -l'
alias la='ls -a'
alias lla='ls -la'
alias p="ps aux | $PAGER" 
alias wyrd="e=$TERM   && xterm-color && wyrd && export TERM=$e"
alias muttng="e=$TERM && export TERM=xterm-color && muttng && export TERM=$e"
alias mutt="mutt -m maildir"
alias emacs="if pgrep emacs; then emacsclient; else emacs -l ~/.emacs.el; fi"
alias screen="screen -e '^oO'"
alias ipsort='sort -n -t . -k 1,1 -k 2,2 -k 3,3 -k 4,4'

# gnu aliases
if $gnu; then 
  alias grep='grep --color=tty'
  alias fgrep='fgrep --color=tty'
  alias egrep='egrep --color=tty'
fi

umask 022

if [ "$TERM" = "xterm" -o "$TERM" = "xterm-color" -o "$TERM" = "rxvt-unicode" ]; then
        export TERM=xterm-color
        export COLORTERM=xterm-color
fi

if [ -x /usr/games/fortune ]; then
	/usr/games/fortune
fi

chpwd() {
	[[ -t 1 ]] || return
	case $TERM in
		*xterm*|*rxvt*) printf \\033]0\;\%s\\007 "$HOST: $PWD"
		;;
	esac
}

SDL_AUDIODRIVER=alsa
export SDL_AUDIODRIVER

# Something might have changed our cwd, best to be on the safe side
cd ~
