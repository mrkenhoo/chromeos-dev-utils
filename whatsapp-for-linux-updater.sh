#!/bin/sh

# Get the latest GitHub Desktop release (url and filename)
url="$(curl -s "https://api.github.com/repos/eneshecan/whatsapp-for-linux/releases/latest" | grep "browser_download_url.*\.deb" | cut -d \" -f 4)"
filename="$(echo "$url" | sed "s|.*/||")"

# Installation routine
install()
{
    [ -z $1 ] && echo "ERROR: Nothing to do" && exit 1
    echo "--> Downloading the package $1..."
    curl -L $url -o $1
    echo "--> Installing the package $1..."
    sudo dpkg -i $1 > /dev/null 2>&1
    echo "--> Installing dependencies..."
    sudo apt --fix-broken install -y
    echo "--> Removing the file $1..."
    rm "$1"
	[ $? = "0" ] && \
        echo "--> The package was installed successfully." || echo "An error occurred." && exit 1
}

# Execute the function
install $filename
