# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific environment
PATH="$HOME/.local/bin:$HOME/bin:$PATH"
export PATH

# read local bashrc if exists
test -r ~/.bashrc.local && source ~/.bashrc.local

# set vi editing mode
set -o vi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*"'

# Terminal Prompt
# original PS1="[\u@\h \W]\$"
# Customized to show git branch
export PS1="[\W] (\$(git branch 2>/dev/null | grep '^*' | colrm 1 2))\$ "

# User specific aliases and functions
alias sudo='sudo '
alias ipy='ipython --TerminalInteractiveShell.editing_mode=vi'
alias lf='ls -laF --color'
alias gpg='gpg2'
alias rmdl='rm ~/Downloads/*'
alias :q=exit
