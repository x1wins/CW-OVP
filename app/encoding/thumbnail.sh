#!/bin/bash

# thumbnail
#encoding -i $1.mp4 -s 400x222 -ss 00:00:14.435 -vframes 1 out.png
ffmepg -i $1.mp4 -r 0.5 -f image2 output_%05d.jpg

