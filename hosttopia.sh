#!/bin/bash
#===============================================================================
#
#          FILE:  hosttopia.sh
# 
#         USAGE:  ./hosttopia.sh 
# 
#   DESCRIPTION:  do the changes to zone files for hosttopia
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR:  Justin Hoppensteadt (JH), Justin.Hoppensteadt@umgtemp.com
#       COMPANY:  Universal Music Group
#       VERSION:  1.0
#       CREATED:  09/18/2009 12:48:36 PM PDT
#      REVISION:  ---
#===============================================================================


for FILE in `cat hosttopia.list` ; do 
	UPDATE=0
	echo $FILE
	DNS="./dns/$FILE.dns"
	if [ -f $DNS ]; then
		if grep MX $DNS ; then
			echo "Already has dns"
		else
			cat hosttopia.mx >> $DNS
			UPDATE=1
		fi
		if grep webmail $DNS ; then
			echo "Already has webmail"
		else
			cat hosttopia.A >> $DNS
			UPDATE=1
		fi
		if (( $UPDATE > 0 )) ; then
			zsu $DNS
		fi
	fi
done

