# Load ~/.extra, ~/.bash_prompt, ~/.exports, ~/.aliases and ~/.functions
# ~/.extra can be used for settings you donât want to commit
for file in ~/.{extra,bash_prompt,exports,aliases,functions}; do
  [ -r "$file" ] && source "$file"
done
unset file

#colours
export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad

#ssh-agent
SSH_ENV=$HOME/.ssh/environment
function start_agent {
     echo "Initializing new SSH agent..."
     /usr/bin/ssh-agent | sed 's/^echo/#echo/' > ${SSH_ENV}
     echo succeeded
     chmod 600 ${SSH_ENV}
     /usr/bin/ssh-add;
}
# Source SSH settings, if applicable
if [ -f "${SSH_ENV}" ]; then
     . ${SSH_ENV} > /dev/null
     ps -x | grep "^ *${SSH_AGENT_PID}" | grep ssh-agent$ > /dev/null || {
         start_agent;
     }
else
     start_agent;
fi

export PATH="./bin:$PATH" 
export PATH="/usr/local/mysql/bin:$PATH"

[[ -s "$HOME/.profile" ]] && source "$HOME/.profile" # Load the default .profile

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*


export PATH="$PATH:/Applications/DevDesktop/drush"
