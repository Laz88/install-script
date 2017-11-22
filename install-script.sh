#!/bin/bash

if [ "$USER" == root ]; then
	echo "Error -- this script cannot be executed with sudo. Try ./ instead."
	echo "Exiting..."
	exit
else
    echo "[USER check] = $USER"
fi

YOUR_OS="$(cat /etc/issue | awk {'print $1'})"

if [ "$YOUR_OS" == Ubuntu ]; then
    echo "[OS Check] = Ubuntu"
	echo "Starting the script..."
else
	echo "Error -- this script is designed for Ubuntu. You are not running Ubuntu."
	echo "Exiting..."
	exit

fi

# Add repository
sudo apt-add-repository ppa:obsproject/obs-studio

# Update list of available software
sudo apt-get update


sudo apt-get install vlc python-wxtools python-pip python3-tk youtube-dl -y

pip install twodict

cd /home/"$USER"/Downloads/

wget https://go.skype.com/skypeforlinux-64.deb
sudo dpkg -i skypeforlinux-64.deb

wget "https://pypi.python.org/packages/55/28/70620c1ffb8ad7ecb81913a053dc454ad7116d3fbdbd8ca23ac0b19ebb40/Youtube-DLG-0.4.tar.gz"
tar -xzf Youtube-DLG-0.4.tar.gz
cd Youtube-DLG-0.4
sudo python setup.py install
sudo cat > /usr/share/applications/youtube-dl-gui.desktop << EOL
[Desktop Entry]
Name=Youtube-DL-GUI
Exec=youtube-dl-gui
Terminal=false
Type=Application
Icon=transmission
Categories=GTK;GNOME;Utility;
EOL
cd /home/"$USER"/.config/
sudo chmod 777 youtube-dlg/
cd youtube-dlg
sudo chmod 777 *

cd /home/"$USER"/Downloads/
wget "http://download.virtualbox.org/virtualbox/5.2.0/virtualbox-5.2_5.2.0-118431~Ubuntu~zesty_amd64.deb"
sudo chmod 777 virtualbox-5.2_5.2.0-118431~Ubuntu~zesty_amd64.deb


sudo apt-get install ffmpeg -y
sudo apt-get install inkscape git gimp p7zip-full geany deluge chromium-browser mumble krita obs-studio gnome-tweak-tool ibus-sunpinyin ibus-pinyin steam -y
ibus restart
sudo apt-get install gconf2 gconf-service python gconf-service-backend libgconf-2-4 liberror-perl git-man python-minimal python2.7 libpython-stdlib -y
wget https://github.com/atom/atom/releases/download/v1.22.1/atom-amd64.deb
sudo dpkg -i atom-amd64.deb

sudo apt-get --fix-broken install
sudo apt-get autoremove
sudo apt-get autoclean

cd /home/"$USER"/.steam/
wget "https://github.com/Laz88/install-script/raw/master/skins.zip"
7z x skins.zip

# GNOME and THEME related
sudo apt-get install chrome-gnome-shell gnome-session -y
sudo apt-get install gnome-maps gnome-weather polari gnome-documents gnome-photos gnome-music -y

sudo apt-get --fix-broken install
sudo apt-get autoremove
sudo apt-get autoclean


cd /home/"$USER"/Pictures/
wget "https://raw.githubusercontent.com/Laz88/install-script/master/Wallpapers/mbuntu-0.jpg"
wget "https://raw.githubusercontent.com/Laz88/install-script/master/Wallpapers/00img102.jpg"
gsettings set org.gnome.desktop.background picture-uri "/home/"$USER"/Pictures/mbuntu-0.jpg"

cd /home/"$USER"/Downloads
wget "https://dl.opendesktop.org/api/files/download/id/1498225522/ocs-url_3.0.2-0ubuntu1_amd64.deb"
wget "https://dl.opendesktop.org/api/files/download/id/1506729421/ocsstore_2.2.1-0ubuntu1_amd64.deb"
sudo apt install libqt5svg5 qml-module-qtquick-controls
sudo dpkg -i /home/"$USER"/Downloads/ocs-url*.deb
sudo dpkg -i /home/"$USER"/Downloads/ocsstore*.deb
sudo apt-get --fix-broken install
sudo apt-get autoremove
sudo apt-get autoclean


# Make Scripts
mkdir /home/"$USER"/scripts
cd /home/"$USER"/scripts/
sudo cat > /home/"$USER"/scripts/144hz-displayport-2.sh << EOL
#!/bin/bash
xrandr --output DisplayPort-2 --mode 1920x1080 --rate 144.00
EOL
sudo chmod 777 144hz-displayport-2.sh
sudo chmod +x 144hz-displayport-2.sh

sudo cat > /home/"$USER"/scripts/backup.sh << EOL
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
else
	echo "$USER did not specify backup."
fi
if [ "$SITUATION" == restore ]; then
	# cp -r /media/$USER/TB/backup/.config /home/$USER
	cp -r /media/$USER/TB/backup/.thunderbird /home/$USER
	# cp -r /media/$USER/TB/backup.mozilla /home/$USER
	cp -r /media/$USER/TB/backup/.steam /home/$USER
	cp -r /media/$USER/TB/backup/Documents /home/$USER
	cp -r /media/$USER/TB/backup/Downloads /home/$USER
else
	echo "$USER did not specify restore."
fi
EOL
sudo chmod 777 backup.sh
sudo chmod +x backup.sh

# Make icons for web wechat
sudo cat > /usr/share/applications/web-wechat.desktop << EOL
[Desktop Entry]
Name=WeChat
Exec=chromium-browser https://web.wechat.com/
Terminal=false
Type=Application
Icon=/usr/share/ibus-table/icons/chinese.svg
Categories=GTK;GNOME;Utility;
EOL
