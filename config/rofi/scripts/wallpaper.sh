#!/bin/bash
export PATH="${PATH}:${HOME}/.local/bin/"
dir="$HOME/.config/rofi/themes"
theme="wallpaper"
wallpapers=$HOME/Wallpapers
image="$(ls $wallpapers | rofi -dmenu -i -p "  Select wallpaper: " -theme ${dir}/${theme}.rasi)"
wallpaper=$wallpapers/$image
if [[ $image == "" ]]; then
    exit 1
fi
if [[ -d $wallpapers/$image ]]; then
    echo "$wallpapers/$image is a directory"
    wallpaper_temp="$image"
    sleep2
    wallpaper_location="$(ls $wallpapers/$image | wofi -n --show dmenu -k "/dev/null")"
elif [[ -f $wallpapers/$image ]]; then
    echo "$wallpapers/$image is a file"
else
    echo "$wallpapers/$image is not valid"
    exit 1
fi
swww img "$wallpaper" --transition-type grow --transition-fps 60 --transition-duration 0.5 --transition-bezier 0.65,0,0.35,1 --transition-step 1
sleep 1.3
wal -i "$wallpaper" --backend colorz --saturate 0.2 -s -t
walogram
pkill waybar && waybar
pkill mako
sleep 0.5
mako
