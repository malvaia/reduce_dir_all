#!/bin/bash

#Check if the dir variable is present and it exists
if [ -z "$1" ];
then
	echo "ERROR: You failed to provide a directory to reduce as first argument"
	exit 1
fi

if [ ! -d "$1" ];
then
	echo "ERROR: directory $1 not found"
	exit 2
fi

cd $1;
mkdir r_all;

#Count *.JPG files
#Echo convert process

count=$(ls -1 *.JPG | wc -l)
converted_count=0
percentage=0;
last_percentage=0;
cr='\r'; #used for the progress line rewrite

echo $count 'pictures with .JPG extension to reduce';

if [ $count -gt 0 ];
then
	for i in *.JPG; do
		convert "$i" -resize 37% -quality 88 r_all/$(basename "$i" .JPG).jpg;
		let converted_count++
		percentage=$(($converted_count*100/$count))

		#Cancel the progress bar line erase for the last file
		if [ $percentage == 100 ];
		then
			cr='\n';
		fi

		if [ $percentage != $last_percentage ];
		then
			last_percentage=$percentage
			echo -ne ' '$percentage'% complete - ('$converted_count'/'$count')'$cr
		fi
	done
else
	echo 'Nothing to convert, exiting'
	exit 3
fi

notify-send "$1 JPEG reduction completed. $converted_count image(s) reduced." -t 6000;
