# maim -s | tee ~/Pictures/Screenshots/Screenshot-$(date "+%d_%m_%Y_%H:%M_%S").png && xclip -selection clipboard -t image/png

# FILE=~/Pictures/Screenshots/Screenshot-$(date "+%d_%m_%Y_%H:%M_%S").png
# maim -u > "$FILE" && xclip -selection clipboard -t image/png < "$FILE"

#!/usr/bin/env bash

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

# Захват всего монитора с помощью maim
if maim --hidecursor -g "$MONITOR_GEOMETRY" "$TEMP_FILE" 2>/dev/null; then
    # Открываем Satty для аннотаций с автосохранением
    satty \
        --filename "$TEMP_FILE" \
        --output-filename "$TEMP_FILE" \
        --actions-on-enter save-to-file,save-to-clipboard \
        --early-exit \
        --actions-on-escape exit \
        --disable-notifications \

    # Перемещаем в финальную директорию
    mv "$TEMP_FILE" "$FINAL_FILE"
    
    # Копируем в буфер обмена
    xclip -selection clipboard -t image/png < "$FINAL_FILE"
    
    # Уведомление
    command -v notify-send >/dev/null 2>&1 && \
        sleep 0.3
        notify-send "Screenshot saved" "File: $(basename "$FINAL_FILE")"
    
    echo "Скриншот сохранен: $FINAL_FILE"
else
    rm -f "$TEMP_FILE"
    echo "Скриншот не сделан."
fi

