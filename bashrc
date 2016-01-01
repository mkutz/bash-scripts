# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        # We have color support; assume it's compliant with Ecma-48
        # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
        # a case would tend to support setf rather than setaf.)
        color_prompt=yes
    else
        color_prompt=
    fi
fi


# Path extensions
export PATH+=:~/Scripts
export PATH+=:~/Programme/maven/bin
export PATH+=:~/Programme/idea/bin

export CDPATH=.:~:~/Dokumente:~/Projekte:/media

# Maven

# Prompt
if [ "$color_prompt" = yes ]; then

    export BOLD='\e[1m'
    export DIM='\e[2m'
    export UNDERLINE='\e[4m'
    export INVERTED='\e[7m'
    export HIDDEN='\e[8m'

    export RESET='\e[0m'

    export WHITE='\e[1;37m'
    export BLACK='\e[0;30m'
    export BLUE='\e[0;34m'
    export LIGHT_BLUE='\e[1;34m'
    export GREEN='\e[0;32m'
    export LIGHT_GREEN='\e[1;32m'
    export CYAN='\e[0;36m'
    export LIGHT_CYAN='\e[1;36m'
    export RED='\e[0;31m'
    export LIGHT_RED='\e[1;31m'
    export PURPLE='\e[0;35m'
    export LIGHT_PURPLE='\e[1;35m'
    export BROWN='\e[0;33m'
    export YELLOW='\e[1;33m'
    export GRAY='\e[0;30m'
    export LIGHT_GRAY='\e[0;37m'

    function exitcode_marker {
        local exit_code="$1"
        local last_command="$2"
        if [ ! -z "${last_command}" ]; then
            if [ "${exit_code}" == 0 ]; then
                echo -ne "${LIGHT_GREEN}${BOLD}✔ ${exit_code}${RESET}"
            else
                echo -ne "${LIGHT_RED}${BOLD}✘ ${exit_code}${RESET}"
            fi
            return 0
        fi
        return 1
    }

    function print_command_brace {
        local current_command="$1"
        local length=${#current_command}
        local half_length=$((${length}/2))
        local rest_length=$((${length}-${half_length}))
        
        if [ ${length} -gt 3 ]; then
            echo -ne "  ╰$(printf "%0.s─" $(seq 1 $(($half_length-1))))┬$(printf "%0.s─" $(seq 1 $rest_length))╯\n"
            echo -ne "╭──$(printf "%0.s─" $(seq 1 $(($half_length-1))))┴$(printf "%0.s─" $(seq 1 $(($COLUMNS-(4+$half_length)))))╮\n"
        elif [ ${length} -eq 3 ]; then
            echo -ne "  ╰─┬─╯\n"
            echo -ne "╭───┴$(printf "%0.s─" $(seq 1 $(($COLUMNS-6))))╮\n"
        elif [ ${length} -eq 2 ]; then
            echo -ne "  ╰┬─╯\n"
            echo -ne "╭──┴$(printf "%0.s─" $(seq 1 $(($COLUMNS-5))))╮\n"
        else
            echo -ne "  ╰┬╯\n"
            echo -ne "╭──┴$(printf "%0.s─" $(seq 1 $(($COLUMNS-5))))╮\n"
        fi
    }

    function chroot_status {
        echo -ne "${debian_chroot:+($debian_chroot)}"
        echo -ne "${LIGHT_GREEN}\u@\h "
        echo -ne "${LIGHT_BLUE}\w${RESET}"
    }

    function git_status {
        if [ -d .git ]; then
            local branch
            if branch=$(git rev-parse --abbrev-ref HEAD 2> /dev/null); then
                if [[ "$branch" == "HEAD" ]]; then
                    branch='detached*'
                fi
                git_branch="git::$branch"
            else
                git_branch=""
            fi

            local status=$(git status --porcelain 2> /dev/null)
            if [[ "$status" != "" ]]; then
                git_dirty="*"
            else
                git_dirty=""
            fi

            local git_stashed_changes=$(git stash list | wc -l)

            #git fetch 2> /dev/null
            local git_commits_ahead=$(git rev-list @{u}.. --count)
            local git_commits_behind=$(git rev-list ..@{u} --count)

            echo -en "${BOLD}${LIGHT_PURPLE}"
            echo -en "${git_branch}${git_dirty} "
            if [ ${git_commits_ahead} -gt 0 ]; then
                echo -en "↗ ${git_commits_ahead} "
            fi
            if [ ${git_commits_behind} -gt 0 ]; then
                echo -en "↘ ${git_commits_behind} "
            fi
            if [ ${git_stashed_changes} -gt 0 ]; then
                echo -en "⇣ ${git_stashed_changes}"
            fi
            echo -en "${RESET}"
        fi
    }

    function propt_command {
        local exit_code="$?"

        PS1=""
        if [ ! -z "${last_command}" ]; then
            PS1+="\n" #PS1+="╰─┬$(printf "%0.s─" $(seq 1 $(($COLUMNS-4))))╯\n"
            PS1+="╭ $(exitcode_marker ${exit_code} ${last_command}) ─ \t\n"
            PS1+="│ $(chroot_status) $(git_status)"
        else
            PS1+="\n╭ $(chroot_status) $(git_status)"
        fi
        PS1+="\n╰─ "

        PS2=""
        PS2+="\e[s\e[1A├\e[u"
        PS2+="╰─ "
    }

    function save_last_command {
        export last_command="$1"
    }

    precmd_functions+=(propt_command)
    preexec_functions+=(save_last_command)
    #preexec_functions+=(print_command_brace)

else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

[[ -f ~/.bash-preexec.sh ]] && source ~/.bash-preexec.sh
