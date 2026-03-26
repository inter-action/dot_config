# enable completion
autoload -Uz compinit && compinit -d ~/.cache/zcompdump-$HOST

# zinit
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
if [[ ! -d $ZINIT_HOME ]]; then
    mkdir -p "$(dirname $ZINIT_HOME)"
    # use this command to force update
    # git fetch --depth 1 && git reset --hard
    git clone --depth=1 https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi
source "${ZINIT_HOME}/zinit.zsh"

# prefer zinit to load snippet directly
# but keep this repo clone in here because I like to load this locally.
export ZSH="$HOME/.ohmyzsh"
if [[ ! -d $ZSH ]]; then
    git clone --depth=1 https://github.com/ohmyzsh/ohmyzsh.git "$ZSH"
fi

# zinit: zsh package manager
# run: 
#   zinit help

# Load starship theme
# line 1: `starship` binary as command, from github release
# line 2: starship setup at clone(create init.zsh, completion)
# line 3: pull behavior same as clone, source init.zsh

# zinit ice as"command" from"gh-r" \
#           atclone"./starship init zsh > init.zsh; ./starship completions zsh > _starship" \
#           atpull"%atclone" src"init.zsh"
# zinit load starship/starship

# add zinit packages
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions

#Refresh Zsh completions instantly
zinit cdreplay -q


# enable zsh git plugin
# download file directly from https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/git/git.plugin.zsh
# OMZP is a morden way to load snippet from official repo 
# zinit snippet OMZP::git
# zinit snippet OMZP::rsync
# zinit snippet OMZP::fzf
# zinit snippet OMZP::kubectl
# zinit snippet OMZP::uv
# zinit snippet OMZP::starship
# zinit snippet OMZP::nvm

# OR load plugin via (legacy)
# zinit snippet "https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/plugins/git/git.plugin.zsh"

# load plugin locally
zinit snippet "$ZSH/plugins/git/git.plugin.zsh"
zinit snippet "$ZSH/plugins/rsync/rsync.plugin.zsh"
zinit snippet "$ZSH/plugins/fzf/fzf.plugin.zsh"
zinit snippet "$ZSH/plugins/kubectl/kubectl.plugin.zsh"
zinit snippet "$ZSH/plugins/uv/uv.plugin.zsh"
zinit snippet "$ZSH/plugins/starship/starship.plugin.zsh"
zinit snippet "$ZSH/plugins/nvm/nvm.plugin.zsh"


# load plugin manullay
#
# plugin fzf
#   load fzf (no need, by above zsh plugin)
# [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


# --- fzf configuration
export FZF_DEFAULT_COMMAND='fd --type f'
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'
# Use ~~ as the trigger sequence instead of the default **
export FZF_COMPLETION_TRIGGER='~~'
# Use fd (https://github.com/sharkdp/fd) instead of the default find
# command for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}
# --- end:fzf


# plugin kubectl
# if command -v kubectl &> /dev/null; then
#     source <(kubectl completion zsh)
# fi


# --- start ship (loaded by zsh plugin above)
# eval "$(starship init zsh)"

# auto completion
bindkey '^f' autosuggest-accept
# using emac bindings
bindkey -e

# ctrl + p/n
bindkey "^p" history-beginning-search-backward
bindkey "^n" history-beginning-search-forward

# history settings
# Maximum lines kept in memory (set to a large number like 1 million or more)
HISTSIZE=100000
# Maximum lines saved to $HISTFILE (set to the same large number)
SAVEHIST=100000
# Write to the history file immediately, not when the shell exits
setopt INC_APPEND_HISTORY
# Share history between all sessions
setopt SHARE_HISTORY
# Record the time when each command was executed along with the command itself
setopt EXTENDED_HISTORY
# Do not record an event that was just recorded again
setopt HIST_IGNORE_DUPS
# Delete an old recorded event if a new event is a duplicate
setopt HIST_IGNORE_ALL_DUPS
# Do not display a previously found event (I use fzf, disable it for now)
# setopt HIST_FIND_NO_DUPS
# Do not record an event starting with a space (useful for sensitive commands)
setopt HIST_IGNORE_SPACE


