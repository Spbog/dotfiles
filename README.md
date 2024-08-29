# Дотфайлы сапога
__Реворк моих старых дотфайлов__

## Что для чего?
| Для чего    | Что используется |
| ----------- | ----------- |
| WM          | Hyprland   |
| OS          | Arch linux  |
| Terminal    | Alacritty   |
| Launcher    | Rofi       |
| Bar         | Waybar     |
| Theme picker | Pywal     |
|Notifications | Mako     | 

## Установка
Скопируйте дотфайлы командой
```
git clone https://github.com/Spbog/dotfiles.git
```
И запустите скрипт внутри командой
```
sh install.sh
```

## Ручная установка
Убедитесь, что у вас имеется yay.
Копируете дотфайлы
```
git clone https://github.com/Spbog/dotfiles.git
```
Потом установите все нужные пакеты
```
yay -S hyprland rofi-wayland waybar hyprlock walogram-git pywal python3 python-pip python-pywalfox --noconfirm

pip3 install colorz --user --break-system-packages
```
Переместите файлы из config/ в ~/.config/, а fonts/ в ~/.fonts/. 
Создайте папку ~/Wallpapers и скиньте туда свои обои.
Создайте тему из обоев командой
```
wal -i ~/Wallpapers/file --saturate 0.2 --backend colorz
```
После сделайте ссылки на файлы из cache в config командами
```
ln ~/.cache/wal/colors-waybar.css ~/.config/waybar/colors-waybar.css
ln ~/.cache/wal/hyprlock.conf ~/.config/hypr/hyprlock.conf
ln ~/.cache/wal/mako-config ~/.config/mako/config
```
