#!/bin/sh

cd ~/.config/awesome/
git add -A && git commit -m "update configuration" >> gitlog.txt
git push -f origin main >> gitlog.txt