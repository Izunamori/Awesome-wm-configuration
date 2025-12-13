# maim -s | tee ~/Pictures/Screenshots/Screenshot-$(date "+%d_%m_%Y_%H:%M_%S").png && xclip -selection clipboard -t image/png

FILE=~/Pictures/Screenshots/Screenshot-$(date "+%d_%m_%Y_%H:%M_%S").png
maim -s > "$FILE" && xclip -selection clipboard -t image/png < "$FILE"