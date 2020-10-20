# aws s3 cp
## bash log 
```
cw@Cwui-MacBookPro CW-OVP % aws s3 cp /Users/cw/Desktop/assets s3://vod-origin/assets --recursive --debug
upload: ../../Desktop/assets/Screen Shot 2020-09-18 at 11.49.29 PM.png to s3://vod-origin/assets/Screen Shot 2020-09-18 at 11.49.29 PM.png
upload: ../../Desktop/assets/Screen Shot 2020-09-18 at 4.03.07 PM.png to s3://vod-origin/assets/Screen Shot 2020-09-18 at 4.03.07 PM.png
upload: ../../Desktop/assets/Screen Shot 2020-09-18 at 4.03.45 PM.png to s3://vod-origin/assets/Screen Shot 2020-09-18 at 4.03.45 PM.png
```

## bash sample log
```
/Desktop/assets s3://vod-origin/assets --recursive
upload: ../../Desktop/assets/Screen Shot 2020-09-18 at 11.49.29 PM.png to s3://vod-origin/assets/Screen Shot 2020-09-18 at 11.49.29 PM.png
upload: ../../Desktop/assets/Screen Shot 2020-09-18 at 4.03.07 PM.png to s3://vod-origin/assets/Screen Shot 2020-09-18 at 4.03.07 PM.png
upload: ../../Desktop/assets/Screen Shot 2020-09-18 at 4.03.45 PM.png to s3://vod-origin/assets/Screen Shot 2020-09-18 at 4.03.45 PM.png
cw@Cwui-MacBookPro kooli % aws s3 cp /Users/cw/Desktop/assets s3://vod-origin/assets --recursive
upload: ../../Desktop/assets/Screen Shot 2020-09-18 at 11.49.29 PM.png to s3://vod-origin/assets/Screen Shot 2020-09-18 at 11.49.29 PM.png
upload: ../../Desktop/assets/Screen Shot 2020-09-18 at 4.03.07 PM.png to s3://vod-origin/assets/Screen Shot 2020-09-18 at 4.03.07 PM.png
Completed 3.7 MiB/4.0 MiB (787.7 KiB/s) with 1 file(s) remaining Completed 3.7 MiB/4.0 MiB (787.7 KiB/s) with 1 file(s) remaining Completed 3.7 MiB/4.0 MiB (787.7 KiB/s) with 1 file(s) remaining
```

## sidekiq log
```
move: ../storage/encode/2020/10/20/82/hls/480/480p_000.ts to s3://vod-hls/encode/2020/10/20/82/hls/480/480p_000.tss mv: Completed 286 Bytes/2.4 MiB (565 Bytes/s) with 117 file(s) remaining
move: ../storage/encode/2020/10/20/82/hls/1080/1080p_000.ts to s3://vod-hls/encode/2020/10/20/82/hls/1080/1080p_000.ts: Completed 369.5 KiB/2.4 MiB (5.9 KiB/s) with 6 file(s) remaining
move: ../storage/encode/2020/10/20/82/hls/playlist.m3u8 to s3://vod-hls/encode/2020/10/20/82/hls/playlist.m3u8: aws mv: Completed 1.5 MiB/2.4 MiB (12.4 KiB/s) with 5 file(s) remaining
move: ../storage/encode/2020/10/20/82/hls/360/360p_000.ts to s3://vod-hls/encode/2020/10/20/82/hls/360/360p_000.tss mv: Completed 1.5 MiB/2.4 MiB (12.2 KiB/s) with 4 file(s) remaining
move: ../storage/encode/2020/10/20/82/hls/720/720p_000.ts to s3://vod-hls/encode/2020/10/20/82/hls/720/720p_000.tss mv: Completed 1.7 MiB/2.4 MiB (8.4 KiB/s) with 3 file(s) remaining
move: ../storage/encode/2020/10/20/82/hls/1080/playlist.m3u8 to s3://vod-hls/encode/2020/10/20/82/hls/1080/playlist.m3u8Completed 2.4 MiB/2.4 MiB (11.1 KiB/s) with 2 file(s) remaining
sidekiq_1  | 2020-10-20T07:48:56.813Z pid=1 tid=gnzo3jafl class=EncodeWorker jid=0e5cea2687c8d6a370b6b54a INFO: aws mv: Completed 2.4 MiB/2.4 MiB (10.9 KiB/s) with 1 file(s) remaining
```

## bug log
```
Completed 1.9 MiB/2.4 MiB (805.7 KiB/s) with 2 file(s) remaining Completed 2.1 MiB/2.4 MiB (862.5 KiB/s) with 2 file(s) remaining Completed 2.2 MiB/2.4 MiB (637.0 KiB/s) with 2 file(s) remaining
```
