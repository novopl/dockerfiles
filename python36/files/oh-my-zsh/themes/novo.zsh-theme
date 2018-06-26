unctions rbenv_prompt_info >& /dev/null || rbenv_prompt_info(){}

export VIRTUAL_ENV_DISABLE_PROMPT=1
setopt extended_glob

#----------------------------------------------------------------------------//
function virtualenv_info {
    # call with -l to get the length
    # out: " ENV_NAME "
    if [ $VIRTUAL_ENV ]; then
        local envname=$(basename $VIRTUAL_ENV)
        if [[ $# -eq 1 ]] && [[ "$1" == "-l" ]]; then
            local namesize=${#${envname}}
            echo $((namesize + 2))
        else
            echo " $envname "
        fi
    else
        [[ $# -gt 0 ]] && [[ "$1" == "-l" ]] && echo "0"
    fi
}
#----------------------------------------------------------------------------//
function theme_precmd {
    local TERMWIDTH
    (( TERMWIDTH = ${COLUMNS} - 1 ))


    ###
    # Truncate the path if it's too long.

    PR_FILLBAR=""
    PR_PWDLEN=""

    local promptsize=${#${(%):-:-()-(%n@%m%l)---()--}}
    local rubyprompt=`rvm_prompt_info || rbenv_prompt_info`
    local rubypromptsize=${#${rubyprompt}}
    local pwdsize=${#${(%):-%~}}
    local envprompt="$(virtualenv_info)"
    local envpromptsize=$(virtualenv_info -l)
    [[ $envpromptsize -gt 0 ]] && envpromptsize=$((envpromptsize))

    if [[ "$promptsize + $rubypromptsize + $pwdsize + $envpromptsize" -gt $TERMWIDTH ]]; then
      ((PR_PWDLEN=$TERMWIDTH - $promptsize))
    else
      PR_FILLBAR="\${(l.(($TERMWIDTH - ($promptsize + $rubypromptsize + $pwdsize + $envpromptsize)))..${PR_HBAR}.)}"
    fi

}
#----------------------------------------------------------------------------//
theme_preexec () {
    if [[ "$TERM" == "screen" ]]; then
	local CMD=${1[(wr)^(*=*|sudo|-*)]}
	echo -n "\ek$CMD\e\\"
    fi
}
#----------------------------------------------------------------------------//
setprompt () {
    ###
    # Need this so the prompt will work.

    setopt prompt_subst


    ###
    # See if we can use colors.

    autoload zsh/terminfo
    for color in RED GREEN YELLOW BLUE MAGENTA CYAN WHITE GREY; do
	eval PR_$color='%{$terminfo[bold]$fg[${(L)color}]%}'
	eval PR_LIGHT_$color='%{$fg[${(L)color}]%}'
	(( count = $count + 1 ))
    done
    PR_NO_COLOUR="%{$terminfo[sgr0]%}"

    ###
    # Modify Git prompt
    ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[green]%}"
    ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"

    ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[red]%}✗%{$reset_color%}"
    ZSH_THEME_GIT_PROMPT_CLEAN=" %{$fg[green]%}✔%{$reset_color%}"
    ZSH_THEME_GIT_PROMPT_ADDED="%{$fg[green]%}✚ "
    ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg[yellow]%}⚑ "
    ZSH_THEME_GIT_PROMPT_DELETED="%{$fg[red]%}✖ "
    ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg[blue]%}▴ "
    ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[cyan]%}§ "
    ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[grey]%}◒ "
    ###
    # See if we can use extended characters to look nicer.
    # UTF-8 Fixed

    if [[ $(locale charmap) == "UTF-8" ]]; then
	    PR_SET_CHARSET=""
	    PR_SHIFT_IN=""
	    PR_SHIFT_OUT=""
	    PR_HBAR="─"
        PR_ULCORNER="┌"
        PR_LLCORNER="└"
        PR_LRCORNER="┘"
        PR_URCORNER="┐"
    else
        typeset -A altchar
        set -A altchar ${(s..)terminfo[acsc]}
        # Some stuff to help us draw nice lines
        PR_SET_CHARSET="%{$terminfo[enacs]%}"
        PR_SHIFT_IN="%{$terminfo[smacs]%}"
        PR_SHIFT_OUT="%{$terminfo[rmacs]%}"
        PR_HBAR='$PR_SHIFT_IN${altchar[q]:--}$PR_SHIFT_OUT'
        PR_ULCORNER='$PR_SHIFT_IN${altchar[l]:--}$PR_SHIFT_OUT'
        PR_LLCORNER='$PR_SHIFT_IN${altchar[m]:--}$PR_SHIFT_OUT'
        PR_LRCORNER='$PR_SHIFT_IN${altchar[j]:--}$PR_SHIFT_OUT'
        PR_URCORNER='$PR_SHIFT_IN${altchar[k]:--}$PR_SHIFT_OUT'
     fi


    ###
    # Decide if we need to set titlebar text.

    case $TERM in
	xterm*)
	    PR_TITLEBAR=$'%{\e]0;%(!.-=*[ROOT]*=- | .)%n@%m:%~ | ${COLUMNS}x${LINES} | %y\a%}'
	    ;;
	screen)
	    PR_TITLEBAR=$'%{\e_screen \005 (\005t) | %(!.-=[ROOT]=- | .)%n@%m:%~ | ${COLUMNS}x${LINES} | %y\e\\%}'
	    ;;
	*)
	    PR_TITLEBAR=''
	    ;;
    esac


    ###
    # Decide whether to set a screen title
    if [[ "$TERM" == "screen" ]]; then
	    PR_STITLE=$'%{\ekzsh\e\\%}'
    else
	    PR_STITLE=''
    fi


    ###
    # Finally, the prompt.

    # All github and ruby statuses
