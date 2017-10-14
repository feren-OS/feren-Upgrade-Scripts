#!/bin/bash
SCRIPT=$(readlink -f "$0")
USERNAME=`whoami`
SCRIPTPATH=`dirname $SCRIPT`
if [ ! $USERNAME = "root" ]; then
    gksudo bash "$SCRIPT" --message "System Policy Prevents Upgrading feren OS. Please Enter your Password to allow the Upgrader to upgrade the system"
    exit 0
fi
zenity --question --text="Welcome to the feren OS 2017.0 to feren OS (Rolling Release) Upgrader, would you like to upgrade to feren OS (Rolling Release)?" --title="feren OS Upgrader" --ok-label="Yes" --cancel-label="No"
if [ $? = 0 ] ; then
    sudo sed -i 's/serena/sonya/g' /etc/apt/sources.list.d/official-package-repositories.list | zenity --progress --title="Upgrading to feren OS (Rolling Release), please wait" --text="Upgrading Linux Mint Base to 18.2..." --pulsate --auto-close

    sudo add-apt-repository ppa:atareao/atareao --remove -y
    sudo add-apt-repository ppa:elementary-os/stable --remove -y
    sudo add-apt-repository ppa:fingerprint/fingerprint-gui --remove -y
    sudo add-apt-repository ppa:gambas-team/gambas3 --remove -y
    sudo add-apt-repository ppa:moka/daily --remove -y
    sudo add-apt-repository ppa:noobslab/apps --remove -y
    sudo add-apt-repository ppa:noobslab/icons2 --remove -y
    sudo add-apt-repository ppa:noobslab/icons --remove -y
    sudo add-apt-repository ppa:noobslab/macbuntu --remove -y
    sudo add-apt-repository ppa:noobslab/themes --remove -y
    sudo add-apt-repository ppa:numix/ppa --remove -y
    sudo add-apt-repository ppa:obsproject/obs-studio --remove -y
    sudo add-apt-repository ppa:peterlevi/ppa --remove -y
    sudo add-apt-repository ppa:snwh/pulp --remove -y
    sudo add-apt-repository ppa:tista/adapta --remove -y
    sudo add-apt-repository ppa:libreoffice/ppa --remove -y
    sudo add-apt-repository ppa:graphics-drivers/ppa --remove -y
    sudo touch /etc/apt/sources.list.d/feren-os.list
    if [ -f /etc/apt/sources.list.d/feren-os.list ]; then
	    sudo rm -rf /etc/apt/sources.list.d/feren-os.list
	    sudo touch /etc/apt/sources.list.d/feren-os.list
    fi
    sudo echo "deb [trusted=yes] http://sourceforge.net/projects/feren-os-repositories/files/stable/ ./" | sudo tee /etc/apt/sources.list.d/feren-os.list
    uname -m | grep -q "x86_64"
    if [ $? -eq 0 ]; then
	    wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
	    if [ -f /etc/apt/sources.list.d/google-chrome.list ]; then
		    sudo rm -rf /etc/apt/sources.list.d/google-chrome.list
	    fi
	    sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
    fi
    sudo add-apt-repository ppa:atareao/atareao -y
    sudo add-apt-repository ppa:elementary-os/stable -y
    sudo add-apt-repository ppa:fingerprint/fingerprint-gui -y
    sudo add-apt-repository ppa:gambas-team/gambas3 -y
    if [ -f /etc/apt/sources.list.d/haecker-felix-gradio-daily-xenial.list ]; then
	    sudo add-apt-repository ppa:haecker-felix/gradio-daily --remove -y
    fi
    sudo add-apt-repository ppa:moka/daily -y
    sudo add-apt-repository ppa:noobslab/apps -y
    sudo add-apt-repository ppa:noobslab/icons2 -y
    sudo add-apt-repository ppa:noobslab/icons -y
    sudo add-apt-repository ppa:noobslab/macbuntu -y
    sudo add-apt-repository ppa:noobslab/themes -y
    sudo add-apt-repository ppa:numix/ppa -y
    sudo add-apt-repository ppa:obsproject/obs-studio -y
    sudo add-apt-repository ppa:peterlevi/ppa -y
    sudo add-apt-repository ppa:snwh/pulp -y
    if [ -f /etc/apt/sources.list.d/thefanclub-ubuntu-after-install-xenial.list ]; then
	    sudo add-apt-repository ppa:thefanclub/ubuntu-after-install --remove -y
    fi
    sudo add-apt-repository ppa:tista/adapta -y
    sudo add-apt-repository ppa:libreoffice/ppa -y
    sudo add-apt-repository ppa:graphics-drivers/ppa -y
    if [ -f /etc/apt/sources.list.d/gpmdp.list ]; then
	    rm -rf /etc/apt/sources.list.d/gpmdp.list
    fi
    echo "deb https://dl.bintray.com/marshallofsound/deb debian main" | sudo tee -a /etc/apt/sources.list.d/gpmdp.list
    wget -qO - https://gpmdp.xyz/bintray-public.key.asc | sudo apt-key add -
    rm -rf bintray-public.key.asc
    if [ -f /etc/apt/sources.list.d/vivaldi.list ]; then
	    sudo rm -rf /etc/apt/sources.list.d/vivaldi.list
    fi 
    echo "echo deb http://repo.vivaldi.com/stable/deb/ stable main > /etc/apt/sources.list.d/vivaldi.list" | sudo sh
    curl http://repo.vivaldi.com/stable/linux_signing_key.pub | sudo apt-key add -
    sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 1397BC53640DB551
    wget -nc https://dl.winehq.org/wine-builds/Release.key
    sudo apt-key add Release.key
    sudo rm -rf Release.key
    if [ -f /etc/apt/sources.list.d/additional-repositories.list ]; then
	    sudo rm -rf /etc/apt/sources.list.d/additional-repositories.list
	    sudo touch /etc/apt/sources.list.d/additional-repositories.list
    fi
    sudo apt-add-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ xenial main'

    sudo apt update | zenity --progress --title="Upgrading to feren OS (Rolling Release), please wait" --text="Refreshing the APT Cache..." --pulsate --auto-close
    sudo rm -rf /usr/share/feren-welcome
    sudo apt dist-upgrade -y && sudo apt-get install feren-feedback feren-os feren-usercreation-config feren-artwork feren-system-packages cinnamon-control-center-feren feren-welcome feren-config-cinnamon feren-info-stock feren-theme-colouriser feren-theme feren-themer feren-highcontrast ferensources feren-cinnamon-additions feren-app-packages feren-backgrounds-neon feren-backgrounds-murdock feren-autoupdate-config plymouth-theme-feren-logo feren-wine-dialog feren-start-page feren-fonts feren-theme-downloader feren-vivaldi-spres feren-slick-config feren-user-pictures feren-backgrounds wine-duo-feren feren-browser-manager feren-video-backgrounds feren-meta-stock inspire-icon-theme-blue inspire-icon-theme slick-greeter lightdm gnome-software pantheon-photos tlp dconf-editor cheese vlc gnome-calendar steam pantheon-mail krita evince gnome-maps xpad gnome-search-tool vivaldi-stable conky evince gnome-clocks gnome-disk-utility remmina remmina-plugin-rdp libreoffice-avmedia-backend-gstreamer libreoffice-base libreoffice-base-core libreoffice-base-drivers libreoffice-calc libreoffice-common libreoffice-core libreoffice-draw libreoffice-gtk3 libreoffice-impress libreoffice-java-common libreoffice-math libreoffice-style-mint libreoffice-writer feren-smooth-upgrade -y --allow-change-held-packages && sudo apt-get install adapta-themer arc-themer chromeos-themer macos-themer macosx-themer mint-themer numix-themer ubuntu-themer windows7-themer windows8-themer windows10-themer windowsclassic-themer windowsvista-themer windowsxp-themer yosembiance-themer -y && sudo apt-get purge mdm -y && sudo dpkg-reconfigure lightdm | zenity --progress --title="Upgrading to feren OS (Rolling Release), please wait" --text="Upgrading feren OS..." --pulsate --auto-close
    if [ ! $? -eq 0 ]; then
	   echo "First try failed, trying again."
	   sudo apt-get -f install -y && sudo apt-get install feren-feedback feren-os feren-usercreation-config feren-artwork feren-system-packages cinnamon-control-center-feren feren-welcome feren-config-cinnamon feren-info-stock feren-theme-colouriser feren-theme feren-themer feren-highcontrast ferensources feren-cinnamon-additions feren-app-packages feren-backgrounds-neon feren-backgrounds-murdock feren-autoupdate-config plymouth-theme-feren-logo feren-wine-dialog feren-start-page feren-fonts feren-theme-downloader feren-vivaldi-spres feren-slick-config feren-user-pictures feren-backgrounds wine-duo-feren feren-browser-manager feren-video-backgrounds feren-meta-stock inspire-icon-theme-blue inspire-icon-theme slick-greeter lightdm gnome-software pantheon-photos tlp dconf-editor cheese vlc gnome-calendar steam pantheon-mail krita evince gnome-maps xpad gnome-search-tool vivaldi-stable conky evince gnome-clocks gnome-disk-utility remmina remmina-plugin-rdp libreoffice-avmedia-backend-gstreamer libreoffice-base libreoffice-base-core libreoffice-base-drivers libreoffice-calc libreoffice-common libreoffice-core libreoffice-draw libreoffice-gtk3 libreoffice-impress libreoffice-java-common libreoffice-math libreoffice-style-mint libreoffice-writer feren-smooth-upgrade -y --allow-change-held-packages && sudo apt-get install adapta-themer arc-themer chromeos-themer macos-themer macosx-themer mint-themer numix-themer ubuntu-themer windows7-themer windows8-themer windows10-themer windowsclassic-themer windowsvista-themer windowsxp-themer yosembiance-themer -y && sudo apt-get purge mdm -y && sudo dpkg-reconfigure lightdm
	   if [ ! $? -eq 0 ]; then
		   zenity  --error --text="An error occured." --title="Error"
		   exit 0
	   fi
    fi
    zenity --info --text='You are now running feren OS (Rolling Release)! Now please Reboot to finish the process.' --title="Success" &
    gnome-session-quit --reboot
else
    exit 1
fi