# colors
alias ls='ls --color=auto -hv'
alias grep='grep --color=auto'
alias diff='diff --color=auto'
alias ip='ip -c=auto'


# --- end:cli tools config

# OS related
if [[ $(uname) == "Darwin" ]]; then
    # ruby
    export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
    export GEM_HOME=$HOME/.gem/ruby/3.3.0
    export PATH=$GEM_HOME/bin:$PATH

    # homebrew
    # disable homebrew auto update
    export HOMEBREW_NO_AUTO_UPDATE=0
    export PATH=/opt/homebrew/bin:$PATH

    # editor
    export EDITOR=nvim

    # export JAVA_HOME=/Library/Java/JavaVirtualMachines/microsoft-17.jdk/Contents/Home
    # export PATH=$JAVA_HOME/bin:$PATH

    # android
    export PATH="$HOME/Library/Android/sdk/platform-tools:$PATH"
else
    # linux
    export PATH="$HOME/.local/bin:$PATH"
    # snap
    export PATH="$PATH:/snap/bin"
    # cargo 
    export PATH="$HOME/.cargo/bin:$PATH"
fi

# personal utils function: toggle theme
# need to manullay restart alacritty. not a big trouble as I am using tmux.
toggle_theme() {
    local mode="$1"
    local theme_dir="$HOME/.config/alacritty/themes"
    local current_theme="$HOME/.config/alacritty/current_theme.toml"
    local sharship_dir="$HOME/.config/starship"
    local sharship_current="$HOME/.config/starship.toml"
    case "$mode" in
        dark)
            ln -sf "$theme_dir/nightfox.toml" "$current_theme"
            touch ~/.config/alacritty/alacritty.toml
            ln -sf "$sharship_dir/nightfox.toml" "$sharship_current"
            # nvim & tmux
            export NVIM_THEME=nightfox
            # send keys to force theme change via tmux send-keys
            tmux list-panes -a -F '#{pane_id} #{pane_current_command}' | \
                grep 'nvim' | cut -d' ' -f1 | \
                xargs -I % tmux send-keys -t % Escape ":colorscheme nightfox" Enter
            tmux set-environment -g NVIM_THEME "nightfox"
            tmux source "$HOME/.config/tmux/themes/nightfox.tmux"

            git config --global delta.dark true
            git config --global delta.light false
            echo "Switched to dark theme."
            ;;
        light)
            ln -sf "$theme_dir/dayfox.toml" "$current_theme"
            touch ~/.config/alacritty/alacritty.toml
            ln -sf "$sharship_dir/dayfox.toml" "$sharship_current"
            # nvim & tmux
            export NVIM_THEME=dayfox
            tmux list-panes -a -F '#{pane_id} #{pane_current_command}' | \
                grep 'nvim' | cut -d' ' -f1 | \
                xargs -I % tmux send-keys -t % Escape ":colorscheme dayfox" Enter
            tmux set-environment -g NVIM_THEME "dayfox"
            tmux source "$HOME/.config/tmux/themes/dayfox.tmux"

            git config --global delta.dark false
            git config --global delta.light true
            echo "Switched to light theme."
            ;;
        *)
            echo "Usage: toggle_theme [light|dark]" >&2
            return 2
            ;;
    esac
}

update_zinit() {
    # 先判断 ZINIT_HOME 是否存在
    if [[ -d "$ZINIT_HOME" ]]; then
        cd "$ZINIT_HOME" || return 1
        # 强制更新浅克隆仓库（depth=1 专用）
        git fetch --depth 1 && git reset --hard origin/HEAD
    fi

    if [[ -d "$ZSH" ]]; then
        cd "$ZSH" || return 1
        # 强制更新浅克隆仓库（depth=1 专用）
        git fetch --depth 1 && git reset --hard origin/HEAD
    fi

    # Zinit 官方更新
    zinit self-update
    zinit update

    # 清理 + 刷新补全
    zinit delete --clean
    zinit cdreplay

    echo -e "\n✅ Zinit 更新完成！"
}
