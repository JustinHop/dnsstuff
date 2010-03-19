#!/bin/zsh
#

if [[ -z $1 ]]; then
	exit 1
fi

for site in $(grep -P "$1" ./dns/*dns | perl -ne 's/\s/#/g; print $_ . "\n"';) ; 
do
    #echo $site; 
	if echo $site | grep -qsv in-addr.arpa ; then
        #echo $site; 
	    LINE=$(echo $site | tr '#' ' ' \
	    | perl -ne \
	    '/dns\/((?:\w|\.|-)+)\.dns:(\S+).*((?:\d{1,3}\.?){10})/; print "$2.$1 A $3 \n" ;'); 
	    echo ${LINE:s/@.//} ; 
	    for CN in $( grep -yP "CNAME\s+$(echo ${LINE:s/@.//} | awk '{ print $1 }')" dns/*dns \
	    	| perl -ne 's/\s/#/g;print "$_\n";' ); do
	    	#echo $CN
	    	echo $CN | tr '#' ' ' | perl -ne \
	        '/dns\/((?:\w|\.|-)+)\.dns:(\S+).*CNAME\s*(\S+)/; print "$2.$1 CNAME $3 \n" ;' 
	    done
	fi
done 
