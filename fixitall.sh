#!/bin/bash
#===============================================================================
#
#          FILE:  fixitall.sh
# 
#         USAGE:  ./fixitall.sh 
# 
#   DESCRIPTION:  
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR:  Justin Hoppensteadt (JH), Justin.Hoppensteadt@umgtemp.com
#       COMPANY:  Universal Music Group
#       VERSION:  1.0
#       CREATED:  10/01/2009 07:02:33 PM PDT
#      REVISION:  ---
#===============================================================================

for FILE in "$@" ; do
	backup "$FILE"
	if ./addns.pl "$FILE" ; then
		if zsu "$FILE" ; then
			echo "$FILE timestamped"
		else
		    if zsu -c "$FILE" ; then
			    echo "$FILE -c timestamped"
		    else
		        if zsu -cn "$FILE" ; then
			        echo "$FILE -cn timestamped"
			    else
			    	exit 1
			    fi
			fi
		fi
	fi
done

