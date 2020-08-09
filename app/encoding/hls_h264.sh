#!/bin/bash

mkdir -p $1/360
mkdir -p $1/480
mkdir -p $1/720
mkdir -p $1/1080

echo "encoding start " $1 $2
ffmpeg -hide_banner -loglevel debug -i $2 \
  -vf scale=w=-2:h=360 -c:a aac -ar 48000 -c:v h264 -profile:v main -crf 20 -sc_threshold 0 -g 48 -keyint_min 48 -hls_time 4 -hls_playlist_type vod  -b:v 800k -maxrate 856k -bufsize 1200k -b:a 96k -hls_segment_filename $1/360/360p_%03d.ts $1/360/playlist.m3u8 \
  -vf scale=w=-2:h=480 -c:a aac -ar 48000 -c:v h264 -profile:v main -crf 20 -sc_threshold 0 -g 48 -keyint_min 48 -hls_time 4 -hls_playlist_type vod -b:v 1400k -maxrate 1498k -bufsize 2100k -b:a 128k -hls_segment_filename $1/480/480p_%03d.ts $1/480/playlist.m3u8 \
  -vf scale=w=-2:h=720 -c:a aac -ar 48000 -c:v h264 -profile:v main -crf 20 -sc_threshold 0 -g 48 -keyint_min 48 -hls_time 4 -hls_playlist_type vod -b:v 2800k -maxrate 2996k -bufsize 4200k -b:a 128k -hls_segment_filename $1/720/720p_%03d.ts $1/720/playlist.m3u8 \
  -vf scale=w=-2:h=1080 -c:a aac -ar 48000 -c:v h264 -profile:v main -crf 20 -sc_threshold 0 -g 48 -keyint_min 48 -hls_time 4 -hls_playlist_type vod -b:v 5000k -maxrate 5350k -bufsize 7500k -b:a 192k -hls_segment_filename $1/1080/1080p_%03d.ts $1/1080/playlist.m3u8 2>&1
echo "encoding done" $1 $2
