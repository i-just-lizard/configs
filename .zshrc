HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=10000
export PATH="$HOME/Telegram:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/vk-messenger:$PATH"
unsetopt beep
bindkey -v
zstyle :compinstall filename '/home/lizard/.zshrc'
autoload -Uz compinit
compinit
alias lf=lf-ueberzug
source ~/antigen.zsh
antigen use oh-my-zsh
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-completions
antigen bundle zsh-users/zsh-autosuggestions
antigen theme cypher
antigen apply
