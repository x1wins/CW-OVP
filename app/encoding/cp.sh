#!/bin/bash
#aws s3 cp /storage/encode/2020/10/09/44/thumbnail s3://vod-origin/encode/2020/10/09/44/thumbnail --recursive
aws s3 cp $3 s3://$1/$2
