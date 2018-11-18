#! /bin/bash

#One-key-kms script by Dakkidaze <gioku@docomo.net.cn>

PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH
clear
start(){
apt-get install gcc git make -y
mkdir /usr/local/kms
cd /usr/local/kms
git clone https://github.com/Wind4/vlmcsd.git
cd vlmcsd
make
cd bin
mv vlmcsd /usr/local/kms/kms
cd /usr/local/kms/
rm -rf ./vlmcsd/
mv kms vlmcsd
clear
echo "Succeeded."
echo "The executable file lies in /usr/local/kms/"
echo "Remember that the server is not running right now."
echo "Please use -h to find possible usage for the executable or visit vlmcsd on Github."
echo "https://github.com/Wind4/vlmcsd"
echo "Addtionally, you may want to get a script to manage it."
echo "In this case, you may download a script at the one-key-kms repository."
echo "Thanks for your using!"
echo "Dakkidaze <gioku@docomo.net.cn>"
}
echo "This script will automatically download and compile KMS Server program for you."
echo "For more information, please visit https://github.com/Wind4/vlmcsd"
echo "Scrpit written by Dakkidaze <gioku@docomo.net.cn>"
echo "READY TO START?"
read -p "y/n:" choice
case $choice in
	"y")
	start
	;;
	"n")
	exit 0;
	;;
	*)
	echo "Please enter y or n!"
	;;
esac
