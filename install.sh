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
    echo "Наш скрипт пока не поддерживает ваш дистрибутив"
  fi
else
  echo "Нет прав доступа или файл /etc/os-release не найден."
fi




 
