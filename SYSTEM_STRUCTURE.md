```
--------------------------------------
|mater node                          |
|------- ------------ ---------------|
||redis| |postgresql| |rails for web||  
|------- ------------ ---------------|
--------------------------------------    
```

Scale out with Docker Swarm
===========================
|master node|slave-1 node|slave-2 node|you can scale out slave node...|
|---|---|---|---|
|redis|sidekiq|sidekiq|sidekiq...|
| |ffmpeg|ffmpeg|ffmpeg...|
|postgresql||||
|rails for web||||