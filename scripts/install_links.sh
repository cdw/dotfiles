#!/usr/bin/env bash

## Install links to the configuration files in /usr/local/bin

# Provide a variable with the location of this script.
scriptPath="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"


# Directory links
lndot () {
  cd /usr/local/bin
  ln -s $scriptPath/$1 $1
}
lndot pwe
