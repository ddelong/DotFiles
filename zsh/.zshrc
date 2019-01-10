# Aliases
alias abu='antibody bundle < ~/.zsh_plugins.txt > ~/.zsh_plugins.sh'

# Add new ruby to path
export PATH=/usr/local/opt/ruby/bin:/usr/local/lib/ruby/gems/2.6.0/bin:$PATH

# Powerlevel9k
DEFAULT_USER=$USER
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_MODE='nerdfont-complete'

# Oh My Zsh
DISABLE_AUTO_UPDATE=true
ZSH="$(antibody home)/https-COLON--SLASH--SLASH-github.com-SLASH-robbyrussell-SLASH-oh-my-zsh"

# brew autocomplete
if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH
fi

# Make sure to create the plugins file
if [[ ! -a ~/.zsh_plugins.sh ]] then
  echo "Plugins file missing. Creating."
  abu
fi

# Antibody
source ~/.zsh_plugins.sh
