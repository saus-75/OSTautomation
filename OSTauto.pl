#!/usr/bin/perl -w

$url = $ARGV[0];

open U, "wget -q -O- $url|";

if (U ne " "){
    while ($line = <U>){
        if ($line =~ m/<td class=\"playlistDownloadSong\"><a href="(.*\.mp3)\">.*<\/a>/ig){
            $link = "https://downloads.khinsider.com/$1";
            open V, "wget -q -O- $link|";
            if (V ne " "){
                while ($dl = <V>){
                    if ($dl =~ m/<audio id=\"audio\" .* src=\"(https:.*\.mp3)\" >/ig){
                        print "Downloading... $1\n";
                        system "wget $1";
                    }
                }
            }
        }
    }
}