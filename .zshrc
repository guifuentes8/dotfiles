
# EXPORT VARIABLES

export PATH=$HOME/.cargo/bin/:$HOME/.local/bin:/usr/local/bin:$PATH
export ZSH="$HOME/.oh-my-zsh"
export YTUI_MUSIC_DIR=".config/ytui_music/"
#export LANG="pt_BR.UTF-8"

# THEMES

ZSH_THEME="dracula-pro"

# PLUGINS

plugins=(git)

# ZSH SOURCE

source $ZSH/oh-my-zsh.sh

# ALIAS

# -> Spotify
 alias spt="ncspot"
 alias sptl="sptlrx --current 'bold,#8be9fd' --before '#bd93f9,faint,italic,strikethrough' --after '#ff79c6,faint'"
 alias ytmusic="ytui_music-linux-amd64"

# -> TTY clock
 alias clock="tty-clock -c -s -D"

# -> Unimatrix
 alias matrix="unimatrix -s 96 -c green -l k"

# -> Himalaya mail
 alias mail="himalaya"
 alias mailsent="mail -m '[Gmail]/Sent Mail'"
 alias maild="mail attachments"
 alias mailw="mail write"

# -> Resolution screen
 alias xr1920="xrandr --output DP-4 --mode 1920x1080 --rate 120"
 alias xr3840="xrandr --output DP-4 --mode 3840x1080 --rate 120"
 alias xr2560="xrandr --output DP-4 --mode 2560x1440 --rate 120"
 alias xr5120="xrandr --output DP-4 --mode 5120x1440 --rate 120"

# -> Get window classname
 alias getname="xprop WM_CLASS"

# -> Scripts (convert files)
 alias batjpg="bash -c ~/.config/scripts/batPNGtoJPG.sh"
 alias batpng="bash -c ~/.config/scripts/batJPGtoPNG.sh"

# -> Startup ZSH
 pokemon-colorscripts --no-title -r 1-3

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

