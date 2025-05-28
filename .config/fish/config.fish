if status is-interactive
  set fish_greeting
  function last_history_item; echo $history[1]; end
  abbr -a !! --position anywhere --function last_history_item
  # Commands to run in interactive sessions can go here
  bind -M insert ctrl-h backward-kill-word
  bind -M insert ctrl-delete kill-word
  bind -M insert ctrl-a beginning-of-line
  bind -M insert ctrl-e end-of-line
  set copy 'echo -n $fish_killring[1] | fish_clipboard_copy'
  set -g fish_color_command green

  bind y,y kill-whole-line yank $copy
  bind Y kill-whole-line yank $copy
  bind y,\$ kill-line yank $copy
  bind y,^ backward-kill-line yank $copy
  bind y,0 backward-kill-line yank $copy
  bind y,w kill-word yank $copy
  bind y,W kill-bigword yank $copy
  bind y,i,w forward-single-char forward-single-char backward-word kill-word yank $copy
  bind y,i,W forward-single-char forward-single-char backward-bigword kill-bigword yank $copy
  bind y,a,w forward-single-char forward-single-char backward-word kill-word yank $copy
  bind y,a,W forward-single-char forward-single-char backward-bigword kill-bigword yank $copy
  bind y,e kill-word yank $copy
  bind y,E kill-bigword yank $copy
  bind y,b backward-kill-word yank $copy
  bind y,B backward-kill-bigword yank $copy
  bind y,g,e backward-kill-word yank $copy
  bind y,g,E backward-kill-bigword yank $copy
  bind y,f begin-selection forward-jump kill-selection yank end-selection $copy
  bind y,t begin-selection forward-jump-till kill-selection yank end-selection $copy
  bind y,F begin-selection backward-jump kill-selection yank end-selection $copy
  bind y,T begin-selection backward-jump-till kill-selection yank end-selection $copy
  bind y,h backward-char begin-selection kill-selection yank end-selection $copy
  bind y,l begin-selection kill-selection yank end-selection $copy
  bind y,i,b jump-till-matching-bracket and jump-till-matching-bracket and begin-selection jump-till-matching-bracket kill-selection yank end-selection $copy
  bind y,a,b jump-to-matching-bracket and jump-to-matching-bracket and begin-selection jump-to-matching-bracket kill-selection yank end-selection $copy
  bind y,i backward-jump-till and repeat-jump-reverse and begin-selection repeat-jump kill-selection yank end-selection $copy
  bind y,a backward-jump and repeat-jump-reverse and begin-selection repeat-jump kill-selection yank end-selection $copy
  bind p 'set -g fish_cursor_end_mode exclusive' forward-char 'set -g fish_cursor_end_mode inclusive' fish_clipboard_paste
  bind P fish_clipboard_paste

  bind -M visual -m default x kill-selection end-selection repaint-mode $copy
  bind -M visual -m default X kill-whole-line end-selection repaint-mode $copy
  bind -M visual -m default y kill-selection yank end-selection repaint-mode $copy
  bind -M visual -m default p kill-selection fish_clipboard_paste end-selection repaint-mode

  alias open='xdg-open'
  alias lgit='lazygit'
  alias ldocker='lazydocker'
  alias vim='nvim -u NONE'
  alias ip="ip -color"
  alias grep="grep --color"
  alias feh="feh --force-aliasing"
  alias ls="lsd"
  alias ll="ls -l"
  alias chafa="chafa --symbols vhalf"
  export LS_COLORS="$(vivid generate one-dark)"
  # batman
  export MANPAGER="sh -c 'sed -u -e \"s/\\x1B\[[0-9;]*m//g; s/.\\x08//g\" | bat -p -lman'"

  # TODO:
  # zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

  fish_add_path ~/.cargo/bin
  fish_add_path ~/.local/bin

  # use y instead of yazi to start, and press q to quit, you'll see the CWD changed. Sometimes, you don't want to change, press Q to quit
  function y
	  set tmp (mktemp -t "yazi-cwd.XXXXXX")
	  yazi $argv --cwd-file="$tmp"
	  if set cwd (command cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
		  builtin cd -- "$cwd"
	  end
	  rm -f -- "$tmp"
  end

  export RUSTC_WRAPPER=$(which sccache)
  alias cargo='mold -run cargo'

  # fzf
  export FZF_DEFAULT_OPTS='--info=inline --bind ctrl-j:down,ctrl-k:up'
  # TODO: port to fish
  # export FZF_COMPLETION_TRIGGER='\\'
  # export FZF_COMPLETION_OPTS='--preview "([[ $(file --mime {}) =~ directory ]] && tree -C {}) || ([[ $(file --mime {}) =~ binary ]] && echo {} is a binary file) || bat -n --color=always {} 2> /dev/null"'
  # export FZF_PREVIEW_COMMAND='([[ $(file --mime {}) =~ directory ]] && tree -C {}) || ([[ $(file --mime {}) =~ binary ]] && echo {} is a binary file) || bat -n --color=always {} 2> /dev/null'
  # export FZF_CTRL_T_OPTS="
  # --preview '(bat -n --color=always {} 2> /dev/null || cat {} || tree -C {}) 2> /dev/null'
  # --bind 'ctrl-/:change-preview-window(down|hidden|)'"
  # export FZF_ALT_C_OPTS="--preview 'tree -C {}'"
  export FZF_CTRL_R_OPTS="
  --reverse
  --preview 'echo {}' --preview-window up:3:hidden:wrap
  --bind 'ctrl-/:toggle-preview'
  --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'
  --color header:italic
  --header 'Press CTRL-Y to copy command into clipboard'"
  fzf --fish | source

  export EDITOR=nvim

  starship init fish | source
  zoxide init fish | source
end

