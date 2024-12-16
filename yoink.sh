#!/bin/bash

###################################
# 20241216 yoink
# This script is a simple stitch to keep me from
# needing to remember to stitch video and audio
# from yt-dlp into a single mp4.
# The video format and audio format are hardcoded
# if you want different values, adjust them belwo
###################################

echo "Please enter your video URL: "
read "URL"
echo ""
echo "What do you want to final video file to be named? "
read "Filename"

# Run yt-dlp with hardcoded video format, dump file name to temp text file
yt-dlp -f 399 $URL > temp_video.txt
# Extract the actual filename for use later in script
video=$(cat temp_video.txt | grep Destination | awk -F": " '{print $2}')

# Run yt-dlp with hardcoded audio format, dump file name to temp text file
yt-dlp -f 140 $URL > temp_audio.txt
# Extract the actual filename for use later in script
audio=$(cat temp_audio.txt | grep Destination | awk -F": " '{print $2}')

# Use ffmpeg to smash the video file and audio file into a single mp4
ffmpeg -i "$video" -i "$audio" -c:a copy "$Filename".mp4

# Remove all temp files
rm "$video"
rm "$audio"
rm temp_video.txt
rm temp_audio.txt

exit
