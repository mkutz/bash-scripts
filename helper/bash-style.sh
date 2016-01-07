#!/usr/bin/env bash

#
# collection of valiables and functions to style up bash scripts
#

set -o errexit
set -o pipefail
set -o nounset

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

function to_super_script {
    local input=$1
    local output=""
    for (( i=0; i<${#input}; i++ )); do
        local char="${input:$i:1}"
        case "${char}" in
            0) output+="⁰" ;;
            1) output+="¹" ;;
            2) output+="²" ;;
            3) output+="³" ;;
            4) output+="⁴" ;;
            5) output+="⁵" ;;
            6) output+="⁶" ;;
            7) output+="⁷" ;;
            8) output+="⁸" ;;
            9) output+="⁹" ;;
            *) output+=${char}
        esac
    done
    echo "${output}"
}

function to_sub_script {
    local input=$1
    local output=""
    for (( i=0; i<${#input}; i++ )); do
        local char="${input:$i:1}"
        case "${char}" in
            0) output+="₀" ;;
            1) output+="₁" ;;
            2) output+="₂" ;;
            3) output+="₃" ;;
            4) output+="₄" ;;
            5) output+="₅" ;;
            6) output+="₆" ;;
            7) output+="₇" ;;
            8) output+="₈" ;;
            9) output+="₉" ;;
            *) output+=${char}
        esac
    done
    echo "${output}"
}
