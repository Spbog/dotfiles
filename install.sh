#!/bin/bash
# защита от ебланов
if [[ $EUID -eq 0 ]]; then
	echo "Run the script not as root"
	exit 1
fi
# удаляем предыдущие логе
[[ -f ~/dot-install.log ]] && rm -f ~/dot-install.log
# проверка существования файла
if [ -r /etc/os-release ]; then
  # Читаем содержимое файла и ищем подстроки
  if grep -iq 'Arch\|arch' /etc/os-release; then
    # если наш дистр это арч то выполняем скрипт на инсталл пакетов для арча
    bash ~/dotfiles/scripts/arch.sh
  elif grep -iq 'Void\|void' /etc/os-release; then
    # если наш дистр это воид выполняем скрипт на инсталл пакетов для воида
    bash ~/dotfiles/scripts/void.sh
  else
    echo "Our script does not support your distro yet"
  fi
else
  echo "No access rights or the /etc/os-release file could not be found."
fi

bash ~/dotfiles/scripts/conf.sh

	echo "Installation is complete! Enjoy using my dotfiles:)"
	echo "Please do a reboot"
	echo "In case of clarifying issues, please leave an issue in the github"
	echo "https://github.com/Spbog/dotfiles"

	read -p "Want to delete the git with dotfiles to free up space'? (y/n): " confirm
	    if [ "$confirm" = "y" ]; then
		rm -rf "~/dotfiles"
		echo "The dotfiles directory has been deleted."
	    else
		echo "Ok, Ill keep it."
            fi
	    # ТЕПЕРЬ ДОРОГОЙ МОЙ ЮЗЕР МОЖЕШЬ ПОЙТИ И УБИТСЯ НАХУЙ НЕХУЙ В МОИХ ФАЙЛАХ КАПАЦА УЕБАН БЛЯТЬ ТУПОЙ


 
