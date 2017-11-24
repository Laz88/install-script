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
	sudo apt install ibus-pinyin ibus-sunpinyin -y -f
elif [ "$YOUR_OS" == elementary ]; then
	echo "[OS check] = Elementary"
	echo "Starting the script..."
	# Install script pre-requisites
	sudo apt update
	sudo apt install software-properties-common firefox thunderbird gnome-system-monitor libreoffice -y -f
	sudo apt install fcitx fcitx-googlepinyin fcitx-table-wbpy fcitx-pinyin fcitx-sunpinyin -y -f
	# requires you visit im-config and select the fcitx input as default.
else
	echo "[OS check] = Failed"
	echo "Error -- this script is designed for Ubuntu and Elementary only."
	echo "Exiting..."
	exit
fi

# All software downloads should go to /home/"$USER"/Downloads/
cd /home/"$USER"/Downloads/

# Utilities
sudo apt install p7zip-full -y -f
sudo apt install deluge -y -f

# Communication tools
wget https://go.skype.com/skypeforlinux-64.deb
sudo apt install /home/"$USER"/Downloads/skypeforlinux-64.deb -y -f
sudo rm skypeforlinux-64.deb

sudo apt install mumble -y -f

sudo apt install chromium-browser -y -f

sudo cat > /home/"$USER"/Downloads/web-wechat.desktop << EOL
[Desktop Entry]
Name=WeChat
Exec=chromium-browser https://web.wechat.com/
Terminal=false
Type=Application
Icon=/usr/share/ibus-table/icons/chinese.svg
Categories=GTK;Utility;
EOL
sudo mv /home/"$USER"/Downloads/web-wechat.desktop /usr/share/applications/web-wechat.desktop

# Productivity software: Image media tools
sudo apt install gimp -y -f

sudo apt install krita -y -f

sudo apt install inkscape -y -f

# Productivity software: Video media tools
sudo apt install ffmpeg -y -f

sudo apt install vlc livestreamer -y -f

sudo apt-add-repository ppa:obsproject/obs-studio
sudo apt update
sudo apt install obs-studio -y -f

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

# Productivity software: Programming
sudo apt install git -y -f

sudo apt install geany -y -f

wget https://github.com/atom/atom/releases/download/v1.22.1/atom-amd64.deb
sudo apt install -f -y /home/"$USER"/Downloads/atom-amd64.deb
sudo rm /home/"$USER"/Downloads/atom-amd64.deb

if [ "$YOUR_OS" == Ubuntu ]; then
	wget "http://download.virtualbox.org/virtualbox/5.2.0/virtualbox-5.2_5.2.0-118431~Ubuntu~zesty_amd64.deb"
	sudo chmod 777 virtualbox-5.2_5.2.0-118431~Ubuntu~zesty_amd64.deb
	sudo apt install /home/"$USER"/Downloads/virtualbox-5.2_5.2.0-118431~Ubuntu~zesty_amd64.deb -f
	sudo rm /home/"$USER"/Downloads/virtualbox-5.2_5.2.0-118431~Ubuntu~zesty_amd64.deb
elif [ "$YOUR_OS" == elementary ]; then
	wget "http://download.virtualbox.org/virtualbox/5.2.0/virtualbox-5.2_5.2.0-118431~Ubuntu~xenial_amd64.deb"
	sudo chmod 777 virtualbox-5.2_5.2.0-118431~Ubuntu~xenial_amd64.deb
	sudo apt install /home/"$USER"/Downloads/virtualbox-5.2_5.2.0-118431~Ubuntu~xenial_amd64.deb -f
	sudo rm /home/"$USER"/Downloads/virtualbox-5.2_5.2.0-118431~Ubuntu~xenial_amd64.deb
else
	echo ""
fi

# Videogames
sudo apt install steam -y -f

# GNOME and THEME related
if [ "$YOUR_OS" == Ubuntu ]; then
	wget "https://raw.githubusercontent.com/Laz88/install-script/master/ubuntu-gnome-tweaks.sh"
	chmod +x ubuntu-gnome-tweaks.sh
	./ubuntu-gnome-tweaks.sh

elif [ "$YOUR_OS" == elementary ]; then
	echo "elementary"
else
	echo "else"

fi

# Make Scripts
mkdir /home/"$USER"/.scripts
cd /home/"$USER"/.scripts/
sudo cat > /home/"$USER"/.scripts/144hz-displayport-2.sh << EOL
#!/bin/bash
xrandr --output DisplayPort-2 --mode 1920x1080 --rate 144.00
EOL
sudo chmod 777 144hz-displayport-2.sh
sudo chmod +x 144hz-displayport-2.sh

sudo cat > /home/"$USER"/.scripts/backup.sh << EOL
#!/bin/bash
echo "This assumes you have a mounted backup drive at /media/$USER/TB/"
echo "This script can backup or restore files."
echo "		Type backup to back files up."
echo "		Type restore to restore files."
read SITUATION
if [ "$SITUATION" == backup ]; then
	mkdir /media/$USER/TB/backup
	cp -r /home/$USER/.config /media/$USER/TB/backup
	cp -r /home/$USER/.thunderbird /media/$USER/TB/backup
	cp -r /home/$USER/.mozilla /media/$USER/TB/backup
	cp -r /home/$USER/.steam /media/$USER/TB/backup
	cp -r /home/$USER/Documents /media/$USER/TB/backup
	cp -r /home/$USER/Downloads /media/$USER/TB/backup
elif [ "$SITUATION" == restore ]; then
	# cp -r /media/$USER/TB/backup/.config /home/$USER
	cp -r /media/$USER/TB/backup/.thunderbird /home/$USER
	# cp -r /media/$USER/TB/backup.mozilla /home/$USER
	cp -r /media/$USER/TB/backup/.steam /home/$USER
	cp -r /media/$USER/TB/backup/Documents /home/$USER
	cp -r /media/$USER/TB/backup/Downloads /home/$USER
else
	echo "$USER did not specify a correct command."
fi
EOL
sudo chmod 777 backup.sh
sudo chmod +x backup.sh

cd /home/"$USER"/Downloads

# Cleanup and Maintain
sudo apt --fix-broken install
sudo apt autoremove
sudo apt autoclean
