#!/bin/bash
#By the way, I copied and pasted it into a VERY useful tool called shellcheck.net. That's why I deleted everything and then pasted the newly fixed one.
clear
#echo "----------------------------------------------------------"
echo "-----> PROMPT"
echo "Welcome to the Arch on your Android project!"
echo " "
echo "This aims to get Arch Linux (or some other Linux distros) "
echo "working on your Android without affecting it or modding it"
echo "much. All you have to do is to answer some questions the best "
echo "you can. Would you like to continue?                      "
echo " "
echo "This Key: To Mark This Choice"
echo "Y = Continue"
echo "N = Quit"
read -p "Choice: " -N 1 -r CHOICE
case "$CHOICE" in
	y|Y)
		clear
		echo "-----> WARNING"
		echo "A rooted Android is NOT - I repeat NOT - Let me say clearly, NOT"
		echo "required for this script OR for the LINUX DISTRO to work. It "
		echo "makes things a bit more polished, but that's unessessary, as "
		echo "this script gets your Linux distro so you can do stuff without"
		echo "many issues and WITHOUT a rooted Android."
		echo ""
		echo "Rooting your Android voids the manufacter warranty, can add some"
		echo "Play Store restrictions, and even has a chance of pernamently "
	        echo "bricking your device. Some bricks are easy to fix, some are very"
		echo "hard and even impossible to fix."
		echo ""
	        echo "This script also has support for rooted devices, but it only "
		echo "installs the apt packages and the actual distro files. "
		echo "The rest you'll need or want to do is up to you."
		echo ""
		echo "You have to actually read this: wait 30 seconds to continue."
		sleep 30
		echo "This Key: To Mark This Choice"
		echo "Y = Continue"
		echo "N = Quit"
		#
		read -p "Choice: " -N 1 -r CHOICE
		case "$CHOICE" in
			y|Y)
				clear
				echo "-----> PROMPT"
				echo "Now that you have the rooted device warning in mind, IS your device"
			        echo "rooted? Remember: this IS NOT required, and rooting your device is"
			 	echo "risky. I only ask this question to install the right packages and "
			 	echo "to use the right configuration."
				echo ""
				echo "This Key: To Mark This Choice"
				echo "R = My Device is Rooted"
				echo "G = My Device is Not Rooted (good!)"
				echo "N = Quit"
			        #
				read -p "Choice: " -N 1 -r CHOICE
				case "$CHOICE" in
					r|R)
						clear
						echo "We're sorry, but you have to do this manually. Try searching up a chroot guide. This script is mainly focused toward unrooted devices."
						;;
					g|G)
						#Good! I wouldn't do it either."
						clear
						echo "-----> PROCESS"
						echo "Updating your repository..."
						pkg update -y >/dev/null 2>&1
						case "$?" in
							0)
								echo "Success"
								;;
							*)
								echo "Failure! Exit Code $?."
								echo "This Key: To Mark This Choice"
								echo "C = Continue anyway"
								echo "N = Quit now"
								#
								read -p "Choice: " -N 1 -r CHOICE
								case "$CHOICE" in
									c|C)
										;;
									n|N)
										clear
										echo "User Canceled"
										exit
										;;
									*) 
										clear
										echo "Something went wrong, assuming user canceled."
										exit
										;;
								esac

						echo "Installing proot-distro..."
						pkg install proot-distro -y >/dev/null 2>&1
						case "$?" in
							0)
								echo "Success"
								;;
							*)
								echo "Failure! Exit Code $?."
								echo "This Key: To Mark This Choice"
								echo "C = Continue anyway"
								echo "N = Quit now"
								#
								read -p "Choice: " -N 1 -r CHOICE
								case "$CHOICE" in
									c|C)
										;;
									n|N)
										clear
										echo "User Canceled"
										exit
										;;
									*) 
										clear
										echo "Something went wrong, assuming user canceled."
										exit
										;;
								esac

						clear
						echo "-----> PROMPT"
						echo "What Linux distro would you like to install?"
						echo "This Key: To Mark This Choice"
						echo "1 = Arch Linux (of course!)"
						echo "2 = Standard Debian Linux"
						echo "3 = Ubuntu Linux"
						echo "4 = Alpine Linux"
						echo "5 = Fedora Linux"
						echo "6 = openSUSE tumbleweed"
						echo "7 = openSUSE leap"
						echo "8 = Kali Linux"
						echo "C = Custom Distro"
						echo "L = List All Avalible Distros"
						echo "N = Quit"
						read -p "Choice: " -N 1 -r CHOICE
						case "$CHOICE" in
							1)
								INSTALL="archlinux"
								;;
							2)
								INSTALL="debian:13"
								;;
							3)
								INSTALL="ubuntu:latest"
								;;
							4)
								INSTALL="alpine"
								;;
							5)
								INSTALL="fedora"
								;;
							6)
								INSTALL="opensuse/tumbleweed"
								;;
							7)
								INSTALL="opensuse/leap"
								;;
							8)
								INSTALL="kalilinux/kali-rolling"
								;;
							c|C)
								read -p "Distro: " -r INSTALL
								;;
							l|L)
								clear
								echo "-----> PROMPT"
								echo "List of distros:"
								echo "---"
								proot-distro list
								echo "---"
								read -p "Distro: " -r INSTALL
								;;
							n|N)
								clear
								echo "User canceled"
								exit
								;;
							*)
								clear
								echo "User did not choose a valid option. Assuming they they chose to quit."
								exit
								;;
							esac
							clear
							echo "-----> PROCESS"
							echo "Installing your chosen distro...."
							echo "+++ This may take a while, don't assume it hung! +++"
							proot-distro install "$INSTALL" >/dev/null 2>&1
							case "$?" in
						        	0)
							        	echo "Success"
								        ;;
							        *)
								        echo "Failure! Exit Code $?."
								        echo "This Key: To Mark This Choice"
								        echo "C = Continue anyway"
								        echo "N = Quit now"
								        #
								        read -p "Choice: " -N 1 -r CHOICE
								        case "$CHOICE" in
								        	c|C)
									        	;;
									        n|N)
									        	clear
										        echo "User Canceled"
										        exit
										        ;;
									        *) 
										        clear
										        echo "Something went wrong, assuming user canceled."
										        exit
										        ;;
								        esac
						clear
						echo "-----> INFO"
						echo "Android PPK issue"
						echo ""
						echo "Android has a Phantom Process Killer that kills Termux and all its subprocesses"
						echo "if too many of them are running at the same time. That means you'll get many"
						echo "'Process completed (signal 9) press enter' Termux crashes. You can disable"
						echo "this depending on your Android version, but you'll have to do research on that"
						echo "at your own time because it requires developer options, and on some Android versions,"
						echo "adb."
						echo ""
						echo "This Key: To Mark This Choice"
						echo "Y = Continue"
						echo "N = Quit"
						read -p "Choice: " -N 1 -r CHOICE
						case "$CHOICE" in
							y|Y)
								clear
								echo "-----> PROMPT"
								echo "We will now log into your new enviornment to continue part 2"
								echo "of the setup."
								echo ""
								echo "This Key: To Mark This Choice"
								echo "Y = Continue"
								echo "N = Quit"
								read -p "Choice: " -N 1 -r CHOICE
								case "$CHOICE" in
									y|Y)
										clear
										echo "-----> OPERATION"
										echo "Loading Proot Enviorment to continue the setup. Please wait..."
										touch .distro.txt
										echo "$INSTALL" >> .distro.txt
										proot-distro login "$INSTALL" -- bash -c "cd $PWD && ./nextstep.sh"
										clear
										exit
										;;
									n|N)
										clear
										echo "User canceled"
										exit
										;;
									*)
										clear
										echo "Something went wrong, assuming user canceled."
										exit
										;;
						esac

								;;
							n|N)
								clear
								echo "User canceled"
								;;
							*)
								clear
								echo "User did not choose a valid option. Assuming they they chose to quit."
								;;
						esac
						;;
					n|N)
						clear
						echo "User canceled"
						;;
					*)
						clear 
						echo "User did not choose a valid option. Assuming they they chose to quit."
						;;
				esac		
				;;
			n|N)
				clear
				echo "User canceled"
				;;
			*)
				clear
				echo "User did not choose a valid option. Assuming they they chose to quit."
				;;
		esac
		
		;;
	n|N)
		clear
		echo "User canceled"
		;;
	*)
		clear
		echo "User did not choose a valid option. Assuming they chose to quit."
		;;
esac
esac
esac
esac
