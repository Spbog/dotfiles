# Дотфайлы сапога
__Реворк моих старых дотфайлов__

[Скрин 1](https://github.com/Spbog/dotfiles/blob/main/screen1.jpg)

[Скрин 2](https://github.com/Spbog/dotfiles/blob/main/screen2.jpg)

[Скрин 3](https://github.com/Spbog/dotfiles/blob/main/screen3.jpg)
## Что используется
| Для чего      | Что используется |
| ------------- | ---------------- |
| WM            | Hyprland         |
| OS            | Arch Linux       |
| Terminal      | Alacritty        |
| Launcher      | Rofi             |
| Bar           | Waybar           |
| Theme picker  | Pywal            |
| Notifications | Mako             | 

## Установка
### Все действия выполняются от имени обычного пользователя
Скопируйте дотфайлы:
```
git clone https://github.com/Spbog/dotfiles.git
```
Запустите скрипт внутри командой:
```
sh install.sh
```

## Ручная установка
**Убедитесь**, что у вас имеется _**yay**_.
Скопируйте дотфайлы:
```
git clone https://github.com/Spbog/dotfiles.git
```
Установите зависимости:
```
yay -S hyprland rofi-wayland waybar hyprlock walogram-git pywal python3 python-pip python-pywalfox swww grim slurp pulseaudio-ctl --noconfirm

pip3 install colorz --user --break-system-packages
```
Измените разрешения файлов во избежании ошибок доступа к файлам:
```
chmod --recursive +rwx dotfiles/* 
```
Измените и скопируйте аватар профиля avatar.jpg
```
cp avatar.jpg ~/avatar.jpg
```
Переместите файлы из config/ в _~/.config/_, а fonts/ в _~/.fonts/_. 
```
cd dotfiles && cp -r config ~/.config && cp -r fonts ~/.fonts
```
Скопируйте папку с обоями _"Wallpapers"_ в _~/Wallpapers_. Скопируйте туда любые обои.
```
cp -r Wallpapers ~/Wallpapers
```
Создайте тему из обоев:
```
wal -i ~/Wallpapers/file --saturate 0.2 --backend colorz
```
После сделайте симлинки на файлы из _.cache_ в _.config_:
```
ln -sf ~/.cache/wal/colors-waybar.css ~/.config/waybar/colors-waybar.css
ln -sf ~/.cache/wal/hyprlock.conf ~/.config/hypr/hyprlock.conf
ln -sf ~/.cache/wal/mako-config ~/.config/mako/config
```
Удалите репозиторий для освобождения места
```
cd .. && rm -rf dotfiles/
```
## Хоткеи
| Хоткей                        | Что делает  |
| ----------------------------- | ----------- | 
| <kbd>Win</kbd> + <kbd>W</kbd> | Выбор обоев |
| <kbd>Win</kbd> + <kbd>D</kbd> | Rofi        |
| <kbd>Win</kbd> + <kbd>X</kbd> | Kill        |
| <kbd>Win</kbd> + <kbd>R</kbd> | Emacs       |
| <kbd>Win</kbd> + <kbd>E</kbd> | Nautilus    |
| <kbd>Win</kbd> + <kbd>Q</kbd> | Alacritty   |
| <kbd>Win</kbd> + <kbd>L</kbd> | Hyprlock    |

