#!/bin/bash
# thumbnail
# ffmpeg -i SampleVideo_1280x720_5mb.mp4 -s 400x222 -ss 00:00:17.000 -vframes 1 out_13.png
ffmpeg -i $1 -s 640x360 -ss $2 -vframes 1 $3