#!/bin/zsh
#
#   Echos Files that have incorrect ns stuff

for FILE in "$@" ; do
	if [ -f "$FILE" ]; then
		if grep -P '^@\s+NS\s+ns1.umusic.com.' "$FILE" > /dev/null ; then
			if [ $DEBUG ]; then
				echo "Found ns1 in $FILE" > /dev/stderr 
			fi
			if grep -P '^@\s+NS\s+ns2.umusic.com.' "$FILE" > /dev/null  ; then
			    if [  $DEBUG ]; then
				    echo "Found ns2 in $FILE" > /dev/stderr 
			    fi
			    if grep -P '^@\s+NS\s+ns5.umusic.com.' "$FILE" > /dev/null  ; then
			        if [  $DEBUG ]; then
				        echo "Found ns5 in $FILE" > /dev/stderr 
			        fi
			    else
			        if [  $DEBUG ]; then
				        echo "!! No ns5 in $FILE" > /dev/stderr 
			        fi
			        echo $FILE 
			    fi
			else
			    if [  $DEBUG ]; then
				    echo "!! No ns2 in $FILE" > /dev/stderr 
			    fi
			    echo $FILE 
			fi
		fi
	fi
done
