#!/usr/bin/env bash

set -e

# If there is more than one argument then return the help
if [ $# -gt 1 ]; then
    echo "Usage: docker-entrypoint [COMMAND]"
    echo "  COMMAND: The command to run. If not specified, the default command is used."
    exit 1
fi

# If the first argument is serve then run the default command
if [ $# -eq 0 ] || [ "$1" = "serve" ]; then
    pipx run poetry run python3 bin/wait_for_db.py

    exec pipx run poetry run gunicorn --bind 0.0.0.0:6400 'todo:create_app()'
fi