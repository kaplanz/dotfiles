#!/bin/sh
# File:        libdots.sh
# Author:      Zakhary Kaplan <https://zakhary.dev>
# Created:     23 Oct 2023
# SPDX-License-Identifier: MIT
# Vim:         set ft=sh:

#
# shellcheck shell=dash
#

# ----------------
# -   Aliases    -
# ----------------

# @alias log -<e|w|i|d|t>
alias error="log -e"
alias warn="log -w"
alias info="log -i"
alias debug="log -d"
alias trace="log -t"


# ----------------
# - Definitions  -
# ----------------

# @env LOG_FILE  Logging output file.
export LOG_FILE="${LOG_FILE}"
# @env LOG_LEVEL Filter for logging. [default: "info"]
export LOG_LEVEL="${LOG_LEVEL:-info}"
# @env NO_COLOR  Disable ANSI color escape codes.
export NO_COLOR="${NO_COLOR}"


# ----------------
# -  Functions   -
# ----------------

#
# @desc  Display formatted log messages.
# @env   LOG_LEVEL "warn"
#
log() {
    # Parse opts
    local level=info
    local noeol=
    while getopts ":l:ewidtn" opt; do
        case ${opt} in
            l)
                level="${OPTARG}"
                ;;
            e)
                level=error
                ;;
            w)
                level=warn
                ;;
            i)
                level=info
                ;;
            d)
                level=debug
                ;;
            t)
                level=trace
                ;;
            n)
                noeol=1
                ;;
            \?)
                return
                ;;
        esac
    done
    shift $((OPTIND - 1))
    OPTIND=1 # XXX: cannot uneset in `dash`

    # Extract from env
    local filter=${LOG_LEVEL:-warn}

    # Define levels
    # shellcheck disable=2034
    local none=0
    # shellcheck disable=2034
    local error=1
    # shellcheck disable=2034
    local warn=2
    # shellcheck disable=2034
    local info=3
    # shellcheck disable=2034
    local debug=4
    # shellcheck disable=2034
    local trace=5
    # Indirect variable expansion
    local filterno levelno
    filterno="$(eval "echo \${${filter}}")"
    levelno="$(eval "echo \${${level}}")"
    # Check for misconfiguration
    if [ -z "${filterno}" ] || [ -z "${levelno}" ]; then
        return
    fi
    # Filter-out disabled messages
    if [ "${filterno}" -lt "${levelno}" ]; then
        return
    fi

    # Prepare ANSI color sequences
    local clear=
    local color=
    local style=
    if [ -z "${NO_COLOR}" ]; then
        clear=$(printf "\033[0m")
        case ${level} in
            error )
                color=$(printf "\033[31m")
                style=$(printf "\033[1m")
                ;;
            warn  )
                color=$(printf "\033[33m")
                ;;
            info  )
                color=$(printf "\033[32m")
                ;;
            debug )
                color=$(printf "\033[34m")
                ;;
            trace )
                color=$(printf "\033[35m")
                ;;
        esac
    fi
    # Check if EOL is needed
    local eol=
    if [ -z "${noeol}" ]; then
        eol="\n"
    fi

    # Display message
    printf "[%s] %s${eol}" "${color}${style}${level}${clear}" "${style}$*${clear}"
}

#
# @desc Exit early with a failure code and a message.
#
bail() {
    local code="$1"
    shift
    error "$*"
    exit "${code:-1}"
}

#
# @desc Exit early with a failure code.
#
cancel() {
    bail 1 "Operation cancelled."
}

#
# @desc Run and monitor a command, logging output and exiting on failure.
#
monitor() {
    # Execute monitored command, log output
    $@ >> "${LOG_FILE}" 2>&1
    # Extract status code
    local code=$?
    # Check for success
    if [ ${code} -eq 0 ]; then
        return  # no-op on success
    fi
    # Indicate failure
    error "Failed with exit code: ${code}"
    # Display last few lines of output
    tail -10 "${LOG_FILE}" | while read line; do warn "${line}"; done
    # Abort failed execution
    cancel
}
