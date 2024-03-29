#!/usr/bin/env bash
# File:        job.sh
# Author:      Zakhary Kaplan <https://zakhary.dev>
# Created:     13 Jun 2020
# SPDX-License-Identifier: MIT

# Ensure valid bash version
if [ ! "${BASH_VERSINFO[0]}" -ge 4 ]; then
    echo "error: unsupported bash version (${BASH_VERSINFO[0]} > 4.0.0)" 1>&2
    exit 1
fi

# Commands
LN='ln -s'
MKDIR='mkdir -p'

# Directories
CRON="$(dirname "$0")"

# Files
LOCK="$CRON/locks/$1.lock"
LOG="$CRON/logs/$(date +%Y/%m/%d)/$1.$(date +%s).log"
JOB="$CRON/bin/$1"

# Run job
main() {
    # Ensure job exists and is an executable file
    if [ ! -f "$JOB" ] || [ ! -x "$JOB" ]; then
        echo "error: invalid job: $JOB" 1>&2
        exit 127
    fi

    # Check if job is locked
    if [ -f "$LOCK" ] || [ -L "$LOCK" ]; then
        echo "error: cannot acquire lock: $LOCK" 1>&2
        exit 127
    else
        # Lock job
        $MKDIR "$(dirname "$LOCK")"
        $LN "$LOG" "$LOCK" # lock points to log
    fi

    # Create directory for log
    $MKDIR "$(dirname "$LOG")"

    # Call job to run
    "$JOB" |& tee "$LOG"

    # Save exit status from job
    EXIT="${PIPESTATUS[0]}"

    # Remove log file (and directory) if empty
    [ ! -s "$LOG" ] && rm "$LOG"
    rmdir "$(dirname "$LOG")" &> /dev/null

    # Release lock for job
    rm "$LOCK"

    return "$EXIT"
}

main "$@"
