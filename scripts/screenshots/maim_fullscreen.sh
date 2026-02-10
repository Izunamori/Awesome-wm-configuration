# maim -s | tee ~/Pictures/Screenshots/Screenshot-$(date "+%d_%m_%Y_%H:%M_%S").png && xclip -selection clipboard -t image/png

# FILE=~/Pictures/Screenshots/Screenshot-$(date "+%d_%m_%Y_%H:%M_%S").png
# maim -u > "$FILE" && xclip -selection clipboard -t image/png < "$FILE"

SCREENSHOT_DIR=~/Pictures/Screenshots
mkdir -p "$SCREENSHOT_DIR"

MONITOR_NAME="DP-2"

# Получаем геометрию монитора автоматически
MONITOR_GEOMETRY=$(xrandr | grep "^$MONITOR_NAME connected" | sed -E 's/.* ([0-9]+x[0-9]+\+[0-9]+\+[0-9]+).*/\1/')

if [ -z "$MONITOR_GEOMETRY" ]; then
    echo "Не удалось определить геометрию монитора $MONITOR_NAME"
    exit 1
fi

TEMP_FILE=$(mktemp -p /tmp screenshot_XXXXXX.png)
FINAL_FILE="$SCREENSHOT_DIR/Screenshot-$(date "+%d_%m_%Y_%H:%M_%S").png"

if maim --hidecursor -g "$MONITOR_GEOMETRY" "$TEMP_FILE" 2>/dev/null; then
    mv "$TEMP_FILE" "$FINAL_FILE"
    xclip -selection clipboard -t image/png < "$FINAL_FILE"
    command -v notify-send >/dev/null 2>&1 && \
        notify-send "Screenshot saved" "File: $(basename "$FINAL_FILE")"
    echo "Скриншот сохранен: $FINAL_FILE"
else
    rm -f "$TEMP_FILE"
    echo "Скриншот не сделан."
fi
