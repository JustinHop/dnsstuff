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
	dos2unix "$FILE"
	if ./addns.pl "$FILE" > /dev/null ; then
		echo "Updating $FILE"
		backup "$FILE"
		mv "$FILE" "$FILE-"
		./addns.pl "$FILE-" > "$FILE"
		if zsu "$FILE" ; then
			echo "$FILE UPDATED"
		else
		    if zsu -c "$FILE" ; then
			    echo "$FILE -c UPDATED"
		    else
		        if zsu -cn "$FILE" ; then
			        echo "$FILE -cn UPDATED"
			    else
			    	mv "$FILE-" "$FILE"
			    	echo "$FILE NOT UPDATED"
			    fi
			fi
		fi
	fi
	unix2dos "$FILE"
done

