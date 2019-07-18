# Docker aliases
#

alias dckr-clean-containers='docker rm $(docker ps -q)'
alias dckr-clean-images='docker rmi -f $(docker images | grep "<none>" | awk "{print \$3}")'
