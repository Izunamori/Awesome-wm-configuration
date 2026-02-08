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
alias ter="~/Documents/Terraria_serv/1454/Linux/TerrariaServer"
alias gp="git add * && git commit -m "None" && git push origin main"

# zerotier
alias zj="sudo zerotier-cli join"
alias zl="sudo zerotier-cli leave"

#########################

if status is-login
    if test -z "$DISPLAY"
        if test (tty) = "/dev/tty1"
            exec startx
        end
    end
end

#########################

