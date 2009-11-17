#!/bin/bash
#===============================================================================
#
#          FILE:  newzone.sh
# 
#         USAGE:  ./newzone.sh 
# 
#   DESCRIPTION:  Makes a new zone file
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR:  Justin Hoppensteadt (JH), Justin.Hoppensteadt@umgtemp.com
#       COMPANY:  Universal Music Group
#       VERSION:  1.0
#       CREATED:  11/17/2009 01:10:44 PM PST
#      REVISION:  ---
#===============================================================================

cd ~/NS1

BLANK=~/NS1/BLANK.COM.DNS

for ZONE in "$@" ; do
	echo "Creating Zone $ZONE"
	FILE="dns/$ZONE.dns"
	cp $BLANK $FILE
	perl -p -i -e "s!BLANK\.COM!"$ZONE"!g" $FILE
	perl -p -i -e "s!DNS!dns!g" $FILE
done

