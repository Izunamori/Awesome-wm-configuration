#!/bin/bash

# Убиваем процесс Discord
killall Discord 2>/dev/null

# Удаляем старую версию
rm -rf ~/Documents/Apps/Discord

# Создаем директории (если они еще не существуют)
mkdir -p ~/Documents/Apps

# Скачиваем Discord
wget "https://discord.com/api/download?platform=linux&format=tar.gz" -O ~/discord.tar.gz

# Распаковываем в нужную директорию
tar -xzvf ~/discord.tar.gz -C ~/Documents/Apps/

# Удаляем архив
rm ~/discord.tar.gz

# Запускаем Discord
nohup ~/Documents/Apps/Discord/Discord > /dev/null 2>&1 &