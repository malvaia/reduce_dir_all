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


sourceExtension='.JPG'
dirName='r_all';
convertedCount=0;
percentage=0;
previousPercentage=0;
cr='\r'; #used for the progress line rewrite


cd $1;
mkdir $dirName;

count=$(ls -1 *$sourceExtension | wc -l);

echo "$count picture(s) with $sourceExtension extension to reduce";

if [ $count -gt 0 ];
then
	for i in *$sourceExtension; do
		convert "$i" -resize 37% -quality 88 -auto-orient $dirName/$(basename "$i" $sourceExtension).jpg;  #use -strip to remove exif data
		let convertedCount++
		percentage=$(($convertedCount*100/$count))

		#Cancel the progress bar line erase for the last file
		if [ $percentage == 100 ];
		then
			cr='\n';
		fi

		if [ $percentage != $previousPercentage ];
		then
			previousPercentage=$percentage
			echo -ne ' '$percentage'% complete - ('$convertedCount'/'$count')'$cr
		fi
	done
else
	echo 'Nothing to convert, exiting'
	exit 3
fi

if command -v notify-send > /dev/null;
then
    notify-send "$1 $sourceExtension reduction completed. $convertedCount image(s) reduced." -t 6000;
fi
