#!/bin/bash

# Название процесса (измените при необходимости)
PROCESS_NAME="Throne"

# Поиск PID процесса
PID=$(pgrep -f "$PROCESS_NAME")

if [ -z "$PID" ]; then
    echo "Процесс $PROCESS_NAME не найден. Запускаю..."
    # Замените путь на реальный путь к исполняемому файлу
    Throne &
    echo "Процесс $PROCESS_NAME запущен с PID $!"
else
    echo "Процесс $PROCESS_NAME найден с PID $PID. Останавливаю..."
    kill -9 $PID
    echo "Процесс $PROCESS_NAME остановлен"
fi