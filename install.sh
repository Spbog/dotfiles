#!/usr/bin/bash

if [[ $EUID -eq 0 ]]; then
	echo "Run the script not as root"
	exit 1
fi

[[ -f ~/dot-install.log ]] && rm -f ~/dot-install.log

if [ -r /etc/os-release ]; then
  if grep -iq 'Arch\|arch' /etc/os-release; then
    ./install/archinstall.sh
  elif grep -iq 'Void\|void' /etc/os-release; then
    ./install/voidinstall.sh
  else
    echo "Our script does not support your distro yet"
  fi
else
  echo "No access rights or the /etc/os-release file could not be found."
fi

echo "Stage 2 dots install..."
./install/stage2install.sh

echo "Installation is complete! Enjoy using my dotfiles:)"
echo ""
echo "In case of clarifying issues, please leave an issue in the github"
echo "https://github.com/Spbog/dotfiles"

read -p "Do you want to delete the git repo with dotfiles to free up space'? (y/N): " confirm
case "$confirm" in
  [Yy]*)
    rm -rf "../dotfiles"
    echo "The dotfiles directory has been deleted."
    exit 0
    ;;
  *)
    echo "Ok, Ill keep it."
    exit 0
esac

