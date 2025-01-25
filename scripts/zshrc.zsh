# alias
alias open='xdg-open'
alias mkcd='function __mkcd(){ if [ $# = 1 ]; then mkdir $1; if [ $? = 0 ]; then cd $1; fi; unset -f __mkcd; elif [ $# = 2 ]; then mkdir $1 $2; if [ $? = 0 ]; then if [ -d $1 ]; then cd $1; elif [ -d $2 ]; then cd $2; fi; fi; unset -f __mkcd; fi }; __mkcd'
alias lgit='lazygit'
alias ldocker='lazydocker'
alias ip="ip -color"
alias grep="grep --color"
alias feh="feh --force-aliasing"
alias ls="lsd"
alias ll="ls -l"
export LS_COLORS="$(vivid generate one-dark)"

unalias run-help
autoload run-help
HELPDIR=/usr/share/zsh/"${ZSH_VERSION}"/help
alias help=run-help

HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
zstyle :compinstall filename '/home/xcdnlgd/.zshrc'
autoload -Uz compinit
compinit
zstyle ':completion:*' menu select
zstyle ':completion::complete:*' gain-privileges 1
# 0 -- vanilla completion (abc => abc)
# 1 -- smart case completion (abc => Abc)
# 2 -- word flex completion (abc => A-big-Car)
# 3 -- full flex completion (abc => ABraCadabra)
zstyle ':completion:*' matcher-list '' \
	'm:{a-z\-}={A-Z\_}' \
	'r:[^[:alpha:]]||[[:alpha:]]=** r:|=* m:{a-z\-}={A-Z\_}' \
	'r:|?=** m:{a-z\-}={A-Z\_}'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:*:*:*:descriptions' format '%F{green}-- %d --%f'
zstyle ':completion:*:*:*:*:corrections' format '%F{yellow}!- %d (errors: %e) -!%f'
zstyle ':completion:*:messages' format ' %F{purple} -- %d --%f'
zstyle ':completion:*:warnings' format ' %F{red}-- no matches found --%f'
zstyle ':completion:*' group-name ''
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
bindkey -v
bindkey -v '^?' backward-delete-char '^[[3~' delete-char
bindkey '^[[3;5~' kill-word # ctrl+delete
bindkey '^H' backward-kill-word # ctrl+backspace
bindkey '^[[Z' reverse-menu-complete # shift+tab, select prev
bindkey "^[[H" beginning-of-line # HOME
bindkey "^[[1~" beginning-of-line # HOME in tmux
bindkey "^A" beginning-of-line # emacs
bindkey "^[[F" end-of-line # END
bindkey "^[[4~" end-of-line # END in tmux
bindkey "^E" end-of-line # emacs
zmodload zsh/complist
bindkey -M menuselect '^[' undo
KEYTIMEOUT=10 # fast undo
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'l' vi-forward-char
unsetopt BEEP
setopt no_nomatch

# cargo install
# export PATH="${PATH}:/home/xcdnlgd/.cargo/bin"
set_path(){

    # Check if user id is 1000 or higher
    [ "$(id -u)" -ge 1000 ] || return

    for i in "$@";
    do
        # Check if the directory exists
        [ -d "$i" ] || continue

        # Check if it is not already in your $PATH.
        echo "$PATH" | grep -Eq "(^|:)$i(:|$)" && continue

        # Then append it to $PATH and export it
        export PATH="${PATH}:$i"
    done
}

set_path ~/.cargo/bin
set_path ~/.local/bin

export RUSTC_WRAPPER=$(which sccache)

# fzf
export FZF_DEFAULT_OPTS='--info=inline --bind ctrl-j:down,ctrl-k:up'
export FZF_COMPLETION_TRIGGER='\'
export FZF_COMPLETION_OPTS='--preview "([[ $(file --mime {}) =~ directory ]] && tree -C {}) || ([[ $(file --mime {}) =~ binary ]] && echo {} is a binary file) || bat -n --color=always {} 2> /dev/null"'
export FZF_PREVIEW_COMMAND='([[ $(file --mime {}) =~ directory ]] && tree -C {}) || ([[ $(file --mime {}) =~ binary ]] && echo {} is a binary file) || bat -n --color=always {} 2> /dev/null'
export FZF_CTRL_T_OPTS="
  --preview '(bat -n --color=always {} 2> /dev/null || cat {} || tree -C {}) 2> /dev/null'
  --bind 'ctrl-/:change-preview-window(down|hidden|)'"
export FZF_CTRL_R_OPTS="
  --reverse
  --preview 'echo {}' --preview-window up:3:hidden:wrap
  --bind 'ctrl-/:toggle-preview'
  --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'
  --color header:italic
  --header 'Press CTRL-Y to copy command into clipboard'"
export FZF_ALT_C_OPTS="--preview 'tree -C {}'"
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh
# zvm_after_init_commands+=('source /usr/share/fzf/key-bindings.zsh && source /usr/share/fzf/completion.zsh')

eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
