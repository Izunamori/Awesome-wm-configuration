#!/bin/bash

# Убиваем процесс Discord
killall Discord 2>/dev/null

# Удаляем старую версию
rm -rf ~/Apps/Discord

# Создаем директории (если они еще не существуют)
mkdir -p ~/Apps

# Скачиваем Discord
wget "https://discord.com/api/download?platform=linux&format=tar.gz" -O ~/discord.tar.gz

# Распаковываем в нужную директорию
tar -xzvf ~/discord.tar.gz -C ~/Apps/

# Удаляем архив
rm ~/discord.tar.gz

# Запускаем Discord
~/Apps/Discord/Discord > /dev/null 2>&1 &