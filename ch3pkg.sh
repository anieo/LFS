#!/bin/bash
dwndir="packages"
if [ ! -d $dwndir ]; then
	mkdir $dwndir
fi

while read -u 3 -r link && read -u 4 -r md5sums; do
	b=$(basename $link)
	File="$dwndir/$b"

	wget -q -O $File $link;
	if [ -f $File ];then
		echo "$File Downloaded "
	else
		(>&2 echo "$File Not Downloaded ")
	fi
	
	a="$(md5sum $File|awk '{print $1}')"
	
	if [ $md5sums = $a ]; then
		echo "$File MD5 check OK";
	else
		echo "$File MD5 check failed";
	fi
done 3<downloadlinks.txt 4<md5sum.txt

