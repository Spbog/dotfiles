#!/usr/bin/bash

# Check if the script is run as root
if [[ $EUID -eq 0 ]]; then
	echo "Запустите скрипт от имени обычного пользователя!"
	exit 1
fi

# Remove old log file
rm ~/spbog-dotfiles-install.log

# Install necessary components
echo "Установка необходимых компонентов для работы скрипта"
echo "Pacman logs:" >> ~/spbog-dotfiles-install.log
echo "-----------------" >> ~/spbog-dotfiles-install.log
sudo pacman -Syy --needed base-devel git >> ~/spbog-dotfiles-install.log

# Check if yay is installed, if not, prompt to install it
if ! yay --version &> /dev/null; then
	read -p "Yay не установлен! вы хотите установить его? (Y/n) " yayinstall
	case "$yayinstall" in
		[Yy]*|"")
            	git clone https://aur.archlinux.org/yay.git
		cd yay/
		makepkg -si
		;;
        	[Nn]*)
		echo "Установка отменена!"
		exit 1
		;;
		*)
		echo "Неверный ввод $yayinstall"
		exit 2
		;;
	esac
fi

echo "Добро пожаловать в установщик дотфайлов сапога!"
read -p "Вы хотите начать установку? (Y/n) " proceed

case "$proceed" in
	[Yy]*|"")
		# Remove conflicting packages
		yay -R --noconfirm rofi swaync
		if yay -Q swaync &> /dev/null; then
		echo "Swaync всё ещё присутсвует в системе, пожалуйста удалите его. Возможно он собран вручную"
		exit 1
	fi
	if yay -Q rofi &> /dev/null; then
		echo "rofi (x11) всё ещё присутсвует в системе, пожалуйста удалите его. Возможно он собран вручную"
		exit 1
	fi

	# Install dependencies and update system
	echo "Установка зависимостей и обновление системы..."
	echo "Yay logs:" >> ~/spbog-dotfiles-install.log
	echo "-------------" >> ~/spbog-dotfiles-install.log
	sleep 0.5
	yay -Syyu --verbose --noconfirm hyprland rofi-wayland waybar hyprlock walogram-git pywal python3 python-pip python-pywalfox swww grim slurp pipewire wireplumber mako emacs nautilus alacritty zsh zoxide thefuck zsh-lsd oh-my-posh  >> ~/spbog-dotfiles-install.log
	if ! yay -Qq hyprlock &> /dev/null; then
		echo "Во время установки пакетов произошла какая-то ошибка, проверь логи (yay.log) и открой issue https://github.com/Spbog/dotfiles"
		echo "Логи :"
		cat ~/spbog-dotfiles-install.log
		exit 1
	fi

	chsh -s /bin/zsh >> ~/spbog-dotfiles-install.log
	# Configure PipeWire
	echo "Настройка PipeWire"
	echo "PipeWire systemd logs:" >> ~/spbog-dotfiles-install.log
	echo "------------------------" >> ~/spbog-dotfiles-install.log
	systemctl --user enable --now pipewire.socket pipewire-pulse.socket wireplumber.service >> ~/spbog-dotfiles-install.log
	systemctl --user enable --now pipewire.service >> ~/spbog-dotfiles-install.log

	# Install colorz for pywal
	echo "Установка colorz для pywal..."
	echo "colorz pip3 logs:" >> ~/spbog-dotfiles-install.log
	echo "---------------------" >> ~/spbog-dotfiles-install.log
	pip3 install colorz --user --break-system-packages >> ~/spbog-dotfiles-install.log

	# Install dotfiles
	echo "Установка дотфайлов..."
	cp avatar.jpg ~/avatar.jpg
	mkdir -p ~/.config ~/.fonts ~/Wallpapers
	cp -r config/* ~/.config
	cp -r fonts/* ~/.fonts
	cp -r Wallpapers/* ~/Wallpapers
	cp -r config/zsh/.oh-my-zsh ~/.config
	cp config/.zshrc ~/
	cp config/omp.json ~/.config
	echo "Дотфайлы установлены. Создаю симлинки на файлы..."
	wal -i ~/Wallpapers/Leaves.jpg --saturate 0.2 --backend colorz
	ln -sf ~/.cache/wal/colors-waybar.css ~/.config/waybar/colors-waybar.css
	ln -sf ~/.cache/wal/hyprlock.conf ~/.config/hypr/hyprlock.conf
	ln -sf ~/.cache/wal/mako-config ~/.config/mako/config
	echo "Установка завершена! Приятного пользования моими дотфайлами:)"
	echo "Пожалуйста, сделайте reboot"
	echo "В случае выяснений проблем, пожалуйста, оставьте issue в гитхабе"
	echo "https://github.com/Spbog/dotfiles"
	;;
	[Nn]*)
		echo "Установка отменена."
		exit 1
	;;
	*)
		echo "Неизвестный ввод $proceed"
		exit 2
	;;
esac

