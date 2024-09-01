#!/bin/bash
echo "GitHub разработчика: https://github.com/Spbog/dotfiles"
if [[ $EUID -eq 0 ]]; then
    echo "Запустите скрипт от имени обычного пользователя!"
    exit
fi

clear

if yay -Q &> /dev/null; then
    echo "yay OK!"
else
    read -p "Yay не установлен! вы хотите установить его? (y/N) " yays
    if [ "$yays" != "y" ]; then
	echo "Установка отменена."
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
	echo "Swaync присутсвует в системе, пожалуйста удалите его. Возможно он собран вручную"
	exit
    else
	echo "-swaync OK!"
    fi
    echo "Установка зависимостей..."
    sleep 1.5
    yay -S hyprland rofi-wayland waybar hyprlock walogram-git pywal python3 python-pip python-pywalfox swww grim slurp pipewire wireplumber mako emacs nautilus alacritty --noconfirm > yay.log

    clear
    
    if yay -Qq hyprlock &> hyprlock; then
	echo "Установка завершена."
    else
	clear
	echo "Во время установки пакетов произошла какая-то ошибка, проверь логи (yay.log) и открой issue https://github.com/Spbog/dotfiles"
 	echo "Логи yay:"
 	cat yay.log
	exit
    fi

    echo "Установка colorz для pywal.."
    pip3 install colorz --user --break-system-packages
    echo "colorz OK!"

    sleep 2

    clear

    echo "Установка дотфайлов..."
    cp avatar.jpg ~/avatar.jpg
    mkdir ~/.config
    cp -r config/* ~/.config
    mkdir ~/.fonts
    cp -r fonts/* ~/.fonts
    mkdir ~/Wallpapers
    cp -r Wallpapers/* ~/Wallpapers
    sleep 1

    echo "Дотфайлы установлены. Создаю симлинки на файлы..."

    sleep 2
    
    wal -i ~/Wallpapers/Leaves.jpg --saturate 0.2 --backend colorz
    ln -sf ~/.cache/wal/colors-waybar.css ~/.config/waybar/colors-waybar.css
    ln -sf ~/.cache/wal/hyprlock.conf ~/.config/hypr/hyprlock.conf
    ln -sf ~/.cache/wal/mako-config ~/.config/mako/config

    clear

    echo "Установка завершена! Приятного пользования моими дотфайлами:)"
    echo "В случае выяснений проблем, пожалуйста, оставьте issue в гитхабе"
    echo "https://github.com/Spbog/dotfiles"
    echo ""
    echo "Не забудьте удалить этот репозиторий"
    rm -rf ~/dotfiles #delete useless files after installation in most cases
fi
