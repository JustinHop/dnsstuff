#!/bin/bash
#===============================================================================
#
#          FILE:  showipandcname.sh
# 
#         USAGE:  ./showipandcname.sh 
# 
#   DESCRIPTION:  This will show all the A records pointing to a specified ip address
#   or range then everything
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR:  Justin Hoppensteadt (JH), Justin.Hoppensteadt@umgtemp.com
#       COMPANY:  Universal Music Group
#       VERSION:  1.0
#       CREATED:  10/08/2010 02:21:08 PM PDT
#      REVISION:  ---
#===============================================================================

for INPUT in "$@"; do
    # matching lines            .
    for A in $(egrep $INPUT\$ dns/*dns | perl -ne '/dns\/(.*)\.dns:(\S+).*\s(\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3})\s*$/; my $h=$2; my $d=$1; my $a=$3; 
        if ($h =~ /^\@$/) { print "$d:$a\n" } else { print "$h.$d:$a\n" }') ; do
            DNSNAME=$(echo $A | cut -d: -f1)
            IPADDR=$(echo $A | cut -d: -f2)
            echo -e "$DNSNAME\t->\t$IPADDR" 
            grep CNAME dns/*dns | egrep "$DNSNAME\.\$" | cut -d/ -f2 | awk '{ print $1 }' | perl -ne '/(.*).dns:(.*)$/; print "$2.$1\t->\t"'
            echo -e "$DNSNAME\t->\t$IPADDR" 
    done
done
