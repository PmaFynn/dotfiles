# If you come from bash you meght have to change your $PATH.
# test if read only
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
export ICECAT_HOME="/opt/icecat/"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git vi-mode)

source $ZSH/oh-my-zsh.sh

#start tmux directly
# if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
#   exec tmux new-session && exit;
# fi


# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi
export VISUAL=vi
export EDITOR=vi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
# apt package mangager aliases:

# alias init="sudo pacman -Syu && clear && echo \"----------------------------\" && cal && echo \"----------------------------\" && khal list && echo \"---------------------------- \n *help* for searchable list of functions and aliases\""
alias check="curl https://am.i.mullvad.net/json | jq"
alias initFull="sudo pacman -Syu && sudo pacman -Rns $(pacman -Qdtq)"

alias install="sudo pacman -S"
alias remove="sudo pacman -Rn"


#shutdown // reboot
alias shutdown="sudo shutdown -h now"
alias reboot="sudo reboot"

#I like to move it
alias ..="cd .."
alias ...="cd ../.."

#nvim config
alias cf="cd ~/.config"

#fetch merge with upstream
alias pullup="git fetch upstream && git checkout master && git merge upstream/master"

#activate ds enviornment
# alias initConda="cd && source anaconda3/bin/activate"
# alias aag="initConda && conda activate aag && cd ~/misc/uni/2semester/dsAAG/aag-project"
# alias ds="cd misc/uni/2semester/dsAAG/report"

function yy() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

function svi() {
    local file
    file=$(fd --type f --hidden --exclude .git | fzf --reverse --preview 'bat {1}') || return 1
    cd "$(dirname "$file")" || return 1
    basename $file | xargs vi || return 1
}

function fcd() {
    file=$(fd --type f --hidden --exclude .git | fzf --reverse --preview 'bat {1}') || return 1
    cd "$(dirname "$file")" || return 1
}

getLinks() {
    if [[ -z "$1" ]]; then
        echo "Usage: getLinks <playlist_url> [<nameOfJsonFile>]"
        return 1
    fi

    # If the second argument (filename) is not provided, use 'watchLater.json'
    if [[ -z "$2" ]]; then
        FILENAME="watchLater"
    else
        FILENAME="$2"
    fi

    # Set the default directory
    SAVE_DIR=~/media/playlistsAsJson/

    # Create the directory if it doesn't exist
    mkdir -p "$SAVE_DIR"

    # Set the output file path
    OUTPUT_FILE="${SAVE_DIR}${FILENAME}.json"

    # Create a temporary file for the new data
    TEMP_FILE=$(mktemp)

    # Run yt-dlp and save new data to the temporary file
    yt-dlp -j --flat-playlist --dateafter now-30days "$1" | jq -r '[. | {title: .title, url: ("https://www.youtube.com/watch?v=" + .id)}]' > "$TEMP_FILE"

    if [[ $? -ne 0 ]]; then
        echo "An error occurred."
        rm "$TEMP_FILE"  # Clean up the temporary file
        return 1
    fi

    # Check if the JSON file already exists
    if [[ -f "$OUTPUT_FILE" ]]; then
        # If it exists, merge the new data with the existing data
        jq -s '.[0] + .[1]' "$OUTPUT_FILE" "$TEMP_FILE" > "${OUTPUT_FILE}.tmp" && mv "${OUTPUT_FILE}.tmp" "$OUTPUT_FILE"
    else
        # If the file doesn't exist, simply move the temp file to the output file
        mv "$TEMP_FILE" "$OUTPUT_FILE"
    fi

    if [[ $? -eq 0 ]]; then
        echo "Playlist links saved to $OUTPUT_FILE"
    else
        echo "An error occurred."
    fi
}

