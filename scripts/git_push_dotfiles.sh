#!/bin/sh

cd ~/.config/awesome/
git add -A && git commit -m "update configuration"
git push -f origin main