#!/bin/bash

if [[ $EUID -eq 0 ]]; then
    echo "Скрипт запущен под рут! Выхожу..."
    exit
fi

clear

if yay -Q &> /dev/null; then
    echo "yay уже установлен."
else
    read -p "Yay не установлен! вы хотите установить его? (y/n) " yays
    if [ "$yays" != "y" ]; then
	echo "Установка yay отменена. Следовательно, я не могу"
	echo "продолжить установку дотфайлов."
    else
	git clone https://aur.archlinux.org/yay.git
	cd yay/
	makepkg -si
    fi
fi


echo "Добро пожаловать в установщик дотфайлов спбога!"
echo
echo "Перед установкой следует убедиться, что base-devel установлен,"
echo "а сама система обновлена."
echo

read -p "Вы хотите начать установку? (y/n)" proceed
echo

if [ "$proceed" != "y" ]; then
    echo "Установка отменена."
    exit
else
    yay -R rofi --noconfirm
    yay -R swaync --noconfirm
    if yay -Q swaync &> /dev/null; then
	echo "Swaync не удален, либо собран вручную. Пожалуйста, удалите его"
	exit
    else
	echo "swaync нету."
    fi
    
    echo "Установка основных пакетов..."
    sleep 1.5
    yay -S hyprland rofi-wayland waybar hyprlock walogram-git pywal python3 python-pip python-pywalfox swww grim grimblast-git --noconfirm

    clear
    
    if yay -Qq hyprlock &> hyprlock; then
	echo "Установка завершена."
    else
	clear
	echo "Что-то пошло не так, и пакет не установлен."
	exit
    fi

    echo "Установка colorz для pywal"
    pip3 install colorz --user --break-system-packages
    echo "colorz установлен"

    sleep 2

    clear

    echo "Установка самих дотфайлов"
    cp -r ~/dotfiles/config/* ~/.config
    mkdir -p ~/.fonts
    cp -r ~/dotfiles/fonts/* ~/.fonts
    mkdir ~/Wallpapers
    cp -r ~/dotfiles/Wallpapers/* ~/Wallpapers
    chmod +x ~/.config/
    sleep 4
    rm -rf ~/dotfiles

    echo "Дотфайлы установлены. Создаю ссылки на файлы."

    sleep 2
    
    wal -i ~/Wallpapers/Wall.jpg --saturate 0.2 --backend colorz
    ln ~/.cache/wal/colors-waybar.css ~/.config/waybar/colors-waybar.css
    ln ~/.cache/wal/hyprlock.conf ~/.config/hypr/hyprlock.conf
    ln ~/.cache/wal/mako-config ~/.config/mako/config

    clear

    echo "Установка завершена! Приятного пользования моими дотфайлами:)"
    echo "В случае выяснений проблем, пожалуйста, оставьте issue в гитхабе"
    echo "https://github.com/Spbog/dotfiles"
fi
