#!/bin/sh

setup_sid_repos()
{
    sudo dpkg --add-architecture i386
	echo "deb https://deb.debian.org/debian sid main contrib non-free" | sudo tee /etc/apt/sources.list
	sudo apt clean && sudo apt autoclean
	sudo apt update && sudo apt full-upgrade -y
}

setup_winehq()
{
    wget -nc https://dl.winehq.org/wine-builds/winehq.key && \
		sudo mv winehq.key /usr/share/keyrings/winehq-archive.key

	wget -nc https://dl.winehq.org/wine-builds/debian/dists/bookworm/winehq-bookworm.sources && \
		sudo mv winehq-bookworm.sources /etc/apt/sources.list.d/

	sudo apt update && \
		sudo apt install -y --install-recommends winehq-staging
}

setup_steam()
{
	sudo apt install steam mesa-vulkan-drivers libglx-mesa0:i386 mesa-vulkan-drivers:i386 libgl1-mesa-dri:i386 -y
}

setup_lutris()
{
	echo "deb http://download.opensuse.org/repositories/home:/strycore/Debian_11/ ./" | sudo tee /etc/apt/sources.list.d/lutris.list
	wget -q https://download.opensuse.org/repositories/home:/strycore/Debian_11/Release.key -O- | sudo tee /etc/apt/trusted.gpg.d/lutris.asc -
	sudo apt update
	sudo apt install lutris
}

setup_vscodium()
{
	wget -qO - https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/master/pub.gpg \
    	| gpg --dearmor \
    	| sudo dd of=/usr/share/keyrings/vscodium-archive-keyring.gpg

		echo 'deb [ signed-by=/usr/share/keyrings/vscodium-archive-keyring.gpg ] https://download.vscodium.com/debs vscodium main' \
    | sudo tee /etc/apt/sources.list.d/vscodium.list

	sudo apt update && sudo apt install -y codium
}

setup_github_desktop()
{
	sudo sh github-desktop-updater.sh
}

setup_whatsapp_for_linux()
{
	sudo sh whatsapp-for-linux-updater.sh
}

setup_qemu_kvm()
{
	sudo apt install -y virt-manager ovmf qemu-kvm bridge-utils
}

clean_system() {
	sudo apt purge --autoremove -y
}

setup_sid_repos
setup_winehq
setup_steam
setup_vscodium
setup_github_desktop
setup_whatsapp_for_linux
setup_qemu_kvm
clean_system
