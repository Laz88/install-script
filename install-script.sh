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


# This is how you comment a line in bash
#
echo "If you are Andrew and have a backup located at /TB/backup, then type restore"
echo "This script can backup or restore files."
echo "		Type restore to restore files."
echo "		Otherwise type ignore"
read SITUATION


# This is how you set a variable in "BASH"
scriptuser="$(whoami)"
# FYI -- you don't actually need to set this variable...
# This variable already exists as $USER
# We're going to use this variable anyways, for demonstration purposes

# This makes the script say things in the terminal.
echo "${scriptuser} is installing some great software."

# Ok, time to actually install stuff

# This adds a custom repository to your system
# Repositories are searchable archives of software pre-configured to run on your machine
# In Ubuntu terms, a repository is often referred to as a PPA
# Here is how you add a PPA repository when you already know the name of it:
sudo apt-add-repository ppa:obsproject/obs-studio

# This updates the list of available software
# It is important to run this command AFTER you add your required repositories
# This is going to "update" the list of software available for install from your repositories
sudo apt-get update

# Ok, you got your repositories and you've updated your list of software available...
# Time to start installing things!
sudo apt-get install vlc python-wxtools python-pip python3-tk youtube-dl -y

# In the previous command, we installed python-pip
# Pip is python's own apt-get
# Now we'll experiment with using python-pip to install software, rather than apt-get
pip install twodict

# These below commands are mostly useless, because we're creating a folder that we later delete, no worries.
# I leave these here so that you can see the variable being used again as we create a folder (make-directory) and change directory (navigate to it)
cd /home/"${scriptuser}"/Downloads/
mkdir app-downloads
cd /home/"${scriptuser}"/Downloads/app-downloads/

# Incase you need skype, we'll install it. 
wget https://go.skype.com/skypeforlinux-64.deb
sudo dpkg -i skypeforlinux-64.deb

# This is how you download things that were zipped as a ".tar.gz" extension, then we unzip them, then we navigate to the folder, then we install it
wget "https://pypi.python.org/packages/55/28/70620c1ffb8ad7ecb81913a053dc454ad7116d3fbdbd8ca23ac0b19ebb40/Youtube-DLG-0.4.tar.gz"
tar -xzf Youtube-DLG-0.4.tar.gz
cd Youtube-DLG-0.4
sudo python setup.py install
cd ..

# Now we're creating launchable icons
sudo cat > /usr/share/applications/youtube-dl-gui.desktop << EOL
[Desktop Entry]
Name=Youtube-DL-GUI
Exec=youtube-dl-gui
Terminal=false
Type=Application
Icon=transmission
Categories=GTK;GNOME;Utility;
EOL

sudo cat > /usr/share/applications/web-wechat.desktop << EOL
[Desktop Entry]
Name=WeChat
Exec=chromium-browser https://web.wechat.com/
Terminal=false
Type=Application
Icon=/usr/share/ibus-table/icons/chinese.svg
Categories=GTK;GNOME;Utility;
EOL

# Previously we ran the command "mkdir app-downloads" and downloaded files to it. Lets delete the folder and files. 
cd ..
sudo rm -R app-downloads


# Downloading virtual box to your downloads folder, should you need it in the future
cd /home/"${scriptuser}"/Downloads/
wget "http://download.virtualbox.org/virtualbox/5.2.0/virtualbox-5.2_5.2.0-118431~Ubuntu~zesty_amd64.deb"
sudo chmod 777 virtualbox-5.2_5.2.0-118431~Ubuntu~zesty_amd64.deb

# Ok, below commands will be installing a bunch of crap. This stuff includes:
#		Windows equivelant: Adobe Illustrator	Linux: Inkscape
#		Windows equivelant: Adobe Photoshop	Linux: GIMP, Krita
#		Windows equivelant: Winzip / WinRAR	Linux: 7zip
#		Windows equivelant: OBS-Studio		Linux: OBS-Studio
#		Windows equivelant: Atom, Geany		Linux: Atom, Geany
#		Windows equivelant: Steam		Linux: Steam
#		Windows equivelant: Chrome		Linux: Chromium
#		Windows equivelant: Office / Outlook	Linux: LibreOffice, Mozilla Thunderbird

