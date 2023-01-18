function __prompt() {
    local -r use_color=$1
    local -r show_host=${2:-no}

    local -r C_NONE='\[\e[00m\]'
    local -r C_RED='\[\e[31m\]'
    local -r C_GREEN='\[\e[32m\]'
    local -r C_YELLOW='\[\e[33m\]'
    local -r C_CYAN='\[\e[36m\]'
    local -r C_WHITE='\[\e[37m\]'
    local -r C_BOLD_RED='\[\e[01;31m\]'
    local -r C_BOLD_GREEN='\[\e[01;32m\]'
    local -r C_BOLD_YELLOW='\[\e[01;33m\]'
    local -r C_BOLD_PURPLE='\[\e[01;35m\]'
    local -r C_BOLD_CYAN='\[\e[01;36m\]'

    if [ "$UID" = 0 ]; then
        local -r C_USER=$C_RED
        local -r C_HOST=$C_BOLD_CYAN
    else
        local -r C_USER=$C_CYAN
        local -r C_HOST=$C_BOLD_GREEN
    fi

    local git_prompt=''
    if git rev-parse --git-dir >/dev/null 2>&1; then

        local git_untracked_files=''
        if [ -n "$(git ls-files --others --exclude-standard)" ]; then
            git_untracked_files='*'
        fi

        if [ "$use_color" = yes ]; then
            local git_color=''
            if ! git diff --quiet; then
                git_color=${C_RED}
            elif ! git diff --cached --quiet; then
                git_color=${C_YELLOW}
            else
                git_color=${C_GREEN}
            fi

            git_prompt="[${git_color}\$(__git_ps1 \"%s\")${C_NONE}${git_untracked_files}]"
        else
            git_prompt="[\$(__git_ps1 \"%s\")${git_untracked_files}]"
        fi

    fi

    local host=''
    if [ "$show_host" = yes ]; then
        if [ "$use_color" = yes ]; then
            host="${C_YELLOW}@${C_BOLD_RED}<${C_HOST}\h${C_BOLD_RED}>${C_NONE}"
        else
            host='@!\h!'
        fi
    fi

    if [ "$use_color" = yes ]; then
        PS1="╭─${C_WHITE}\t${C_NONE} \${debian_chroot:+(\$debian_chroot)}${C_USER}\u${C_NONE}${host}: ${C_BOLD_YELLOW}\w${C_NONE}${git_prompt}\n╰─${C_BOLD_PURPLE}\$${C_NONE} "
    else
        PS1="╭─\t \${debian_chroot:+(\$debian_chroot)}\u${host}: \w${git_prompt}\n╰─\$ "
    fi
}
