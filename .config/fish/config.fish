if status is-interactive
    # Commands to run in interactive sessions can go here
end

function fish_prompt
    echo -n (prompt_pwd) "❱ " # ➜ ➤ ➦ ➥ ➔ ❯ ❱ ➭ ➙ ➽ ➼ 
end

set -U fish_greeting ""

# Говорит терминалу установить курсор в виде блока
echo -ne "\e[2 q"

