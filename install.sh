#!/bin/bash

# ==============================================================================
# Check the platform
# ==============================================================================
platform="$(uname)"
if [[ "$platform" != 'Darwin' ]]; then
  echo "These scripts are only compatible with OS X."
  read -p "Are you sure that you want to continue? [y/N] " shouldContinue
  if [[ "$shouldContinue" != "y" ]] && [[ "$shouldContinue" != "Y" ]]; then
    exit
  fi
fi

# ==============================================================================
# Get the default terminal app
# ==============================================================================
currentApp="$(osascript -e \
'tell application "System Events"
  item 1 of (get name of processes whose frontmost is true)
end tell'
)"

read -p "What is your default terminal app? [$currentApp] " terminalApp

if [[ ! $appName ]]; then
  terminalApp=$currentApp
fi


# ==============================================================================
# Ask for install location
# ==============================================================================
read -p "Where should the scripts be installed? [~/.mac_util/] " installDir

if [[ ! $installDir ]]; then
  installDir="~/.mac_util/"
fi

# ==============================================================================
# Compile sources
# ==============================================================================
echo "Compiling sources"
mkdir -p build

# Insert app name into the config file
sed '4i\
set _config to _config & {terminalApp:"'$terminalApp'"}
' src/config.applescript.default > src/config.applescript

for script in src/*.applescript; do
  outname=${script#src/}
  outname=build/${outname/.applescript/}.scpt
  echo $outname
  osacompile -o $outname $script
done

# ==============================================================================
# Compile sources
# ==============================================================================
echo "Copying files"
bash -c "cp -r build/ $installDir"

# ==============================================================================
# Setup aliases
# ==============================================================================

if [[ $(echo $SHELL | grep bash) ]]; then
    RC_FILE=$HOME/.bashrc
elif [[ $(echo $SHELL | grep zsh) ]]; then
    RC_FILE=$HOME/.zshrc
else
  echo "Unknown shell type!"
  echo "You'll have to set up aliases on your own."
fi

if [[ RC_FILE ]]; then
fi