getFromJson() {
    # Ask what the user wants to do
    echo "Do you want to: [w]atch the video, download the [a]udio, or [v]ideo download?"
    read -k1 action
    echo

    # Set the yt-dlp command based on user input
    case $action in
        w)
            yt_dlp_command="mpv"
            ;;
        a)
            mkdir ~/media/videos/misc/
            cd ~/media/music/misc/
            yt_dlp_command="yt-dlp --extract-audio --audio-format mp3"
            ;;
        v)
            mkdir ~/media/videos/misc/
            cd ~/media/videos/misc/
            yt_dlp_command="yt-dlp -f bestvideo+bestaudio --merge-output-format mkv -o \"%(title)s.%(ext)s\""
            ;;
        *)
            echo "Invalid option selected"
            return 1
            ;;
    esac

    # Use fzf to find a title in the JSON files
    selected=$(jq -r '.[] | .title' ~/media/playlistsAsJson/*.json | fzf --prompt="Search for a video: ")

    if [ -z "$selected" ]; then
        echo "No selection made."
        return 1
    fi

    # Get the corresponding URL
    url=$(jq -r --arg title "$selected" '.[] | select(.title == $title) | .url' ~/media/playlistsAsJson/*.json)

    if [ -z "$url" ]; then
        echo "No URL found for the selected title."
        return 1
    fi

    eval "$yt_dlp_command \"$url\""
}


mssf() {
    # Define the target directory within ~/media/music
    target_dir="$HOME/media/music/favs/"

    # Create the target directory if it doesn't exist
    mkdir -p "$target_dir"
    fd --type f --extension mp3 --extension m4a --hidden | fzf --reverse --preview 'bat {1}' | while read -r file; do
    mv "$file" "$target_dir"
    done
}

favs() {
  while true; do
    fd -e mp3 -e m4a -t f -0 . $HOME/media/music/favs/ | shuf -z -n 1 | xargs -0 mpv --no-audio-display
  done
}

# find local music fast
mss() {
    # Define the target directory within ~/media/music
    target_dir="$HOME/media/"
  fd --type f -e mp3 -e m4a -I --hidden --exclude .git . $target_dir | fzf --reverse --preview 'bat {1}' | while read -r file; do
    mpv --no-audio-display "$file"
  done
}
wl() {
    # Ask what the user wants to do
    echo "Do you want to: [w]atch the video or [d]ownload it?"
    read -k1 action
    echo

    # Set the yt-dlp command based on user input
    case $action in
        w)
            yt_dlp_command="mpv"
            ;;
        d)
            mkdir ~/media/videos/watchLater
            cd ~/media/videos/watchLater
            yt_dlp_command="yt-dlp -f bestvideo+bestaudio --merge-output-format mkv -o \"%(title)s.%(ext)s\""
            ;;
        *)
            echo "Invalid option selected"
            return 1
            ;;
    esac
    # Use fzf to find a title in the JSON files
    selected=$(jq -r '.[] | .title' ~/media/playlistsAsJson/watchLater.json | fzf --reverse --prompt="Search for a video: ")

    if [ -z "$selected" ]; then
        echo "No selection made."
        return 1
    fi

    # Get the corresponding URL
    url=$(jq -r --arg title "$selected" '.[] | select(.title == $title) | .url' ~/media/playlistsAsJson/watchLater.json)

    if [ -z "$url" ]; then
        echo "No URL found for the selected title."
        return 1
    fi

    eval "$yt_dlp_command \"$url\""
}

# play random song fast
rms() {
  fd -e mp3 -t f -0 | shuf -z -n 1 | xargs -0 mpv --no-audio-display
}

rmsl() {
  while true; do
    fd -e mp3 -t f -0 | shuf -z -n 1 | xargs -0 mpv --no-audio-display
  done
}

# requires ntfs-3g on linux
#   -> sudo pacman -S ntfs-3g
# expects [/dev/sdX1] [/mnt/usb]
alias mountDisk="sudo mount -t ntfs-3g"

alias usb="lsblk"

alias pwc="pass show -c"
alias pwi="pass insert"

# LLMs
alias yiCode="ollama run yi-coder"
alias phi="ollama run phi4"

#yt
alias yt="mkdir -p ~/media/tmp/ && cd ~/media/tmp/ && ytfzf"

#yt-dlp

getAudioToDynamicDir() {
    # Check if a URL was provided
    if [ -z "$1" ]; then
        echo "Usage: getAudio <URL>"
        exit 1
    fi

    # Capture the URL passed as an argument
    url=$1

    # Get the current date in YYYY-MM-DD format
    current_date=$(date +"%Y-%m-%d")

    # Define the target directory within ~/media/music
    target_dir="$HOME/media/music/$current_date"

    # Create the target directory if it doesn't exist
    mkdir -p "$target_dir"

    # Change to the target directory, or exit with an error message
    cd "$target_dir" || { echo "Failed to change directory to $target_dir"; exit 1; }

    # Check if yt-dlp is installed
    if ! command -v yt-dlp &> /dev/null; then
        echo "yt-dlp could not be found"
        exit 1
    fi

    # Run yt-dlp command to download audio from the provided URL
    yt-dlp -x --extract-audio --embed-thumbnail --audio-format mp3 --audio-quality high \
           --add-metadata --embed-metadata --parse-metadata "%(uploader)s:%(meta_artist)s" \
           -o "%(title)s.%(ext)s" "$url"
}

# alias getAudio="yt-dlp -x --extract-audio --embed-thumbnail --audio-format AAC --audio-quality high -o \"%(title)s.%(ext)s\""
alias getAudioCustom="yt-dlp -x --extract-audio --embed-thumbnail --audio-format mp3 --audio-quality high --add-metadata --embed-metadata --parse-metadata \"%(uploader)s:%(meta_artist)s\" -o \"%(title)s.%(ext)s\""
# alias getAudio="mkdir -p ~/media/music && cd ~/media/music && yt-dlp -x --extract-audio --embed-thumbnail --audio-format mp3 --audio-quality high --add-metadata --embed-metadata --parse-metadata \"uploader:%(artist)s\" -o \"%(title)s.%(ext)s\""
alias getMovie="cd ~/media/videos/movies/ && yt-dlp -f bestvideo+bestaudio --merge-output-format mkv -o \"%(title)s.%(ext)s\""
alias getVideo="cd ~/media/videos/ && yt-dlp -f bestvideo+bestaudio --merge-output-format webm -o \"%(title)s.%(ext)s\""


alias cale="khal calendar"

alias bday="khal search bday | head -5"
alias cal="cal -m"

# expects [datetime] [summary]
alias addBday="khal new -g bday -r yearly"
# next 5 bdays

helpStatic() {
    echo "
    getLinks -> takes a yt link as argument and adds it either to watch later json file if no second argument is given or to the second argument -> \"getLinks ytLink name\" -> name.json -> media \n
    wl -> search through watch Later playlist -> media \n
    yt -> opens youtube cli -> media \n
    getFromJson -> searches through all playlists of mine -> media \n
    mss -> searches for music -> media \n
    today -> shows stuff todo :D \n
    .. -> goes back one directory -> misc \n
    td -> opens calcurse -> misc \n
    rmsl -> plays random music on loop -> media \n
    mssf -> search music to add selected to favourites -> media \n
    favs -> plays favourites on shuffle -> media \n
    usb -> lsblk -> misc \n
    mountDisk -> to mount Harddrive: expects [/dev/sdX1] [/mnt/usb] -> misc \n
    pullup -> sync fork <- actually maybe just use github website -> misc \n
    yy -> opens yazi file manager -> misc \n
    "
}

alias help="helpStatic | fzf --reverse"

#TODO: update to maintained fork
alias ls="eza"

vpnup() {
    sudo wg-quick up /etc/wireguard/NL-FREE-2076.conf
    sudo sysctl -w net.ipv6.conf.all.disable_ipv6=1
    sudo sysctl -w net.ipv6.conf.default.disable_ipv6=1
    curl https://am.i.mullvad.net/json | jq
}
vpndown() {
    sudo wg-quick down /etc/wireguard/NL-FREE-2076.conf
    sudo sysctl -w net.ipv6.conf.all.disable_ipv6=0
    sudo sysctl -w net.ipv6.conf.default.disable_ipv6=0
    curl https://am.i.mullvad.net/json | jq
}

alias uniotp="oathtool --totp b10ada0fe7c9e4443856ceadad78b1caa1b88164"

moveMusic() {
    find $HOME/media/yt-dlp-scripts/ -type f \( -iname "*.mp3" -o -iname "*.m4a" \) -exec mv {} $HOME/media/music/ \;
}

alias news="newsboat -r"
alias exportNews="newsboat -e > $HOME/mega/dotDocuments/feeds.opml"

td() {
    local prio="0"
    local item=""

    if [ $# -eq 0 ]; then
        calcurse
    elif [[ "$1" == "-h" || "$1" == "--help" ]]; then
        echo -e "USAGE:\n\ttd -[0-9]? todo goes here\n\nEXAMPLE:\n\ttd -2 clean kitchen"
    elif [[ $1 =~ ^-[0-9]$ ]]; then
        prio=${1#-}  # Extract the number (remove leading '-')
        shift        # Remove the first argument
        item="$*"    # Capture the remaining arguments as the todo item
    else
        item="$*"    # No priority flag, just the item
    fi

    if [[ -n "$item" ]]; then
        echo "[$prio] $item" >> /home/fynn/.local/share/calcurse/todo
    fi
}

init() {
    sudo pacman -Syu
    clear
    echo "Do you want to clean up big time? [y]es | [n]o"
    read -k1 action
    echo

    # Set the yt-dlp command based on user input
    case $action in
        y)
            sudo pacman -Rns $(pacman -Qdtq)
            ;;
        *)
            ;;
    esac
    clear
    # Ask what the user wants to do
    echo "Do you want to: [a]ctivate the vpn and [d]on't?"
    read -k1 action
    echo

    # Set the yt-dlp command based on user input
    case $action in
        a)
            vpnup
            ;;
        *)
            ;;
    esac

    echo "-------------------------------\n"
    curl https://am.i.mullvad.net/json | jq

    echo "Do you want to read your rss feed? [y]es | [n]o"
    read -k1 action
    echo

    # Set the yt-dlp command based on user input
    case $action in
        y)
            news
            ;;
        *)
            ;;
    esac

    echo "Do you want to turn on music? [y]es | [n]o"
    read -k1 action
    echo

    # Set the yt-dlp command based on user input
    case $action in
        y)
            rmsl
            ;;
        *)
            ;;
    esac

    clear
    echo "-------------------------------\n *help* for searchable list of functions and aliases\n-------------------------------"
    calcurse --todo --appointment
}

# alias syncRemote="rclone copy -P mega:/dotDocuments/ /home/fynn/mega/dotDocuments/"
alias sl="cd /home/fynn/misc/uni/master4/sl/python/ && source .venv/bin/activate && zed . && exit"
alias algo="cd /home/fynn/projects/python/algoVis/ && source .venv/bin/activate && zed . && exit"
alias regex="cd tmp/textual_apps && source bin/activate && regexexercises"
alias today="calcurse --todo --appointment"


alias webui="DATA_DIR=~/.open-webui uvx --python 3.11 open-webui@latest serve"

function latin() {
    echo "What? [l]ingva latina, lingva latina [e]xercises, lingva latina [audiobook], [p]ugio bruti"
    read -k1 action
    echo

    # audiobook: https://www.youtube.com/watch?v=YtPd2ALW5b4
    case $action in
        l)
            zathura /home/fynn/media/books/latinBooks/lingvaLatina.pdf & disown; exit
            ;;
        e)
            zathura /home/fynn/media/books/latinBooks/lingvaLatinaExercises.pdf & disown; exit
            ;;
        a)
            mpv /home/fynn/media/audiobooks/lingvaLatinaAudio.opus
            ;;
        p)
            zathura /home/fynn/media/books/latinBooks/linvaLatina.pdf & disown; exit
            ;;
        *)
            ;;
    esac
    clear
}

alias lb="./projects/ladybird/Build/release/bin/Ladybird"

#docker
#alias dockerdesk="systemctl --user start docker-desktop"

# # >>> conda initialize >>>
# # !! Contents within this block are managed by 'conda init' !!
# __conda_setup="$('/home/fynn/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
# if [ $? -eq 0 ]; then
#     eval "$__conda_setup"
# else
#     if [ -f "/home/fynn/anaconda3/etc/profile.d/conda.sh" ]; then
#         . "/home/fynn/anaconda3/etc/profile.d/conda.sh"
#     else
#         export PATH="/home/fynn/anaconda3/bin:$PATH"
#     fi
# fi
# unset __conda_setup
# # <<< conda initialize <<<


# eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

. "$HOME/.local/bin/env"
