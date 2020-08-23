if [[ ! $commands[kubectl] ]]; then
return 1;
fi

source <(kubectl completion zsh)
source "${0:h}/aliases.zsh"

# So kubectl picks up the plugin
export PATH="$PATH:$HOME/.kube/kubectl-login"