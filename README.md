[![Build Status](https://travis-ci.com/x1wins/CW-OVP.svg?branch=develop)](https://travis-ci.com/x1wins/CW-OVP)

# CW-OVP
* [Introduction](#Introduction)
    * [EN](#EN)
    * [KO](#KO)
* [Skill Stack](#Skill-Stack)
* [Preview](#Preview)
* [Roadmap](#Roadmap)
* [Getting started](#Getting-started)
    * [How To Run Development mode](#How-To-Run-Development-mode)
    * [How To Run Development mode with Docker-compose](#How-To-Run-Development-mode-with-Docker-compose)

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
    
- Hosting
    * localhost
    * AWS S3, CloudFront - required Active storage config

## Preview
1. Encode Form, Show - realtime progress bar, logs
    ![show](/screenshot/cw_ovp_show.png)          
2. Encode Index - realtime percentage progress
    ![index](/screenshot/cw_ovp_index.png)

## Roadmap
* Transcoding
    * [x] processing percentage show
    * [ ] webhook - http callback call when transcoding complete
    * [ ] rest api, apikey, webhook id for transcoding request
    * [ ] transcoding worker scale out with multiple node
* setting
    * [ ] webhook url config
    * [ ] apikey config for rest api authentication
* history
* meta
    * [ ] tree category
        * [ ] video node
* member

## Getting started
### How To Run Development mode
1. Download source
    1. ```git clone https://github.com/x1wins/CW-OVP.git```
    2. ```cd ./CW-OVP```
    3. ```bundle install```
2. Database
    1. postgresql with docker
        ```bash
            mkdir $HOME/docker/volumes/cw_ovp_development
            docker run --rm --name cw_ovp_development \
                  --env-file .env.dev.procfile \
                  -v $HOME/docker/volumes/cw_ovp_development:/var/lib/postgresql/data \
                  -p 5432:5432 -d postgres            
            rake db:migrate
        ```
    2. redis with docker
        ```bash
            docker run --rm --name my-redis-container -p 6379:6379 -d redis
        ```
3. App server
    1. bundle & webpacker install
        ```bash
            bundle exec rails webpacker:install 
        ```
    2. rails server & sidekiq
        > http://railscasts.com/episodes/281-foreman
        ```bash
            yarn install --check-files
            bundle exec foreman start -e .env.dev.procfile    
        ```
4. open your web browser and connect ```http://localhost:3000```       
5. Testing
    ```bash
        bundle exec rspec --format documentation
    ```
    * result
        ```bash
            EncodesController
              GET #index
                returns a success response
              GET #show
                returns a success response
              GET #new
                returns a success response
              POST #create
                with valid params
                  creates a new Encode
                  redirects to the created encode
                with invalid params
                  returns a success response (i.e. to display the 'new' template)
              DELETE #destroy
                destroys the requested encode
                redirects to the encodes list
            
            EncodesController
              routing
                routes to #index
                routes to #new
                routes to #show
                routes to #create
                routes to #destroy
            
            encodes/index
              renders a list of encodes
            
            encodes/new
              renders new encode form
            
            encodes/show
              renders attributes in <p>
            
            Finished in 2.08 seconds (files took 2.29 seconds to load)
            16 examples, 0 failures
        ```
### How To Run Development mode with Docker-compose
1. Download source
    1. ```git clone https://github.com/x1wins/CW-OVP.git```
    2. ```cd ./CW-OVP```
2. Start docker-compose    
    1. ```docker-compose up --build -d```
    2. ```docker-compose run --no-deps web bundle exec rails webpacker:install```
    3. ```docker-compose run --no-deps web bundle exec rake db:migrate```
    4. ```docker-compose run --no-deps web bundle exec rake db:create RAILS_ENV=test```
    4. ```docker-compose run --no-deps web bundle exec rake db:migrate RAILS_ENV=test```
    5. ```docker-compose run --no-deps web bundle exec rspec --format documentation```
3. Restart for updated code
    1. ```git pull origin develop```
    2. ```git reset --hard origin/develop```
    3. ```docker-compose restart web```
             
