#!/bin/bash

if [ -z "$NEEDLE_HOME" ]; then
  echo "NEEDLE_HOME variable is not defined"
  exit 1
fi

# edit plugin
#
# $1: plugin name or ls
viplugin() {
  if [ "$1" = "ls" ]; then
    echo "Available plugins:"
    for plugin in $NEEDLE_HOME/plugin/*.plugin.sh; do
      echo "${plugin//*plugin\/}"
    done
  else
    local plugin="$NEEDLE_HOME/plugin/$1.plugin.sh"
    [ -f "$plugin" ] && vim "$plugin" && source "$SHELLRC"
  fi
}

# load plugins
for plugin in $NEEDLE_HOME/plugin/*.plugin.sh; do
  [ -f "$plugin" ] && source "$plugin"
done

# load plugins in custom directory
if ls $NEEDLE_HOME/custom/ | grep -Eqs ".*\.plugin\.sh"; then
  unset plugin
  for plugin in $NEEDLE_HOME/custom/*.plugin.sh; do
    [ -f "$plugin" ] && source "$plugin"
  done
fi
