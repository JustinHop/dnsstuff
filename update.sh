#!/bin/bash
#===============================================================================
#
#          FILE:  trytoupdate.sh
# 
#         USAGE:  ./trytoupdate.sh 
# 
#   DESCRIPTION:  trys zsu if it fails then does zsh -cn
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR:  Justin Hoppensteadt (JH), Justin.Hoppensteadt@umgtemp.com
#       COMPANY:  Universal Music Group
#       VERSION:  1.0
#       CREATED:  09/30/2009 12:43:34 PM PDT
#      REVISION:  ---
#===============================================================================



for FILE in "$@" ; do
	if [ -e $FILE ]; then
		if zsu $FILE; then
			echo "updated $FILE"
			unix2dos $FILE
		else
			if zsu -cn $FILE ; then
				"updated and new format for $FILE"
			    unix2dos $FILE
			else
				echo "COULD NOT FIX $FILE"  
			fi
		fi
	fi
done