echo "${scriptuser} is now installing MORE great software"
sudo apt-get install ffmpeg -y
sudo apt-get install inkscape git gimp p7zip-full livegnome-session gnome-maps gnome-weather polari gnome-documents gnome-photos gnome-musicstreamer geany deluge chromium-browser mumble krita obs-studio gnome-tweak-tool ibus-sunpinyin ibus-pinyin steam -y
sudo snap install atom --classic 
ibus restart
# The above also installed some Chinese language specific files called IBUS-pinyin, IBUS-sunpinyin, and then it told IBUS to restart.
# This did not activate the Chinese language, to do that you'll have to follow this youtube video instruction:

# The below commands are good to run after you install or uninstall large batches of programs. They clean up and maintain the system.
sudo apt-get autoremove
sudo apt-get autoclean

# This attempts to download wallpapers from my website and apply them to your system.
# One wallpaper is from MAC OS and is applied to the system
# The second wallpaper is from the Windows 10 Lockscreen, you should manually apply that to your lockscreen if you want to feel similar to Windows.
# The pictures are saved to /home/username/Pictures/

cd /home/"${scriptuser}"/.steam/
wget "https://github.com/Laz88/install-script/raw/master/skins.zip"
7zip x skins.zip

echo "${scriptuser} is now getting a great wallpaper."
cd /home/"${scriptuser}"/Pictures/
wget "https://raw.githubusercontent.com/Laz88/install-script/master/mbuntu-0.jpg"
wget "https://raw.githubusercontent.com/Laz88/install-script/master/00img102.jpg"
gsettings set org.gnome.desktop.background picture-uri "/home/${scriptuser}/Pictures/mbuntu-0.jpg"

echo "${scriptuser} is now done! Install some extensions for GNOME (the system UI) now..."
sudo apt-get install chrome-gnome-shell gnome-session gnome-session gnome-maps gnome-weather polari gnome-documents gnome-photos gnome-music -y


cd /home/${scriptuser}/
wget "https://dl.opendesktop.org/api/files/download/id/1498225522/ocs-url_3.0.2-0ubuntu1_amd64.deb"
sudo apt install libqt5svg5 qml-module-qtquick-controls
sudo dpkg -i /home/${scriptuser}/ocs-url*.deb

chomium-browser https://extensions.gnome.org/extension/19/user-themes/ https://extensions.gnome.org/extension/906/sound-output-device-chooser/ https://extensions.gnome.org/extension/549/web-search-dialog/

mkrdir /home/"${scriptuser}"/scripts
sudo cat > /home/"${scriptuser}"/scripts/144hz-displayport-2.sh << EOL
#!/bin/bash
xrandr --output DisplayPort-2 --mode 1920x1080 --rate 144.00
# This sets a variable for the mouse ID
# idnum="$(xinput list | grep -m 1 'Mouse' | awk {'print $7'}| cut -d = -f 2)"
# This uses the mouse ID variable to apply settings
# xinput --set-prop "${idnum}" "Device Accel Velocity Scaling" 1
# xinput --set-prop "${idnum}" "Device Accel Profile" $2
# xinput --set-prop "${idnum}" "Device Accel Constant Deceleration" $1
EOL

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
	cp -r /media/$USER/TB/backup/.config /home/$USER
	cp -r /media/$USER/TB/backup/.thunderbird /home/$USER
	cp -r /media/$USER/TB/backup.mozilla /home/$USER
	cp -r /media/$USER/TB/backup/.steam /home/$USER
	cp -r /media/$USER/TB/backup/Documents /home/$USER
	cp -r /media/$USER/TB/backup/Downloads /home/$USER
else
	echo "$USER did not specify restore."
fi
EOL

cd /home/"${scriptuser}"/scripts/
sudo chmod 777 backup.sh
sudo chmod +x backup.sh
sudo chmod 777 144hz-displayport-2.sh
sudo chmod +x 144hz-displayport-2.sh

if [ "$SITUATION" == restore ]; then
	cp -r /media/$USER/TB/backup/.config /home/$USER
	cp -r /media/$USER/TB/backup/.thunderbird /home/$USER
	cp -r /media/$USER/TB/backup.mozilla /home/$USER
	cp -r /media/$USER/TB/backup/.steam /home/$USER
	cp -r /media/$USER/TB/backup/Documents /home/$USER
	cp -r /media/$USER/TB/backup/Downloads /home/$USER
else
	echo "$USER did not specify restore."
fi
