# maim -s | tee ~/Pictures/Screenshots/Screenshot-$(date "+%d_%m_%Y_%H:%M_%S").png && xclip -selection clipboard -t image/png

#FILE=~/Pictures/Screenshots/Screenshot-$(date "+%d_%m_%Y_%H:%M_%S").png
#maim -s > "$FILE" && xclip -selection clipboard -t image/png < "$FILE"

#!/bin/bash

#!/bin/bash

#!/usr/bin/env bash

SCREENSHOT_DIR=~/Pictures/Screenshots
mkdir -p "$SCREENSHOT_DIR"

TEMP_FILE=$(mktemp -p /tmp screenshot_XXXXXX.png)
FINAL_FILE="$SCREENSHOT_DIR/Screenshot-$(date "+%d_%m_%Y_%H:%M_%S").png"

pkill picom

# Захват области с помощью maim
if maim --hidecursor -s "$TEMP_FILE" 2>/dev/null; then
    # Открываем Satty для аннотаций с авто-сохранением
    satty \
        --filename "$TEMP_FILE" \
        --output-filename "$TEMP_FILE" \
        --actions-on-enter save-to-file,save-to-clipboard \
        --early-exit \
        --actions-on-escape exit \
        --disable-notifications \

    # Перемещаем в финальную директорию
    mv "$TEMP_FILE" "$FINAL_FILE"
    
    # Копируем в буфер обмена (на всякий случай)
    xclip -selection clipboard -t image/png < "$FINAL_FILE"
    
    # Уведомление
    command -v notify-send >/dev/null 2>&1 && \
        sleep 0.3
        notify-send "Screenshot saved" "File: $(basename "$FINAL_FILE")"
    
    echo "Скриншот сохранен: $FINAL_FILE"
else
    # Если скриншот не сделан (Escape), удаляем временный файл
    rm -f "$TEMP_FILE"
fi

# Запускаем picom
picom --daemon --config ~/.config/awesome/.config/picom.conf

