#!/bin/bash

cmd="$1"
args="${@:2}"

function help {
  echo "usage: ./sc <command> [<args>]"
}

if [ -z "$cmd" ]; then
  help
  exit 0
fi

project_root="$(dirname $0)"
cd $project_root

if [ -x "./.git/info/sc-$cmd" ]; then
  "./.git/info/sc-$cmd" $args
elif [ -x "./scripts/commands/sc-$cmd" ]; then
  "./scripts/commands/sc-$cmd" $args
elif command -v "sc-$cmd" >/dev/null 2>&1; then
  "sc-$cmd" $args
else
  . "./scripts/lib/stdio"
  warn "'$cmd' is not a 'sc' command."
  help
fi
