#!/bin/bash

if [ "$USER" == root ]; then
	echo "[USER check] = Failed"
	echo "Error -- this script cannot be executed with sudo. Try ./ instead."
	echo "Exiting..."
	exit
else
	echo "[USER check] = $USER"
fi


YOUR_OS="$(cat /etc/issue | awk {'print $1'})"
if [ "$YOUR_OS" == Ubuntu ]; then
	echo "[OS check] = Ubuntu"
	echo "Starting the script..."
	sudo apt update

elif [ "$YOUR_OS" == elementary ]; then
	echo "[OS check] = Elementary"
	echo "Starting the script..."
	sudo apt update
else
	echo "[OS check] = Failed"
	echo "Error -- this script is designed for Ubuntu and Elementary only."
	echo "Exiting..."
	exit
fi


sudo apt install python-wxtools python-pip python3-tk youtube-dl -y -f
pip install twodict
wget "https://pypi.python.org/packages/55/28/70620c1ffb8ad7ecb81913a053dc454ad7116d3fbdbd8ca23ac0b19ebb40/Youtube-DLG-0.4.tar.gz"
tar -xzf Youtube-DLG-0.4.tar.gz
sudo rm Youtube-DLG-0.4.tar.gz
cd Youtube-DLG-0.4
sudo python setup.py install
cd ..
sudo rm -r Youtube-DLG-0.4
cd /home/"$USER"/.config/
sudo chmod 777 youtube-dlg/
cd youtube-dlg
sudo chmod 777 *
cd /home/"$USER"/Downloads/
sudo cat > /home/"$USER"/Downloads/youtube-dl-gui.desktop << EOL
[Desktop Entry]
Name=Youtube-DL-GUI
Exec=youtube-dl-gui
Terminal=false
Type=Application
Icon=multimedia-video-player
Categories=GTK;Utility;
EOL
sudo mv /home/"$USER"/Downloads/youtube-dl-gui.desktop /usr/share/applications/youtube-dl-gui.desktop

echo "Done."
