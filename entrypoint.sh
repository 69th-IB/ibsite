#!/bin/sh

set -e

# default to 'server'
CMD="${@:-server}"

export RAILS_ENV=production

if [ -z "$RAILS_MASTER_KEY" ] && [ -f data/master.key ]; then
    export RAILS_MASTER_KEY="$(cat data/master.key)"
fi

if [ ! -f data/production.sqlite3 ]; then
    rails db:setup
fi

rails db:migrate

export RAILS_SERVE_STATIC_FILES=true
rails "$CMD"
