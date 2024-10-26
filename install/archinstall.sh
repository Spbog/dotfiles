#!/usr/bin/bash
# начальная установка говна
echo "Installing git and base-devel"
echo "Pacman logs:" >> dot-install.log
echo "-----------------" >> dot-install.log
sleep 0.5
sudo pacman -Syy --needed base-devel git >> dot-install.log
# проверка yay. если не установлен то ставитца автоматически хуй хуй пизда
if ! yay --version &> /dev/null; then
	read -p "yay is not installed! Would you like to install it? (Y/n) " yayinstall
	case "$yayinstall" in
		[Yy]*|"")
            	git clone https://aur.archlinux.org/yay.git
		cd yay/
		makepkg -si
		;;
        	[Nn]*)
		echo "Installation is canceled"
		exit 1
		;;
		*)
		echo "Incorrect input $yayinstall"
		exit 2
		;;
	esac
fi

echo "Welcome to the dotfiles spbog installer"
read -p "Вы хотите начать установку? (Y/n) " proceed

case "$proceed" in
    [Yy]*|"")
	# ищем rofi и если он есть, то удаляем
	output=$(yay -Q rofi)
	# ищем пакет rofi но если wayland-версия то она будет игнорится
	if [[ $output =~ rofi ]] && ! [[ $output =~ rofi-wayland ]]; then
	    yay -R --noconfirm rofi &> /dev/null
	fi
	# у рофи есть вейленд-версия, но свейнк просто будет конфликтовать
	# с mako, поэтому нужно удалить
	yay -R --noconfirm swaync &> /dev/null

	echo "Installing required packages..."
	echo "Yay logs:" >> dot-install.log
	echo "-------------" >> dot-install.log
	sleep 0.5
	# установка пакетов для дотов
	sudo pacman -R --noconfirm pulseaudio
	yay -S --noconfirm hyprland rofi-wayland waybar hyprlock walogram-git pywal python3 python-pip python-pywalfox swww grim slurp mako emacs nautilus pipewire pipewire-pulse wireplumber pavucontrol helvum alacritty zoxide thefuck oh-my-posh wl-clipboard noto-fonts-emoji brightnessctl fastfetch playerctl >> ~/dot-install.log
		if ! yay -Qq hyprland rofi-wayland waybar hyprlock walogram-git pywal python3 python-pip python-pywalfox swww grim slurp mako emacs nautilus alacritty zoxide thefuck oh-my-posh wl-clipboard noto-fonts-emoji pipewire-pulse brightnessctl playerctl &> /dev/null; then
		echo "While installing the packages, some error occurred. Check the logs, and if you can't figure1 it out yourself: open an issue on github. The logs can be found at dot-install.log."
		echo "Logs: "
		cat dot-install.log
		exit 1
	fi
	yay -S --noconfirm fish fisher-git >> dot-install.log
	chsh -s /usr/bin/fish >> dot-install.log

	fish_installed=$(pacman -Q fish)

	if [[ -z "$fish_installed" ]]; then
	    echo "Fish is not installed, please install it manually!"
	    exit 1
	fi
	;;
	[Nn]*)
		echo "Installation canceled."
		exit 1
	;;
	*)
		echo "Unknown input $proceed"
		exit 2
	;;
esac

