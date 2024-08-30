#!/bin/bash

if [[ $EUID -eq 0 ]]; then
    echo "Запустите скрипт от имени обычного пользователя!"
    exit
fi

clear

if yay -Q &> /dev/null; then
    echo ""
else
    read -p "Yay не установлен! вы хотите установить его? (y/N) " yays
    if [ "$yays" != "y" ]; then
	echo "pkill install.sh"
    else
	git clone https://aur.archlinux.org/yay.git
	cd yay/
	makepkg -si
    fi
fi


echo "Добро пожаловать в установщик дотфайлов сапога!"
echo
echo "Вы уверены что у вас установлен base-devel, и система is up-to-date?"
echo

read -p "Вы хотите начать установку? (y/N)" proceed
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
	echo ""
    fi
    echo "Установка зависимостей..."
    sleep 1.5
    yay -S hyprland rofi-wayland waybar hyprlock walogram-git pywal python3 python-pip python-pywalfox swww grim grimblast-git pulseaudio-ctl --noconfirm > yay.log

    clear
    
    if yay -Qq hyprlock &> hyprlock; then
	echo "Установка завершена."
    else
	clear
	echo "Не все пакеты были установлены. Чекни yay.log и фиксь почему не установилось. Можешь открыть issue с логами"
	exit
    fi

    echo "Установка colorz для pywal"
    pip3 install colorz --user --break-system-packages
    echo "colorz установлен"

    sleep 2

    clear

    echo "Установка дотфайлов"
    chmod +rwx .
    cp -r config/* ~/.config
    cp -r ~fonts/* ~/.fonts
    cp -r dotfiles/Wallpapers/* ~/Wallpapers
    sleep 1

    echo "Дотфайлы установлены. Создаю симлинки на файлы."

    sleep 2
    
    wal -i ~/Wallpapers/Leaves.jpg --saturate 0.2 --backend colorz
    ln -sf ~/.cache/wal/colors-waybar.css ~/.config/waybar/colors-waybar.css
    ln -sf ~/.cache/wal/hyprlock.conf ~/.config/hypr/hyprlock.conf
    ln -sf ~/.cache/wal/mako-config ~/.config/mako/config

    clear

    echo "Установка завершена! Приятного пользования моими дотфайлами:)"
    echo "В случае выяснений проблем, пожалуйста, оставьте issue в гитхабе"
    echo "https://github.com/Spbog/dotfiles"
    rm -rf ~/dotfiles #delete useless files after installation in most cases
fi
