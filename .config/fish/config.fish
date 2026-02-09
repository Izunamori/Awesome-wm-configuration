if status is-interactive
    # Commands to run in interactive sessions can go here
end

function fish_prompt
    echo -n (prompt_pwd) "> " # ➜ ➤ ➦ ➥ ➔ ❯ ❱ ➭ ➙ ➽ ➼ 
end

set -U fish_greeting ""

# Говорит терминалу установить курсор в виде блока
printf "\e[4 q"

# /home/izunamori/.config/awesome/scripts/functional/installed-days-ago-fetch.sh
echo ""
fastfetch

export PATH="$HOME/.local/bin:$PATH"

#### Aliases ####

# default commands
alias s="yay -q"
alias p="sudo pacman"
alias ls="lsd"
alias pizdec="archarchive"

# git
alias gp="git add * && git commit -m "None" && git push origin main"

# dedicated servers
alias ter="~/Documents/Servers/Terraria/1454/Linux/TerrariaServer"
alias fac="/home/izunamori/Documents/Servers/Factorio/bin/x64/factorio --start-server"

# zerotier
alias zj="sudo zerotier-cli join"
alias zl="sudo zerotier-cli leave"

# zellij
alias zel="zellij a; or zellij"

#################

#########################
###### Autostartx #######
#########################
if status is-login
    if test -z "$DISPLAY"
        if test (tty) = "/dev/tty1"
            exec startx
        end
    end
end
#########################

starship init fish | source