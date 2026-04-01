# Run the env.sh script (if it exists). That script is meant to contain secrets, tokens, and
# other things you don't want to put in your Nix config

eval "$(zoxide init zsh)"
if [ -e ~/.env.sh ]; then
  . ~/.env.sh
fi

#compdef gt
###-begin-gt-completions-###
#
# yargs command completion script
#
# Installation: gt completion >> ~/.zshrc
#    or gt completion >> ~/.zprofile on OSX.
#
_gt_yargs_completions()
{
  local reply
  local si=$IFS
  IFS=$'
' reply=($(COMP_CWORD="$((CURRENT-1))" COMP_LINE="$BUFFER" COMP_POINT="$CURSOR" gt --get-yargs-completions "${words[@]}"))
  IFS=$si
  _describe 'values' reply
}
compdef _gt_yargs_completions gt
###-end-gt-completions-##
#

export PATH="${PATH}:${HOME}/.krew/bin"
export PATH="${PATH}:${HOME}/Library/Application Support/Coursier/bin"
export PATH="${PATH}:${HOME}/go/bin"
export WORDCHARS=''
export USE_GKE_GCLOUD_AUTH_PLUGIN=True
export DOCKER_HOST="unix://${HOME}/.local/share/containers/podman/machine/qemu/podman.sock"
export PYENV_ROOT="${HOME}/.pyenv"
autoload -Uz incarg
zle -N incarg
bindkey -M vicmd '^a' incarg

autoload -Uz edit-command-line
zle -N edit-command-line
bindkey -M vicmd 'vv' edit-command-line
