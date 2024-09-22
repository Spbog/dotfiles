#!/bin/bash

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


 
