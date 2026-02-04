if status is-interactive
    # Commands to run in interactive sessions can go here
end

function fish_prompt
    echo -n (prompt_pwd) "> " # ➜ ➤ ➦ ➥ ➔ ❯ ❱ ➭ ➙ ➽ ➼ 
end

set -U fish_greeting ""

# Говорит терминалу установить курсор в виде блока
printf "\e[4 q"

/home/izunamori/.config/awesome/scripts/functional/installed-days-ago-fetch.sh
echo ""
fastfetch

export PATH="$HOME/.local/bin:$PATH"

alias ls="lsd"
alias pizdec="archarchive"

