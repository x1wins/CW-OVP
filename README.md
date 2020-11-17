[![Build Status](https://travis-ci.com/x1wins/CW-OVP.svg?branch=master)](https://travis-ci.com/x1wins/CW-OVP)

# CW-OVP
* [Introduction](#Introduction)
    * [EN](#EN)
    * [KO](#KO)
* [Skill Stack](#Skill-Stack)
* [Preview](#Preview)
* [Feature](#Feature)
* [Roadmap](#Roadmap)
* [Getting started](#Getting-started)
    * [Storage config](#Storage-config)
    * [How To Run Development mode with Docker-compose](#How-To-Run-Development-mode-with-Docker-compose)
    * [How To Run Development mode without docker](#How-To-Run-Development-mode-without-docker)
* [Deploy](#Deploy)    
    * [Docker Swarm](#Docker-Swarm)    
    * [Docker Swarm with Jenkins](#Docker-Swarm-with-Jenkins)    
* [Sample video file download](#Sample-video-file-download)    

## Introduction
### EN
OVP(online video platform) mean that online encoding and hosting service with movie file upload to online storage or cloud system.<br/>
Internet speed was increase and many internet user need streaming service than Content provier and Broadcaster use OVP or solution for start streaming service with Mobile, web, OTT(over the top).<br/>
Famous OVP business company is mux.com, dacast.com, vimeo.com, Dacast.com and Wowza solution.<br/>
But Korea OVP company is not many and company should spend more than thousand of dollar per month to OVP.<br/>
CW-OVP project will commit helping for who want ready for streaming service.<br/>
This is why CW-OVP project was built.

### KO
OVP(online video platform)란<br/>
온라인 저장소 또는 클라우드에 영상파일을 업로드하여 인코딩과 호스팅 서비스를 제공함을 말한다.<br/>
인터넷 속도의 발달과 사용자들의 요구로 많은 스트리밍 서비스가 생겨나고 있고, 기존의 방송사들도 흐름에 따라  Mobile, web, OTT(over the top) 셋탑기기의 스트리밍 서비스를 제공하기 위해서 OVP(online video platform)이나 솔류션을 많이 사용하고 있다.<br/>
대표적인 해외 OVP는 mux.com, dacast.com, vimeo.com, Dacast.com 등 서비스들이 존재하며 솔류션으로는 Wowza가 존재한다.<br/>
그러나 국산 OVP 서비스는 많은 활성화가 되어 있지 않고, 외산 서비스를 사용하면 인코딩 서비스만 한달에 수백, 수천만원 이상의 비용이 들어가며, 오픈소스로도 많이 존재 하지 않고 있다.<br/>
대부분의 스트리밍 서비스들은 OVP에 비싼 이용을 지불하여 비지니스를 진행하고 있다.<br/>
이에 오픈소스로 OVP를 개발하여 기업이나 단체, 개인에 도움이 되고자 한다.

## Skill Stack
|what use|description|
|---|---|
|FFMPEG|video transcoding|
|h.264|Codec|
|HLS|playlist.m3u8|
|Ruby on Rails|web framework, websocket(action cable)|
|Redis|queue, pub/sub|
|Sidekiq|background job, queue|
|Postresql or Cubrid|database|
|Docker, docker-compose|install environment|

## Preview
![show](/screenshot/cw_ovp_show.png)          
![index](/screenshot/cw_ovp_index.png)

## Feature
- HLS Packaging encoding with ffmpeg
- Generate Adaptive Streaming
- Real time base on web UI with websocket(Action Cable), ruby on rails
- Open source(MIT licence) and Free, but need hardware…
- Clustering with docker swarm
- required AWS s3, cloudfront

## Roadmap
* Transcoding
    * [x] processing percentage show
    * [ ] webhook for http callback when transcoding complete
    * [ ] rest api for transcoding request with upload
    * [ ] transcoding worker scale out with multiple node
    * [ ] Profile
        - Protocal
            - [x] hls
            - [ ] mpeg-dash
        - codec
            - [x] h.264
            - [ ] h.265
        - per 360p,480p,720p,1080p resolution transcoding to parallel distributed processing
* setting
    * [ ] webhook url config
    * [ ] apikey config for rest api authentication
* history
* meta
    * [ ] category - tree structure
        * [ ] video node        
* member

## Getting started
### Storage config
* AWS S3 Storage
    1. How to make s3 bucket for AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY
        - https://www.changwoo.org/x1wins@changwoo.net/2019-10-23/Upload-file-to-S3-with-AWS-CLI-d12442012c
    2. How to make cloud front url for AWS_CLOUDFRONT_DOMAIN 
        - https://www.changwoo.org/x1wins@changwoo.net/2019-10-23/using-cloud-front-with-s3-51d2eb17bb
    3. Update ```.env.dev.s3``` file for s3, cloudfront
        1. open ```.env.dev.s3```
        2. add below of code and update each value                                                              
            ```
                AWS_ACCESS_KEY_ID=[Change key id]
                AWS_SECRET_ACCESS_KEY=[Change access key]
                REGION=[Change region (us-west-1 or us-west-2 or us-east-1...)]  
                BUCKET=[Change bucket]
                CDN_BUCKET=[Change cdn bucket]
                AWS_CLOUDFRONT_DOMAIN=[Change cdn domain]
            ```    
        3. Check config
            ```docker-compose --env-file .env.dev.s3 config```

### How To Run Development mode with Docker-compose
1. Download source
    1. ```git clone https://github.com/x1wins/CW-OVP.git```
    2. ```cd ./CW-OVP```
2. Build and Run    
    1. ```docker-compose --env-file .env.dev.s3 up --build -d```
    2. ```docker-compose run --no-deps web bundle exec rails webpacker:install```
    3. ```docker-compose run --no-deps web bundle exec rake db:migrate```
    4. ```docker-compose run --no-deps web bundle exec rake db:create RAILS_ENV=test```
    4. ```docker-compose run --no-deps web bundle exec rake db:migrate RAILS_ENV=test```
3. Restart for updated code
    1. ```git fetch origin develop```
    2. ```git reset --hard origin/develop```
    3. Restart web, sidekiq
        ```
        docker-compose --env-file .env.dev.s3 restart web
        docker-compose --env-file .env.dev.s3 restart sidekiq
        ```
4. Unit testing with rspec
    ```docker-compose run --no-deps web bundle exec rspec --format documentation```
5. Console
    ```docker-compose run --no-deps web bundle exec rails console```

### How To Run Development mode without docker    
[SETUP.md](/SETUP.md)       
       
## Deploy       
### Docker Swarm
[DOCKER-SWARM.md](/DOCKER-SWARM.md)

### Docker Swarm with Jenkins
[DOCKER-SWARM-JENKINS.md](/DOCKER-SWARM-JENKINS.md)

### Sample video file download
- http://distribution.bbb3d.renderfarming.net/video/mp4/bbb_sunflower_1080p_30fps_normal.mp4              
- https://filesamples.com/samples/video/avi/sample_1920x1080.avi
- https://filesamples.com/samples/video/ts/sample_1920x1080.ts
- https://filesamples.com/samples/video/mp4/sample_1920x1080.mp4
- https://filesamples.com/samples/video/mkv/sample_1920x1080.mkv
- https://filesamples.com/samples/video/mov/sample_1920x1080.mov
