#!/bin/bash

function install_iterm_theme {
  local tmp_file=$2
  local name=$1

  report_from_package " Installing $name theme for iTerm2"

  echo " iTerm will now be opened, asking to import color scheme. Close the "
  echo " iTerm instance when you have imported the color scheme, and the script "
  echo " will continue"

  sleep 1
  open -W -n "$tmp_file"
}

function install_terminal_theme {
  local tmp_file=$2
  local name=$1
  local content

  report_from_package " Installing $name theme for Terminal"
  
  # We only want to use the part inside the <dict></dict> of the xml file
  content=$(awk '/<dict>/,/<\/dict>/' "$tmp_file")

  plutil -replace Window\ Settings."$name" -xml "$content" ~/Library/Preferences/com.apple.Terminal.plist
  defaults write com.apple.Terminal "Default Window Settings" -string "$name"
  defaults write com.apple.Terminal "Startup Window Settings" -string "$name"
}

# todo: check if array is declared up front!
# shellcheck disable=SC2154
for ((i=0; i<${#macup_terminal_colors[@]}; ++i)); do
  type="$(echo "${macup_terminal_colors[i]}" | cut -d';' -f1)"
  name="$(echo "${macup_terminal_colors[i]}" | cut -d';' -f2)"
  url="$(echo "${macup_terminal_colors[i]}" | cut -d';' -f3)"

  if [ ! -d "$PWD/.tmp" ]; then 
    mkdir "$PWD/.tmp/" 
  fi

  tmp_file="$PWD/.tmp/$(basename "$url")"
  
  curl -fsSL "$url" > "$tmp_file"
  
  if [ "$type" == 'iterm' ]; then
    install_iterm_theme "$name" "$tmp_file"
  elif [ "$type" == 'terminal' ]; then
    install_terminal_theme "$name" "$tmp_file"
  fi

done

rm -r "$PWD/.tmp"
