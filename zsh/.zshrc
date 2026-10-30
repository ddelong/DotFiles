# Enable Powerlevel10k instant prompt (keep near top)
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Homebrew environment & completion paths (must be set BEFORE compinit)
if [[ -f /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
  FPATH="$(brew --prefix)/share/zsh/site-functions:$FPATH"
fi

export CLICOLOR=1

# Antidote plugin manager initialization
source /opt/homebrew/opt/antidote/share/antidote/antidote.zsh
antidote load

# Completion configuration & initialization (-C skips security checks for speed)
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'
autoload -Uz compinit && compinit -C

# Terminfo-safe history search keybindings (works across terminal emulators)
[[ -n "${terminfo[kcuu1]}" ]] && bindkey "${terminfo[kcuu1]}" history-substring-search-up
[[ -n "${terminfo[kcud1]}" ]] && bindkey "${terminfo[kcud1]}" history-substring-search-down

# Native history options (replaces Oh My Zsh history dependencies)
HISTFILE="$HOME/.zsh_history"
HISTSIZE=50000
SAVEHIST=50000

setopt EXTENDED_HISTORY          # Record timestamp and execution duration
setopt SHARE_HISTORY             # Share history instantly across active terminal tabs
setopt HIST_EXPIRE_DUPS_FIRST    # Trim duplicate entries first when reaching capacity
setopt HIST_IGNORE_DUPS          # Ignore duplicate of previous command
setopt HIST_IGNORE_ALL_DUPS      # Remove older duplicate entries when new one is added
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found during search
setopt HIST_IGNORE_SPACE         # Don't record commands starting with a space
setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries to history file

# -------------------------------------------------------------
# Tool Integrations (fzf & zoxide)
# -------------------------------------------------------------

# fzf shell integration (provides Ctrl+R history search & file finding)
if type fzf &>/dev/null; then
  source <(fzf --zsh)
fi

# zoxide smart directory jumping (replaces cd -> 'z query')
if type zoxide &>/dev/null; then
  eval "$(zoxide init zsh)"
fi

# Theme configuration: Powerlevel10k (Active)
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Theme configuration: Starship (Uncomment below if you want to test Starship later)
# eval "$(starship init zsh)"
