#!/bin/bash

# Проверяем, запущен ли picom
if pgrep -x "picom" > /dev/null
then
    # Останавливаем picom
    pkill picom
    notify-send "Picom" "Compositor остановлен" -t 2000
else
    # Пытаемся запустить picom
    # Можно указать конкретный конфиг, если нужно: picom --config ~/.config/picom.conf
    if picom --daemon --config ~/.config/awesome/.config/picom.conf 2>/dev/null; then
        notify-send "Picom" "Compositor запущен" -t 2000
    else
        notify-send "Picom" "Ошибка запуска compositor!" -u critical -t 3000
    fi
fi
