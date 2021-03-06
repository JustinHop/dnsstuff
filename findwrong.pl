#!/usr/bin/perl
#===============================================================================
#
#         FILE:  addns.pl
#
#        USAGE:  ./addns.pl  [files]
#
#  DESCRIPTION:  will add the nameserver entries to zonefiles and www to root
#
#      OPTIONS:  ---
# REQUIREMENTS:  ---
#         BUGS:  ---
#        NOTES:  ---
#       AUTHOR:  Justin Hoppensteadt (JH), Justin.Hoppensteadt@umgtemp.com
#      COMPANY:  Universal Music Group
#      VERSION:  1.0
#      CREATED:  09/30/2009 11:54:34 AM
#     REVISION:  ---
#===============================================================================

use strict;
use warnings;

use re 'debug';
use File::Slurp;

my $fullrec = <<EONS
;
;  Zone NS records
;


@                       NS	ns1.umusic.com.
ns1.umusic.com.         A	167.167.1.141
@                       NS	ns2.umusic.com.
ns2.umusic.com.         A	167.167.9.132
@                       NS	ns5.umusic.com.
ns5.umusic.com.         A	167.167.1.132

;
;  Zone records
;
EONS
  ;

my $partrec = <<EOPNS
;
;  Zone NS records
;


@                       NS	ns1.umusic.com.

;
; Zone records
;
EOPNS
  ;

my $debug = 0;

for my $file (@ARGV) {
    if ( -e $file ) {
        my $zonename = $file;
        $zonename =~ s/.dns$//;
        $zonename =~ s!^.*/!!;

        my $update = 0;

        my $zone = read_file($file);

            # (^ns\d\.umusic\.com\.\s+A\s+\d{3}\.\d{3}\.\d\.\d{3}.*$)
        #print $zone;
        if (
            $zone =~ m{(@\s+NS\s+ns\d\.umusic\.com\.)}x
          )
        {
            print "$zonename is all good\n$1\n";

        } else {
            print "$zonename is SHIT  \n";
        }
    }
}

