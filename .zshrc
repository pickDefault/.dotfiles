# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="agnoster"
#echo "Theme: $RANDOM_THEME"

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
plugins=(
	git 
	vi-mode 
	colored-man-pages 
	dircycle
	tmux
	fzf
	fzf-tab
)
ZSH_TMUX_AUTOSTART=true
source $ZSH/oh-my-zsh.sh

# User configuration

# Personal customization
#	zsh-autocomplete:
#source /Users/orian/.oh-my-zsh/zsh-plugins/zsh-autocomplete/zsh-autocomplete.plugin.zsh

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

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
alias srm="rm -iv"
alias srmdir="rm -r -iv"
alias smv="mv -iv"
alias c="code"
# MAC ONLY: Alias for showing current track on tmux status-bar:
alias music="$(realpath ~/.dotfiles/tmux-scripts/tmux.show-music.sh)"
# MAC ONLY: Alias for navigating to ~/Desktop/Drive:
alias drive="cd ~/Desktop/Drive"
# Encrypting and decrypting files:
# Must be used with -in, -out flags
alias enc="openssl enc -aes-256-cbc -salt"
alias decrypt="openssl enc -d -aes-256-cbc"
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/orian/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/orian/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/orian/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/orian/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# Personal customizations;
# 	Case-insensitive globbing
unsetopt CASE_GLOB
#	Auto-correct commands:
setopt CORRECT
setopt HASH_LIST_ALL
#	Change the prompt a bit, with colors:
autoload U colors && colors
export SPROMPT="Correct $fg[red]%R$reset_color to $fg[green]%r$reset_color? [ (Y)es, (N)o, (A)bort, (E)dit ]"

#	Customize vi-mode plugin
VI_MODE_RESET_PROMPT_ON_MODE_CHANGE=true
VI_MODE_SET_CURSOR=true
MODE_INDICATOR="%F{white}+%f"
INSERT_MODE_INDICATOR="%F{yellow}+%f"
#	zsh's tab completion library for Git and include branch name in zsh prompt
# (https://git-scm.com/book/en/v2/Appendix-A%3A-Git-in-Other-Environments-Git-in-Zsh)
autoload -Uz compinit && compinit
#autoload -Uz vcs_info
#precmd_vcs_info() { vcs_info }
#precmd_functions+=( precmd_vcs_info )
#setopt prompt_subst
#RPROMPT='${vcs_info_msg_0_}'
## PROMPT='${vcs_info_msg_0_}%# '
#zstyle ':vcs_info:git:*' formats '%b'

# MAC ONLY: Hide orian@Orian-MacbookPro from agnoster theme
export DEFAULT_USER=orian

# See https://github.com/Aloxaf/fzf-tab/issues/214
# Makes fzf-tab trigger at shift-tab instead of tab
#bindkey "^[[Z" fzf-tab-complete
#bindkey "^I" expand-or-complete

export FZF_COMPLETION_TRIGGER='"'

# https://github.com/Aloxaf/fzf-tab/issues/104 For the two next commands:
    # Enable fzf-tab to include directories ., ..
zstyle ':completion:*' special-dirs true
    # Enable fzf-tab to include hidden files
setopt GLOB_DOTS

# https://github.com/junegunn/fzf/issues/634 for the following:
# Enable fzf to show hidden files (Both in C-T and normal usage)
export FZF_DEFAULT_COMMAND='find . \! \( -type d -path ./.git -prune \) \! -type d \! -name '\''*.tags'\'' -printf '\''%P\n'\' #'ag --hidden --ignore .git -g "" 2> /dev/null'
export FZF_CTRL_T_COMMAND='find . \! \( -type d -path ./.git -prune \) \! -type d \! -name '\''*.tags'\'' 2> /dev/null' #'ag --hidden --ignore .git -g "" 2> /dev/null'

# In fzf, multi-select with Ctrl-Space and remove selection with Ctrl-X
export FZF_DEFAULT_OPTS="-m -x --bind ctrl-space:select,ctrl-x:deselect,tab:down,shift-tab:up"

# https://unix.stackexchange.com/questions/108182/tmux-conf-prefix-depends-on-whether-session-is-remote
# If machine is in a remote session, change the prefix
# if [[ -n "$SSH_CLIENT" && -n "$TMUX" ]] ; then
#   tmux unbind c-a
#   tmux set -g prefix c-q
#   tmux bind c-q send-prefix
# fi
