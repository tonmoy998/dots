# Enable colors and change prompt:
autoload -U colors && colors
export ZSHCFG=~/.config/zsh/zshcfg
export ZSH=~/.config/zsh/zshcfg/OMZ
PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "

# Fetch all plugins in dir
plugins=(`echo $(ls $ZSH/plugins | sed -z 's/\n/ /g')`)


# # Basic auto/tab complete:
# autoload -U compinit
# zstyle ':completion:*' menu select
# zmodload zsh/complist
# compinit
setopt extendedglob
_comp_options+=(globdots)		# Include hidden files.

#1st comment
# phylog() {
#     cat | curl -F 'f:1=<-' ix.io
# }

# Use lf to switch directories and bind it to ctrl-r
lfcd () {
    tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp"
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}

function cppwd() {
	echo -n "$PWD" | xclip -selection clipboard
}
zle -N cppwd

bindkey -s '^r' 'lfcd\n'
# below opens a new terminal in current dir
bindkey -s '^t' 't\n'
# copy present working directory to clipboard
bindkey '^p' cppwd
setopt chaselinks
setopt autocd
# change below theme if using oh-my-zsh
#ZSH_THEME=""
HISTSIZE=100000
SAVEHIST=100000
setopt appendhistory
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY

# Load aliases
[ -f "$ZSHCFG/aliasrc" ] && source "$ZSHCFG/aliasrc"

# Note that in different distro or installation way below source files need to be changed, they are usually in ~/.zsh/
source "$ZSHCFG/OMZ/oh-my-zsh.sh"
zstyle ':completion:*:*:*:*:processes' command "ps -u $USER -o pid,user,comm -w -w"
zstyle ':fzf-tab:complete:(kill|ps):argument-rest' fzf-preview \
  '[[ $group == "[process ID]" ]] && ps --pid=$word -o cmd --no-headers -w -w'
zstyle ':fzf-tab:complete:(kill|ps):argument-rest' fzf-flags --preview-window=down:3:wrap
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1 --color=always $realpath' # remember to use single quote here!!!
zstyle ':fzf-tab:complete:systemctl-*:*' fzf-preview 'SYSTEMD_COLORS=1 systemctl status $word'
zstyle ':fzf-tab:*' single-group color header
zstyle -d ':completion:*' format
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:*:phint:*' sort false
#zstyle ':fzf-tab:complete:phint:argument-rest' fzf-flags  --no-sort --preview-window=down:60%:wrap --with-nth 1
zstyle ':fzf-tab:complete:phint:argument-rest' fzf-flags  --no-sort --preview-window=down:wrap --with-nth 1
zstyle ':fzf-tab:complete:phint:argument-rest' fzf-change-desc "swap"
#zstyle ':fzf-tab:complete:phint:argument-rest' fzf-preview 'echo Cmd: ${${(Q)desc#*--}::-2}'
zstyle ':fzf-tab:complete:phint:argument-rest' fzf-preview 'echo Cmd: ${word}; grep "" 2>/dev/null $(which ${word#*sudo\ })'


# vi mode
bindkey -v
export KEYTIMEOUT=1
export GPG_TTY=$(tty)
if [ ! -z $BM_DIR ]; then
    cd -P $BM_DIR &&
    export BM_DIR=""
fi

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

# Below to change autosuggestion options
bindkey '^[[Z' autosuggest-accept   # shift tab to accept ghost text
ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=(buffer-empty bracketed-paste accept-line push-line-or-edit)
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_USE_ASYNC=true

# powerline-daemon -q

case "$TERM" in (rxvt|rxvt-*|st|st-*|*xterm*|(dt|k|E)term)
    local term_title () { print -n "\e]0;${(j: :q)@}\a" }
    precmd () {
      local DIR="$(print -P '[%c]')"
      term_title "$DIR" "st"
    }
    preexec () {
      local DIR="$(print -P '[%c]%#')"
      local CMD="${(j:\n:)${(f)1}}"
      #term_title "$DIR" "$CMD" use this if you want directory in command, below only prints program name
	  term_title "$CMD"
    }
  ;;
esac

export LESS_TERMCAP_mb=$(tput bold; tput setaf 39)
export LESS_TERMCAP_md=$(tput bold; tput setaf 45)
export LESS_TERMCAP_me=$(tput sgr0)
#Custom
alias ..='cd ../'
alias ....= 'cd ../../'
alias cr="clear"
alias off="sudo shutdown --n now"
export PATH=~/.npm-global/bin:$PATH
export PATH=~/.cargo/bin:$PATH
# export PATH=~/.local/lib/python3.10/site-packages/pytesseract:$PATH
alias vi="nvim"
alias py3="python3"
alias so="source"
# Edit .zshrc and add this line
export PATH=$HOME/.config/rofi/scripts:$PATH
alias viminit="cd ~/.config/nvim/ && vi init.lua"
alias logout="pkill -u tonmoy"
alias xx="chmod +x"
alias :so='source ~/.zshrc'
alias :q="exit"
alias :nm="nmtui"
alias clock='tty-clock -c -C 4 -t'
# alias yt='yt-dlp -f 22'
alias lv="lvim"
alias nv="neovide"
alias phpserver="sudo php -S localhost:8080"
alias sda1="sudo mkdir -p /mnt/sda1 && sudo mount /dev/sda1 /mnt/sda1"
alias sda2="sudo mkdir -p /mnt/sda2 && sudo mount /dev/sda2 /mnt/sda2"
alias sda3="sudo mkdir -p /mnt/sda3 && sudo mount /dev/sda3 /mnt/sda3"
alias sda4="sudo mkdir -p /mnt/sda4 && sudo mount /dev/sda4 /mnt/sda4"
alias upgrade="sudo pacman -Syyu"
alias install="sudo pacman -S"
alias search="pacman -Ss"
alias remove="sudo pacman -Rns"
export PATH=~/.npm-global/bin:$PATH
export PATH="$PATH:$HOME/.config/composer/vendor/bin"
alias tnew='tmux new -s'
alias tattach="tmux a -t"
alias tdelete="tmux kill-session -t"
alias nrd="npm run dev"
alias nr="npm run"
alias nodeprocess="ps aux | grep node"


## BOOKMARKS
alias :ogani='cd /home/tonmoy/programme/php/ogani-master'
alias :hypr='cd ~/.config/hypr/'
alias :php="cd /home/tonmoy/programme/php/"
alias :js="cd /home/tonmoy/programme/js/"
alias :zsh="cd ~/.config/zsh/"
alias :config="cd ~/.config/"
alias update-grub="sudo grub-mkconfig -o /boot/grub/grub.cfg"
alias :vue="cd /home/tonmoy/programme/js/vue/vue-basics"
alias godot="godot --rendering-driver opengl3"
## OBS Fix wayland
export QT_QPA_PLATFORM=wayland
# export QT_QPA_PLATFORM=offscreen
# export QT_QPA_PLATFORMTHERE="qt5ct"

# for tiled map
# export QT_QPA_PLATFORM=xcb
export QT_QPA_PLATFORMTHERE="qt5ct"
