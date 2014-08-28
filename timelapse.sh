#!/bin/bash

if [ $# -ne "3" ]
 then
	echo "HOW TO:"
	echo "./timelapse.sh <image_path> <video_size (nhd,hd720,hd108,4k...)> <frame_rate(img/sec)>"
	exit
fi
# change to image dir
cd $1
# backkup and rename images
mkdir "tmp"
i=0
ind=0000
for x in *.jpg ; do
  cp "$x" "tmp/timelapse_$ind.jpg"
  ((++i))
  ind=$i
  for d in 10 100 1000 ; do
    if [ $i -lt $d ]
    then
      ind=0$ind
    fi
  done
done

# start ffmpeg
ffmpeg -r $3 -i tmp/timelapse_%04d.jpg -s $2 -vcodec libx264 timelapse_$2.mp4
# remove backup...
rm -rf "tmp"

echo "timelapse file: $(pwd)/timelapse_$2.mp4"
cd -
