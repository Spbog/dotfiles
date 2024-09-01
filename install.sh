#!/usr/bin/bash
if [[ $EUID -eq 0 ]]; then
	echo "Запустите скрипт от имени обычного пользователя!"
	exit 1
fi
echo "Pacman logs:" >> ~/spbog-dotfiles-install.log
echo "-----------------" >> ~/spbog-dotfiles-install.log
sudo pacman -S --needed base-devel git >> ~/spbog-dotfiles-install.log
if yay --version &> /dev/null; then
	cat /dev/null
else
	read -p "Yay не установлен! вы хотите установить его? (Y/n) " yayinstall
	if [[ "$yayinstall" == "y" || "$yayinstall" == "Y" || "$yayinstall" == "" ]]; then
        	git clone https://aur.archlinux.org/yay.git
        	cd yay/
        	makepkg -si
	elif [[ "$yayinstall" == "n" || "$yayinstall" == "N" ]]; then
		echo "Установка отменена!"
		exit 1
	else
        	echo "Неверный ввод $yayinstall"
		exit 2
    fi
fi

echo "Добро пожаловать в установщик дотфайлов сапога!"

read -p "Вы хотите начать установку? (Y/n)" proceed

if [[ "$proceed" == "y" || "$proceed" == "Y" || "$proceed" == "" ]]; then
	yay -R --noconfirm rofi swaync
	if yay -Q swaync &> /dev/null; then
		echo "Swaync всё ещё присутсвует в системе, пожалуйста удалите его. Возможно он собран вручную"
		exit 1
	fi
	if yay -Q rofi &> /dev/null; then
	       	echo "rofi (x11) всё ещё присутсвует в системе, пожалуйста удалите его. Возможно он собран вручную"
	       	exit 1
	fi
	echo "Установка зависимостей и обновление системы..."
	echo "Yay logs:" >> ~/spbog-dotfiles-install.log
	echo "-------------"
	sleep 0.5
	yay -Syyu --verbose --noconfirm  hyprland rofi-wayland waybar hyprlock walogram-git pywal python3 python-pip python-pywalfox swww grim slurp pipewire wireplumber mako emacs nautilus alacritty >> ~/spbog-dotfiles-install.log
	if yay -Qq hyprlock &> hyprlock; then #Need to change
		echo "Установка завершена."
	else
		echo "Во время установки пакетов произошла какая-то ошибка, проверь логи (yay.log) и открой issue https://github.com/Spbog/dotfiles"
 		echo "Логи :"
 	cat ~/spbog-dotfiles-install.log
	exit 1
fi
echo "Установка colorz для pywal..."
echo "colorz pip3 logs:" >> ~/spbog-dotfiles-install.log
echo "---------------------" >> ~/spbog-dotfiles-install.log
pip3 install colorz --user --break-system-packages >> ~/spbog-dotfiles-install.log
echo "Установка дотфайлов..."
cp avatar.jpg ~/avatar.jpg
mkdir -p ~/.config ~/.fonts ~/Wallpapers
cp -r config/* ~/.config
cp -r fonts/* ~/.fonts
cp -r Wallpapers/* ~/Wallpapers
echo "Дотфайлы установлены. Создаю симлинки на файлы..."
wal -i ~/Wallpapers/Leaves.jpg --saturate 0.2 --backend colorz
ln -sf ~/.cache/wal/colors-waybar.css ~/.config/waybar/colors-waybar.css
ln -sf ~/.cache/wal/hyprlock.conf ~/.config/hypr/hyprlock.conf
ln -sf ~/.cache/wal/mako-config ~/.config/mako/config
echo "Установка завершена! Приятного пользования моими дотфайлами:)"
echo "В случае выяснений проблем, пожалуйста, оставьте issue в гитхабе"
echo "https://github.com/Spbog/dotfiles"
#cd .. && rm -rf dotfiles/ #delete useless files after installation
