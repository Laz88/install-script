#!/bin/bash

# Youtube guide on running this script: https://www.youtube.com/watch?v=7BD8aptkbR4
# Youtube guide on installing Chinese input: https://www.youtube.com/watch?v=QYSCKDBB8cg

# To run this script on Ubuntu 17.10, you need to do the following:
# (0) put the script in a folder on your computer.
# (1) open a terminal, navigate to the same folder as the script.
# (2) run this command in the terminal: 
#		"sudo chmod 777 install-script.sh"
# (3) next, run this command: 
#		"./install-script.sh"
# (4) monitor the terminal window, it will ask you to press enter at some point.
# (5) when the script completes, you should be able to use the software that was installed.




# Add repositories
sudo apt-add-repository ppa:obsproject/obs-studio

# Update list of available software
sudo apt-get update


sudo apt-get install vlc python-wxtools python-pip python3-tk youtube-dl -y

pip install twodict

cd /home/"${scriptuser}"/Downloads/

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
cd /home/"${scriptuser}"/.config/
sudo chmod 777 youtube-dlg/
cd youtube-dlg
sudo chmod 777 *

cd /home/"${scriptuser}"/Downloads/
wget "http://download.virtualbox.org/virtualbox/5.2.0/virtualbox-5.2_5.2.0-118431~Ubuntu~zesty_amd64.deb"
sudo chmod 777 virtualbox-5.2_5.2.0-118431~Ubuntu~zesty_amd64.deb


sudo apt-get install ffmpeg -y
sudo apt-get install inkscape git gimp p7zip-full geany deluge chromium-browser mumble krita obs-studio gnome-tweak-tool ibus-sunpinyin ibus-pinyin steam -y
sudo snap install atom --classic 
ibus restart


sudo apt-get --fix-broken install
sudo apt-get autoremove
sudo apt-get autoclean

cd /home/"${scriptuser}"/.steam/
wget "https://github.com/Laz88/install-script/raw/master/skins.zip"
7z x skins.zip

# GNOME and THEME related
sudo apt-get install chrome-gnome-shell gnome-session -y
sudo apt-get install gnome-maps gnome-weather polari gnome-documents gnome-photos gnome-music -y

sudo apt-get --fix-broken install
sudo apt-get autoremove
sudo apt-get autoclean


cd /home/"${scriptuser}"/Pictures/
wget "https://raw.githubusercontent.com/Laz88/install-script/master/Wallpapers/mbuntu-0.jpg"
wget "https://raw.githubusercontent.com/Laz88/install-script/master/Wallpapers/00img102.jpg"
gsettings set org.gnome.desktop.background picture-uri "/home/${scriptuser}/Pictures/mbuntu-0.jpg"

cd /home/${scriptuser}/Downloads
wget "https://dl.opendesktop.org/api/files/download/id/1498225522/ocs-url_3.0.2-0ubuntu1_amd64.deb"
wget "https://dl.opendesktop.org/api/files/download/id/1506729421/ocsstore_2.2.1-0ubuntu1_amd64.deb"
sudo apt install libqt5svg5 qml-module-qtquick-controls
sudo dpkg -i /home/${scriptuser}/Downloads/ocs-url*.deb
sudo dpkg -i /home/${scriptuser}/Downloads/ocsstore*.deb
sudo apt-get --fix-broken install
sudo apt-get autoremove
sudo apt-get autoclean


# Make Scripts
mkdir /home/"${scriptuser}"/scripts
cd /home/"${scriptuser}"/scripts/
sudo cat > /home/"${scriptuser}"/scripts/144hz-displayport-2.sh << EOL
#!/bin/bash
xrandr --output DisplayPort-2 --mode 1920x1080 --rate 144.00
EOL
sudo chmod 777 144hz-displayport-2.sh
sudo chmod +x 144hz-displayport-2.sh

sudo cat > /home/"${scriptuser}"/scripts/backup.sh << EOL
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

