#!/usr/bin/perl -w

$url = $ARGV[0];

open U, "wget -q -O- $url|";

if (U ne " "){
    while ($line = <U>){
        if ($line =~ m/\.mp3.*<\/a>/ig){
            $line =~ s/<td>//g;
            $line =~ s/^[\t]*//g;
            $line =~ s/<a href="//g;
            $line =~ s/">.*//g;
            #print "Wgetting this site $line\n";
            open V, "wget -q -O- $line|";
            if (V ne " "){
                while ($dl = <V>){
                    if ($dl =~ m/Download to Computer/ig){
                        $dl =~ s/.* href="//g;
                        $dl =~ s/">Download.*//g;
                        #print "Ripping this file $dl";
                        system "wget $dl";
                        print $dl;
                    }
                }
            }
        }
    }
}