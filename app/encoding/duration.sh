#!/bin/bash

# Duration
ffmpeg -i $1.mp4 2>&1 | grep 'Duration' | cut -d ' ' -f 4 | sed s/,//
