#!/bin/sh

cd ~/.config/awesome/
git add -A && git commit -m "update configuration" >> git_log.txt
git push -f origin main >> git_log.txt

echo "-------------------------------------" >> git_log.txt