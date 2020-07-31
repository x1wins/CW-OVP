#!/bin/bash
# thumbnail
# ffmpeg -i SampleVideo_1280x720_5mb.mp4 -vf scale=w=-2:h=360 -ss 00:00:17.000 -vframes 1 out_13.png
ffmpeg -i $1 -vf scale=w=-2:h=360 -ss $2 -vframes 1 $3