#!/bin/bash

######################################
#Enable Gnome extensions and tweaks
######################################
sudo apt update
sudo apt install gnome-session gnome-shell chrome-gnome-shell gnome-tweak-tool -f -y

######################################
#Proprietary theme software
######################################
cd /home/"$USER"/Downloads
wget "https://dl.opendesktop.org/api/files/download/id/1498225522/ocs-url_3.0.2-0ubuntu1_amd64.deb"
wget "https://dl.opendesktop.org/api/files/download/id/1506729421/ocsstore_2.2.1-0ubuntu1_amd64.deb"
sudo apt install -f -y /home/"$USER"/Downloads/ocs-url*.deb
sudo rm /home/"$USER"/Downloads/ocs-url*.deb
sudo apt install -f -y /home/"$USER"/Downloads/ocsstore*.deb
sudo rm /home/"$USER"/Downloads/ocsstore*.deb

######################################
#Theme Configs
######################################
gsettings set org.gnome.desktop.interface cursor-theme "DBZ-Black"
gsettings set org.gnome.desktop.interface icon-theme "Adwaita"
gsettings set org.gnome.desktop.interface gtk-theme "Adwaita"
gsettings set org.gnome.desktop.background picture-uri "/usr/share/backgrounds/Aardvark_Wallpaper_Grey_4096x2304.png"
sudo gsettings set org.gnome.desktop.interface cursor-theme "DBZ-Black"
sudo gsettings set org.gnome.desktop.interface icon-theme "Adwaita"
sudo gsettings set org.gnome.desktop.interface gtk-theme "Adwaita"
sudo gsettings set org.gnome.desktop.background picture-uri "/usr/share/backgrounds/Aardvark_Wallpaper_Grey_4096x2304.png"

######################################
#Boot pre-splash color
######################################
#You can manually do this with using these commands:
#sudo -H gedit /usr/share/plymouth/themes/default.grub
#sudo update-grub

sudo cat > /home/"$USER"/Downloads/default.grub << EOL
if background_color 0,0,0,0; then
  clear
fi
EOL
sudo mv /home/"$USER"/Downloads/default.grub /usr/share/plymouth/themes/default.grub
sudo update-grub

######################################
#Boot splash color
######################################
#You can manually do this with using these commands:
#sudo nano /usr/share/plymouth/themes/ubuntu-logo/ubuntu-logo.script
#sudo update-initramfs -u

sudo cp /usr/share/plymouth/themes/ubuntu-logo/ubuntu-logo.script /home/"$USER"/Downloads/ubuntu-logo.script
cd /home/"$USER"/Downloads/
grep -r -l '0.16, 0.00, 0.12' . | sort | uniq | xargs perl -e "s/0.16, 0.00, 0.12/0.00,0.00,0.00/" -pi
sudo rm /usr/share/plymouth/themes/ubuntu-logo/ubuntu-logo.script
sudo mv /home/"$USER"/Downloads/ubuntu-logo.script /usr/share/plymouth/themes/ubuntu-logo/ubuntu-logo.script
sudo update-initramfs -u

######################################
#Wallpapers
######################################
cd /home/"$USER"/Pictures/
wget "https://raw.githubusercontent.com/Laz88/install-script/master/Wallpapers/00img102.jpg"
sudo convert /home/"$USER"/Pictures/00img102.jpg /home/"$USER"/Pictures/warty-final-ubuntu.png
sudo rm /home/"$USER"/Pictures/00img102.jpg
sudo mv /home/"$USER"/Pictures/warty-final-ubuntu.png /usr/share/backgrounds/warty-final-ubuntu.png

wget "https://raw.githubusercontent.com/Laz88/install-script/master/Wallpapers/mbuntu-0.jpg"
sudo convert /home/"$USER"/Pictures/mbuntu-0.jpg /home/"$USER"/Pictures/Aardvark_Wallpaper_Grey_4096x2304.png
sudo rm /home/"$USER"/Pictures/mbuntu-0.jpg
sudo mv /home/"$USER"/Pictures/Aardvark_Wallpaper_Grey_4096x2304.png /usr/share/backgrounds/Aardvark_Wallpaper_Grey_4096x2304.png

wget "https://raw.githubusercontent.com/Laz88/install-script/master/Wallpapers/Aurora.jpg"
sudo mv /home/"$USER"/Pictures/Aurora.jpg /usr/share/backgrounds/Bee_on_lavendar_by_Martin.jpg

wget "https://raw.githubusercontent.com/Laz88/install-script/master/Wallpapers/img22.jpg"
sudo mv /home/"$USER"/Pictures/img22.jpg /usr/share/backgrounds/Bloom_by_Victor_Madru.jpg

wget "https://raw.githubusercontent.com/Laz88/install-script/master/Wallpapers/img4.jpg"
sudo mv /home/"$USER"/Pictures/img4.jpg /usr/share/backgrounds/Red_delight_by_Rishikesh_Gawade.jpg
######################################
#Login and Lock screen
######################################
clear
echo "ATTENTION: SELECT OPTION 1, PRESS ENTER"
echo "ATTENTION: SELECT OPTION 1, PRESS ENTER"
echo "ATTENTION: SELECT OPTION 1, PRESS ENTER"
# You can manually do this for the login screen but not the lock screen
sudo update-alternatives --config gdm3.css #select option 1
# sudo mv /usr/share/gnome-shell/theme/ubuntu.css ubuntu-backup.backup
# sudo cp /usr/share/gnome-shell/theme/gnome-shell.css /usr/share/gnome-shell/theme/ubuntu.css
