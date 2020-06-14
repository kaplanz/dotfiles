#!/bin/bash
#
#  job.sh
#  Cron script manager.
#
#  Created by Zakhary Kaplan on 2020-06-13.
#  Copyright © 2020 Zakhary Kaplan. All rights reserved.
#

# Directories
CRON="$(dirname $0)"

# Files
LOCK="$CRON/locks/$1.lock"
LOG="$CRON/logs/$1.$(date +%s).log"
SCRIPT="$CRON/scripts/$1"

# Run script
main() {
    # Ensure job script exists and is executable
    if [ ! -f "$SCRIPT" ] || [ ! -x "$SCRIPT" ]; then
        exit 127 # invalid job
    fi

    # Check if job is locked
    if [ -f "$LOCK" ]; then
        exit 1 # cannot acquire lock
    else
        touch "$LOCK"
    fi

    # Call job script to run
    "$SCRIPT" 2>&1 | tee "$LOG"

    # Save exit status from job script
    EXIT="${PIPESTATUS[0]}"

    # Remove empty log files
    [ ! -s "$LOG" ] && rm "$LOG"

    # Release lock for job
    rm "$LOCK"

    return "$EXIT"
}

main "$@"
