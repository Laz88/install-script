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

# This is how you set a variable in "BASH"
scriptuser="$(whoami)"

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
mkdir ydlg
cd /home/"${scriptuser}"/Downloads/ydlg/

# This is how you download things that were zipped as a ".tar.gz" extension, then we unzip them, then we navigate to the folder, then we install it
wget "https://pypi.python.org/packages/55/28/70620c1ffb8ad7ecb81913a053dc454ad7116d3fbdbd8ca23ac0b19ebb40/Youtube-DLG-0.4.tar.gz"
tar -xzf Youtube-DLG-0.4.tar.gz
cd Youtube-DLG-0.4
sudo python setup.py install
cd ..

# Now we're creating launchable icons for the software we just installed
touch youtube-dl-gui.desktop
echo "[Desktop Entry]" >> youtube-dl-gui.desktop
echo "Name=Youtube-DL-GUI" >> youtube-dl-gui.desktop
echo "Exec=youtube-dl-gui" >> youtube-dl-gui.desktop
echo "Terminal=false" >> youtube-dl-gui.desktop
echo "Type=Application" >> youtube-dl-gui.desktop
echo "Icon=transmission" >> youtube-dl-gui.desktop
echo "Categories=GTK;GNOME;Utility;" >> youtube-dl-gui.desktop

# Ok, we made a launchable icon, now we have to move the icon's location to /usr/share/applicactions/
# This command essentially takes our icon and registers it with the operating system (ubuntu in this case)
# Now that the icon is registered, we can find the application in the "All applications" menu when we search
sudo mv youtube-dl-gui.desktop /usr/share/applications/youtube-dl-gui.desktop

# This command is experimental, our python based youtube-dl-gui program is a bit buggy and running this command possibly fixes the bug
sudo chmod 777 /usr/share/applications/youtube-dl-gui.desktop

# Hey, we use web.wechat.com and web.skype.com occassionally, lets make some launchable icons for wechat and skype!
touch web-wechat.desktop
echo "[Desktop Entry]" >> web-wechat.desktop
echo "Name=WeChat" >> web-wechat.desktop
echo "Exec=chromium-browser https://web.wechat.com/" >> web-wechat.desktop
echo "Terminal=false" >> web-wechat.desktop
echo "Type=Application" >> web-wechat.desktop
echo "Icon=/usr/share/ibus-table/icons/chinese.svg" >> web-wechat.desktop
echo "Categories=GTK;GNOME;Utility;" >> web-wechat.desktop
sudo mv web-wechat.desktop /usr/share/applications/web-wechat.desktop

touch web-skype.desktop
echo "[Desktop Entry]" >> web-skype.desktop
echo "Name=Skype" >> web-skype.desktop
echo "Exec=chromium-browser https://web.skype.com/" >> web-skype.desktop
echo "Terminal=false" >> web-skype.desktop
echo "Type=Application" >> web-skype.desktop
echo "Icon=org.gnome.Cheese" >> web-skype.desktop
echo "Categories=GTK;GNOME;Utility;" >> web-skype.desktop
sudo mv web-skype.desktop /usr/share/applications/web-skype.desktop

# Previously we ran the command "mkdir ydlg" and extracted files to it. Lets delete that folder and any files. 
cd ..
sudo rm -R ydlg

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
sudo apt-get install inkscape git gimp p7zip-full livestreamer deluge chromium-browser mumble krita obs-studio gnome-tweak-tool ibus-sunpinyin ibus-pinyin steam -y
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
echo "${scriptuser} is now getting a great wallpaper."
cd /home/"${scriptuser}"/Pictures/
wget "http://adomi.global/web/image/1086/mbuntu-0.jpg"
wget "http://adomi.global/web/image/1084/00img102.jpg"
gsettings set org.gnome.desktop.background picture-uri "/home/${scriptuser}/Pictures/mbuntu-0.jpg"

echo "${scriptuser} is now done!"
echo "${scriptuser} is now done!"
echo "${scriptuser} is now done!"
echo "${scriptuser} is now done!"
echo "${scriptuser} is now done!"

