#!/usr/bin/env bash

set -e

log="log.txt"

# Use the first argument as the
# project directory.

dir=$1

if [ ! -d "$dir" ]; then
    echo "Project directory $dir does not exist"
    exit 1
fi

if [ ! -w "$log" ]; then
    echo "Log file $log is not writable"
    exit 1
fi

config="$dir/.log-ci-config"
last_build="$dir/.log-ci-last-build"

# Loads the project configuration.

if [ ! -r "$config" ]; then
    echo "Directory $dir contains no config file"
    exit 1
fi

source "$config"

# Checks configuration.

if [[ -z "$project" ]]; then
    echo "Project name is not set"
    exit 1
fi

if [[ -z "$build" ]]; then
    echo "Build command is not set"
    exit 1
fi

if [[ -z "$remote" ]]; then
    echo "Git remote name is not set"
    exit 1
fi

if [[ -z "$branch" ]]; then
    echo "Git branch name is not set"
    exit 1
fi

# Redirects all log into the log file.

exec >> $log 2>&1

# Updates the local copy.
# Prepends the project name to log messages.

git --git-dir="$dir/.git" \
    --work-tree="$dir" \
    pull \
    "$remote" \
    "$branch" 2>&1 \
    | sed "s/^/\[$project\]: /g"

# Finds the last commit date.

commit=`git --git-dir="$dir/.git" \
    --work-tree="$dir" \
    log -1 --format=%ci`

# Finds the last build date.

last="0000-00-00 00:00:00 +0000"
if [ -e "$last_build" ]; then
    last=`cat "$last_build"`
fi

# Builds the project when there are
# new changes.

if [[ "$commit" > "$last" ]]; then

    echo "[$project]: new changes"
    echo "[$project]: building"

    cd "$dir"

    if eval "$build" 2>&1 | sed "s/^/\[$project\]: /g"; then
        echo "[$project]: success"
        echo "$commit" > "$last_build"
    else
        echo "[$project]: fail"
    fi
else
    echo "[$project]: no new changes"
fi
