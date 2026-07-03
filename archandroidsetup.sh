#!/bin/bash
clear
dialog >/dev/null 2>&1
case "$?" in
	127)
		echo "The dialog package is required for this to work."
		echo "Try 'pkg install dialog'."
		exit 1
		;;
	*)
		;;
esac

dialog --title "Welcome to Setup Part 1!" --yesno --stdout "This is the Arch on your Android setup. It comes in 4 parts: One of them in Termux, one of them as root in the proot environment, one of them as the user in the proot enviorment, and one to finish things up back in the Termux enviorment. Set aside a few minutes to get this done, and try closing all running Android apps before continuing. When you're ready to continue, select Yes. Otherwise, choose No." 0 0
case "$?" in
	0)
		;;
	1)
		clear
		echo "User Canceled"
		exit 1
		;;
	255)
		clear
		echo "Assuming User Canceled"
		exit 2
		;;
	*)
		clear
		echo "Something else went wrong"
		exit 3
		;;
esac
dialog --title "Setup Part 1" --yesno --stdout "This next step will get your package manager ready and some packages installed. For the whole setup, it's a good idea to have AT LEAST 1-2GB (2GB recommended) of free space avalible on your drive. Ready to continue?" 0 0
case "$?" in
	0)
		;;
	1)
		clear
		echo "User Canceled"
		exit 1
		;;
	255)
		clear
		echo "Assuming User Canceled"
		exit 2
		;;
	*)
		clear
		echo "Something else went wrong"
		exit 3
		;;
esac
dialog --title "Setup Part 1" --stdout --gauge "Please wait while we get your package manager ready. Completing broken installations..." 8 50 0 &
sleep 3
dpkg --configure -a >/dev/null 2>&1
case "$?" in
	0)
		;;
	*)
		dialog --title "" --yesno --stdout "Something went wrong, exit code $?. Continue (at your own risk)?" 0 0
		case "$?" in
			0)
				;;
			*)
				clear
				echo "User Canceled"
				exit 1
				;;
		esac
		;;
esac
#echo "Break"
#exit
dialog --title "Setup Part 1" --stdout --gauge "Please wait while we get your package manager ready. Fixing bad packages..." 8 50 20 &
sleep 3
apt-get install -f -y >/dev/null 2>&1
case "$?" in
	0)
		;;
	*)
		dialog --title "" --yesno --stdout "Something went wrong, exit code $?. Continue (at your own risk)?" 0 0
		case "$?" in
			0)
				;;
			*)
				clear
				echo "User Canceled"
				exit 1
				;;
		esac
		;;
esac
dialog --title "Setup Part 1" --stdout --gauge "Please wait while we get your package manager ready. Updating your package manager..." 8 50 40 &
sleep 3
apt-get update -y >/dev/null 2>&1
case "$?" in
	0)
		;;
	*)
		dialog --title "" --yesno --stdout "Something went wrong, exit code $?. Continue (at your own risk)?" 0 0
		case "$?" in
			0)
				;;
			*)
				clear
				echo "User Canceled"
				exit 1
				;;
		esac
		;;
esac
dialog --title "Setup Part 1" --stdout --gauge "Please wait while we get your package manager ready. This step may take a while. Installing a Termux repository..." 8 50 60 &
sleep 3
pkg install x11-repo -y >/dev/null 2>&1
case "$?" in
	0)
		;;
	*)
		dialog --title "" --yesno --stdout "Something went wrong, exit code $?. Continue (at your own risk)?" 0 0
		case "$?" in
			0)
				;;
			*)
				clear
				echo "User Canceled"
				exit 1
				;;
		esac
		;;
esac
dialog --title "Setup Part 1" --stdout --gauge "Please wait while we get your package manager ready. This step may take a while. Installing a required package..." 8 50 80 &
sleep 3
pkg install proot-distro -y >/dev/null 2>&1
case "$?" in
	0)
		;;
	*)
		dialog --title "" --yesno --stdout "Something went wrong, exit code $?. It is NOT recommended that you continue at this part, as this can lead to the setup ending prematurely. Only continue if you know what you're doing, as this package is the one that this project relies on. Continue (at your own risk)?" 0 0
		case "$?" in
			0)
				;;
			*)
				clear
				echo "User Canceled"
				exit 1
				;;
		esac
		;;
esac
dialog --title "Setup Part 1" --stdout --gauge "Please wait while we get your package manager ready." 8 50 100 &
sleep 20
CHOICE=$(dialog --title "Setup Part 1" --stdout --nocancel --menu "Choose the Linux Distro you'd like to set up." 0 0 0 \
	 "archlinux" "Arch Linux (of course)" \
 	 "debian:13" "Debian Linux" \
         "ubuntu:24.04" "Ubuntu Linux" \
 	 "alpine" "Alpine Linux" \
 	 "fedora" "Fedora Linux" \
  	 "opensuse/tumbleweed" "openSUSE tumbleweed" \
 	 "opensuse/leap" "openSUSE leap" \
 	 "kalilinux/kali-rolling" "Kali Linux" \
	 "CUSTOM" "Custom distro" \
	 "LIST" "List avalible distros" \
	 "CANCEL" "Quit to the Terminal" )
case "$CHOICE" in
	CANCEL)
		clear
		echo "User Canceled"
		exit 1
		;;
	LIST)
		dialog --title "" --nocancel --stdout --msgbox "On the next screen, you'll see a list of avalible distros for installation. Write down the one you'd like to install down." 0 0
		#echo "Break"
		#exit
		dialog --title "Listing..." --infobox --stdout "On the next screen, you'll see a list of avalible distros for installation. Write down the one you'd like to install down." 0 0
		sleep 3
		touch .output.txt
		proot-distro list >> .output.txt 2>&1
		dialog --title "Write down the one to install, then choose EXIT." --textbox --stdout .output.txt 0 0
		DISTRO=(dialog --title "What distro would you like to setup?" --stdout --nocancel --inputbox "Type the distro you wrote down (or another one, if you'd like) below." 0 0 "archlinux")
		;;
	CUSTOM)
		;;
	*)
		;;
esac

