#!/bin/bash
# Скрипт интерполяции видео до 60fps с наложением кадров

for video in "$@"; do
    if [ -f "$video" ]; then
        # Получаем имя файла без расширения
        filename=$(basename -- "$video")
        extension="${filename##*.}"
        filename="${filename%.*}"
        
        # Создаем новое имя файла
        output="${filename}_60fps.mp4"
        
        # Запускаем ffmpeg с прогресс-баром
        notify-send "Начинаю обработку" "Файл: $filename.$extension"
        
        ffmpeg -i "$video" \
               -vf "tblend=average,fps=60" \
               -c:v libx264 -crf 23 \
               -preset fast \
               -c:a aac -b:a 128k \
               "$output" 2>&1 | \
               zenity --progress \
                      --title="Обработка видео" \
                      --text="Интерполяция до 60fps..." \
                      --percentage=0 \
                      --auto-close \
                      --auto-kill
        
        notify-send "Обработка завершена" "Создан файл: $output"
    fi
done