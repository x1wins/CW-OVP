[![Build Status](https://travis-ci.com/x1wins/CW-OVP.svg?branch=master)](https://travis-ci.com/x1wins/CW-OVP)

# CW-OVP
* [Preview](#Preview)
* [Introduction](#Introduction)
    * [EN](#EN)
    * [KO](#KO)
* [Skill Stack](#Skill-Stack)
* [Feature](#Feature)
* [System Structure](#System-Structure)
* [Getting started](#Getting-started)
    * [Storage config](#Storage-config)
    * [How To Run Development mode with Docker-compose](#How-To-Run-Development-mode-with-Docker-compose)
    * [How To Run Development mode without docker](#How-To-Run-Development-mode-without-docker)
    * [Sample video file download](#Sample-video-file-download)    
* [Minimum Requirements for Production](#Minimum-Requirements-for-Production)
* [Roadmap](#Roadmap)
* [Deploy](#Deploy)    
    * [Docker Swarm](#Docker-Swarm)    
    * [Kubernetes](#kubernetes)    

## Preview
![show](/screenshot/cw_ovp_show.png)          
![index](/screenshot/cw_ovp_index.png)

## Introduction
### EN
OVP(online video platform) mean that online transcoding, packaging and hosting service with video file upload to online storage or cloud system.<br/>
Internet speed was increase and many internet user prefer to streaming service for Mobile, web, OTT than service from over-the-air television networks.
but streaming service use OVP or solution for start streaming service with Mobile, web, OTT(over the top). 
such as OVP and some solution require many spend money for streaming service.<br/>
Famous OVP business company is brightcove.com, mux.com, dacast.com, vimeo.com, Dacast.com, Amazon elastic transcoding and Wowza solution.<br/>
CW-OVP project will commit helping for who want ready for streaming service.<br/>
This is why CW-OVP project was built.

### KO
OVP(online video platform)란<br/>
온라인 저장소 또는 클라우드에 비디오 파일을 업로드하여 트랜스코딩과 페키징 처리후 호스팅 서비스를 제공함을 말한다.<br/>
인터넷 속도의 발달과 사용자들의 요구로 많은 스트리밍 서비스가 생겨나고 있고, 기존의 방송사들도 흐름에 따라  Mobile, web, OTT(over the top) 셋탑기기의 스트리밍 서비스를 제공하기 위해서 OVP(online video platform)이나 솔류션을 많이 사용하고 있다.<br/>
대표적인 해외 OVP는 brightcove.com, mux.com, dacast.com, vimeo.com, Dacast.com, Amazon elastic transcoding 등 서비스들이 존재하며 솔류션으로는 Wowza가 존재한다.<br/>
이에 CW-OVP 프로젝트를 오픈소스로 개발하여 기업이나 단체, 개인에 도움이 되고자 한다.

## Skill Stack
|what use|description|
|---|---|
|FFMPEG|video transcoding, packaging|
|h.264|Codec|
|HLS|Protocol|
|Ruby on Rails|web framework, websocket(action cable)|
|Redis|queue, pub/sub|
|Sidekiq|background job, queue|
|Postresql|database|
|Docker, docker-compose|install environment|
|Docker Swarm|Clustering|
|Kubernetes|Clustering|
- you can choose Docker swarm or Kubernetes(kops or EKS) for Clustering

## Feature
- Clustering ffmpeg worker with sidekiq on Docker swarm or Kubernetes
- Transcoding, Packaging with ffmpeg for HLS
    - Generated multiple m3u8 for Adaptive Streaming
- Extract 10 random Thumbnail images during video packaging
- AWS S3 for stored video, thumbnail assets
- AWS Cloudfront for CDN
- Real time base on web UI with websocket(Action Cable), ruby on rails
- Open source (GPL-2.0 License) and Free, but need hardware…

## System Structure
![cw-ovp-system-structure.png](cw-ovp-system-structure.png)
- If your node for database that got fault or something wrong, You can lost persistent in database. that's why I recommend AWS RDS for postgresql. 

## Webhook
[Webhook](/WEBHOOK.md)

## Getting started
### Storage config
* AWS S3 Storage
    1. How to make s3 bucket for AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY
        - https://www.changwoo.org/x1wins@changwoo.net/2019-10-23/Upload-file-to-S3-with-AWS-CLI-d12442012c
    2. How to make cloudfront url for AWS_CLOUDFRONT_DOMAIN 
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
            ```
            docker-compose --env-file .env.dev.s3 config
            ```

### How To Run Development mode with Docker-compose
1. Download source
    1. ```git clone https://github.com/x1wins/CW-OVP.git```
    2. ```cd ./CW-OVP```
2. Build and Run    
    1. ```docker-compose --env-file .env.dev.s3 up --build -d```
    2. ```docker-compose run --no-deps web bundle exec rails webpacker:install```
    2. ```docker-compose --env-file .env.dev.s3 restart web```
    2. ```docker-compose run --no-deps web bundle exec rake db:create```
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
    ```
    docker-compose run --no-deps web bundle exec rspec --format documentation
    ```
5. Console
    ```
    docker-compose run --no-deps web bundle exec rails console
    ```
6. Troubleshooting 
    1. when I got bundle error such as ```minemagic```
        1. Log of minemagic gem error
            ```
            Step 10/16 : RUN bundle install
            ---> Running in 578d62fab6ac
            Fetching gem metadata from https://rubygems.org/............
            You have requested:
             mimemagic ~> 0.4.1
            The bundle currently has mimemagic locked at 0.3.5.
            Try running `bundle update mimemagic`
            If you are updating multiple gems in your Gemfile at once,
            try passing them all to `bundle update`
            ERROR: Service 'web' failed to build: The command '/bin/sh -c bundle install' returned a non-zero code: 7
            The command "docker-compose build" failed and exited with 1 during .
            Your build has been stopped.
            ```
        2. Solution
            ```
            docker-compose run --no-deps web bundle update mimemagic
            ```
    2. Keep latest gem for defense vulnerability
        ```
        docker-compose run --no-deps web bundle update
        ```
    3. no space left on device
        1. https://www.changwoo.org/x1wins@changwoo.net/2021-02-12/write-myapp-tmp-redis-appendonly-aof-9ff1127366
        1. Log
            ```
            % docker-compose --env-file .env.dev.s3 up --build
            Building web
            Step 1/16 : FROM ruby:2.6.3
             ---> 8fe6e1f7b421
            Step 2/16 : RUN curl -sL https://deb.nodesource.com/setup_12.x | bash - &&     curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - &&     echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list &&     apt-get update &&     apt-get install -qq -y build-essential nodejs yarn vim     libpq-dev postgresql-client ffmpeg
             ---> Using cache
             ---> 14eb2f07d9e5
            Step 3/16 : RUN apt-get update &&     apt-get install -y         python3         python3-pip         python3-setuptools         groff         less     && pip3 install --upgrade pip     && apt-get clean
             ---> Using cache
             ---> c57e46926299
            Step 4/16 : RUN pip3 --no-cache-dir install --upgrade awscli
             ---> Using cache
             ---> 7e8e641bfc90
            Step 5/16 : RUN mkdir /myapp
             ---> Using cache
             ---> a0a39c82945a
            Step 6/16 : RUN mkdir /storage
             ---> Using cache
             ---> 66348ad31ef0
            Step 7/16 : WORKDIR /myapp
             ---> Using cache
             ---> 47b601075951
            Step 8/16 : COPY . /myapp
            ERROR: Service 'web' failed to build : Error processing tar file(exit status 1): write /myapp/tmp/storage/og/op/ogopd3w9xnrwq0b6kqf8beh726xu: no space left on device
            ```
        2. Solution
            ```
            % docker system prune
            WARNING! This will remove:
              - all stopped containers
              - all networks not used by at least one container
              - all dangling images
              - all dangling build cache
            
            Are you sure you want to continue? [y/N] y
            ```
       

### How To Run Development mode without docker
[SETUP_WITHOUT_DOCKER.md](/SETUP_WITHOUT_DOCKER.md)       

### Sample video file download
- http://distribution.bbb3d.renderfarming.net/video/mp4/bbb_sunflower_1080p_30fps_normal.mp4              
- https://filesamples.com/samples/video/avi/sample_1920x1080.avi
- https://filesamples.com/samples/video/ts/sample_1920x1080.ts
- https://filesamples.com/samples/video/mp4/sample_1920x1080.mp4
- https://filesamples.com/samples/video/mkv/sample_1920x1080.mkv
- https://filesamples.com/samples/video/mov/sample_1920x1080.mov

## Minimum Requirements for Production
- Required AWS S3 for Storage
- Required AWS Cloudfront for CDN
- Server Spec
    - CPU
        - 8 or more Cpu per server (c5.2xlarge on aws ec2)
    - Disk
        - more 10 Gb
        - if you will upload heavy video or more 10Gb, need more space
    - Memory
        - more 2Gb
    - Number of Server
        - master : 1 or more
        - slave : 2 or more

## Roadmap
[Roadmap](/ROADMAP.md)
       
## Deploy
### Docker Swarm
[DOCKER-SWARM.md](/DOCKER-SWARM.md)

### kubernetes
[Setup k8s with kops](/k8s-manifests/SETUP_K8S.md)
