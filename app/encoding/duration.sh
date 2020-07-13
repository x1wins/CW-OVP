#!/bin/bash

# Duration
ffmpeg -i $1 2>&1 | grep 'Duration' | cut -d ' ' -f 4 | sed s/,//

# Result
# ffmpeg -i 0000000003.ts 2>&1 | grep 'Duration' | cut -d ' ' -f 4 | sed s/,//
# 00:00:03.46