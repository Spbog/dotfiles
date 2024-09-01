#!/usr/bin/env bash
rofi_command="rofi -theme ~/.config/rofi/themes/poweroff.rasi"
uptime=$(uptime -p | sed -e 's/up //g')
# Options
shutdown=""
reboot=""
lock=""
suspend=""
logout=""
options="$shutdown\n$reboot\n$lock\n$suspend\n$logout"
chosen="$(echo -e "$options" | $rofi_command -p "Uptime - $uptime" -dmenu -selected-row 2)"
case $chosen in
    $shutdown)
	systemctl poweroff
	#doas openrc-shutdown -p
        ;;
    $reboot)
	systemctl reboot
	#doas reboot
        ;;
    $lock)
        hyprlock
        ;;
    $suspend)
	systemctl suspend
	#doas openrc-shutdown -H
	hyprlock
        ;;
    $logout)
	hyprctl dispatch exit
        ;;
esac
