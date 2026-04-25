#!/bin/bash
set -e

if [ -z "$YAHOOJP_KEY" ] || [ -z "$YAHOOJP_SECRET" ]; then
  echo "ERROR: YAHOOJP_KEY and YAHOOJP_SECRET must be set."
  echo "Run: export YAHOOJP_KEY=xxx YAHOOJP_SECRET=yyy"
  exit 1
fi

rm -f /myapp/tmp/pids/server.pid
bundle check || bundle install
exec "$@"