#    PROMPT='$PR_SET_CHARSET$PR_STITLE${(e)PR_TITLEBAR}\
#$PR_CYAN$PR_ULCORNER$PR_HBAR\
#$PR_CYAN($PR_CYAN%(!.%SROOT%s.%n)$PR_GREY@$PR_GREEN%m$PR_GREY:$PR_GREEN%l$PR_CYAN)\
#$PR_MAGENTA$(virtualenv_info)\
#`rvm_prompt_info || rbenv_prompt_info`$PR_CYAN$PR_HBAR$PR_HBAR${(e)PR_FILLBAR}$PR_HBAR\
#( $PR_MAGENTA%$PR_PWDLEN<...<%~%<<$PR_CYAN )\
#$PR_CYAN$PR_HBAR$PR_URCORNER\
#
#$PR_CYAN$PR_LLCORNER \
#$PR_LIGHT_BLUE%{$reset_color%}`git_prompt_info``git_prompt_status`$PR_BLUE \
#$PR_CYAN\$$PR_NO_COLOUR '

    # github branch
    PROMPT='$PR_SET_CHARSET$PR_STITLE${(e)PR_TITLEBAR}\
$PR_CYAN$PR_ULCORNER$PR_HBAR\
$PR_CYAN($PR_CYAN%(!.%SROOT%s.%n)$PR_GREY@$PR_GREEN%m$PR_GREY:$PR_GREEN%l$PR_CYAN)\
$PR_MAGENTA$(virtualenv_info)\
$PR_CYAN$PR_HBAR$PR_HBAR${(e)PR_FILLBAR}$PR_HBAR\
( $PR_MAGENTA%$PR_PWDLEN<...<%~%<<$PR_CYAN )\
$PR_CYAN$PR_HBAR$PR_URCORNER\

$PR_CYAN$PR_LLCORNER \
$PR_LIGHT_BLUE%{$reset_color%}`git_prompt_info`$PR_BLUE \
$PR_CYAN\$$PR_NO_COLOUR '

    # no status
    PROMPT='$PR_SET_CHARSET$PR_STITLE${(e)PR_TITLEBAR}\
$PR_CYAN$PR_ULCORNER$PR_HBAR\
$PR_CYAN($PR_CYAN%(!.%SROOT%s.%n)$PR_GREY@$PR_GREEN%m$PR_GREY:$PR_GREEN%l$PR_CYAN)\
$PR_MAGENTA$(virtualenv_info)\
$PR_CYAN$PR_HBAR$PR_HBAR${(e)PR_FILLBAR}$PR_HBAR\
( $PR_MAGENTA%$PR_PWDLEN<...<%~%<<$PR_CYAN )\
$PR_CYAN$PR_HBAR$PR_URCORNER\

$PR_CYAN$PR_LLCORNER \
$PR_LIGHT_BLUE%{$reset_color%}$PR_BLUE \
$PR_CYAN\$$PR_NO_COLOUR '

    # display exitcode on the right when >0
    return_code="%(?..%{$fg[red]%}%? ↵ %{$reset_color%})"
    RPROMPT=' $return_code$PR_CYAN$PR_HBAR$PR_BLUE$PR_HBAR\
($PR_YELLOW%D{%a,%b%d} %D{%H:%M:%S}$PR_BLUE)$PR_HBAR$PR_CYAN$PR_LRCORNER$PR_NO_COLOUR'

    PS2='$PR_CYAN$PR_HBAR\
$PR_BLUE$PR_HBAR(\
$PR_LIGHT_GREEN%_$PR_BLUE)$PR_HBAR\
$PR_CYAN$PR_HBAR$PR_NO_COLOUR '
}


setprompt

autoload -U add-zsh-hook
add-zsh-hook precmd  theme_precmd
add-zsh-hook preexec theme_preexec
