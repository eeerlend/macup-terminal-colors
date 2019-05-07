# macup-terminal-colors

A [macup](https://github.com/eeerlend/macup) module that installs your terminal theme

## Installation
Run the following command to add it to your repo

```bash
npm install eeerlend/macup-terminal-colors --save
```

## Configuration
Add your own themes to be installed in the macup configuration file like this...

```bash
macup_terminal_themes+=(
  "iterm;material-design;https://raw.githubusercontent.com/MartinSeeler/iterm2-material-design/master/material-design-colors.itermcolors"
  "terminal;materialshell-ocean;https://raw.githubusercontent.com/carloscuesta/materialshell/master/shell-color-themes/macOS/terminal/materialshell-oceanic.terminal"
)
```

... following the `type;name;url` pattern
