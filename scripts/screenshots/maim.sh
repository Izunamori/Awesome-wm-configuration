# maim -s | tee ~/Pictures/Screenshots/Screenshot-$(date "+%d_%m_%Y_%H:%M_%S").png && xclip -selection clipboard -t image/png

#FILE=~/Pictures/Screenshots/Screenshot-$(date "+%d_%m_%Y_%H:%M_%S").png
#maim -s > "$FILE" && xclip -selection clipboard -t image/png < "$FILE"

#!/bin/bash

#!/bin/bash

SCREENSHOT_DIR=~/Pictures/Screenshots
mkdir -p "$SCREENSHOT_DIR"

TEMP_FILE=$(mktemp -p /tmp screenshot_XXXXXX.png)
FINAL_FILE="$SCREENSHOT_DIR/Screenshot-$(date "+%d_%m_%Y_%H:%M_%S").png"

pkill picom

# Делаем скриншот с обработкой ошибок
if maim --hidecursor -s "$TEMP_FILE" 2>/dev/null; then
    # Перемещаем временный файл в финальное расположение
    mv "$TEMP_FILE" "$FINAL_FILE"
    
    # Копируем в буфер обмена
    xclip -selection clipboard -t image/png < "$FINAL_FILE"
    
    # Уведомление (если установлен libnotify)
    command -v notify-send >/dev/null 2>&1 && \
        notify-send "Screenshot saved" "File: $(basename "$FINAL_FILE")"
    
    echo "Скриншот сохранен: $FINAL_FILE"
else
    # Если скриншот не сделан (Escape), удаляем временный файл
    rm -f "$TEMP_FILE"
fi

picom --daemon --config ~/.config/awesome/.config/picom.conf