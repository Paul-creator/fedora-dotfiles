if status is-interactive
    # Commands to run in interactive sessions can go here
end

# ---------- PATH ----------
# Fish prefers adding paths via fish_add_path (avoids duplicates)
fish_add_path $HOME/.local/bin

# PDK
set -gx PDK_ROOT $HOME/pdks

# ---------- Editor ----------
set -gx EDITOR nvim
set -gx VISUAL nvim

# ---------- Aliases ----------
# lsd (if installed)
alias ls lsd
alias l 'ls -l'
alias la 'ls -a'
alias lla 'ls -la'
alias lt 'ls --tree'

alias sak-pdk 'source ~/.local/bin/sak-pdk.sh'

# dotfiles bare repo
alias dot 'git --git-dir=$HOME/.dotfiles --work-tree=$HOME'

alias nano nvim

# ---------- fzf ----------
# Fish doesn’t use `source <(fzf --zsh)`.
# If you installed fzf via package manager, enable bindings like this:
if type -q fzf_configure_bindings
    fzf_configure_bindings --history=\cr
end

# ---------- zoxide ----------
# Fish integration
if type -q zoxide
    zoxide init fish | source
end

# ---------- conda ----------
# Fish has its own hook
if test -x $HOME/miniconda3/bin/conda
    eval ($HOME/miniconda3/bin/conda "shell.fish" "hook" 2> /dev/null)
end

source "$HOME/.cargo/env.fish"

source ~/miniconda3/etc/fish/conf.d/conda.fish

# ---------- tmux auto-start ----------
function is_real_terminal
    test -z "$VSCODE_PID"
    and test "$TERM_PROGRAM" != vscode
    and test "$TERM_PROGRAM" != JetBrains-JediTerm
end

if status is-interactive; and is_real_terminal
    cd ~/Downloads
    if type -q tmux; and not set -q TMUX
        exec tmux
    end
end
