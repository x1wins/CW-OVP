# CW-OVP
## EN
OVP(online video platform) mean that online encoding and hosting service with movie file upload to online storage or cloud system.<br/>
Internet speed was increase and many internet user need streaming service than Content provier and Broadcaster use OVP or solution for start streaming service with Mobile, web, OTT(over the top).<br/>
Famous OVP business company is mux.com, dacast.com, vimeo.com, Dacast.com and Wowza solution.<br/>
But Korea OVP company is not many and company should spend more than thousand of dollar per month to OVP.<br/>
CW-OVP project will commit helping for who want ready for streaming service.<br/>
This is why CW-OVP project was built.

## KO
OVP(online video platform)란<br/>
온라인 저장소 또는 클라우드에 영상파일을 업로드하여 인코딩과 호스팅 서비스를 제공함을 말한다.<br/>
인터넷 속도의 발달과 사용자들의 요구로 많은 스트리밍 서비스가 생겨나고 있고, 기존의 방송사들도 흐름에 따라  Mobile, web, OTT(over the top) 셋탑기기의 스트리밍 서비스를 제공하기 위해서 OVP(online video platform)이나 솔류션을 많이 사용하고 있다.<br/>
대표적인 해외 OVP는 mux.com, dacast.com, vimeo.com, Dacast.com 등 서비스들이 존재하며 솔류션으로는 Wowza가 존재한다.<br/>
그러나 국산 OVP 서비스는 많은 활성화가 되어 있지 않고, 외산 서비스를 사용하면 인코딩 서비스만 한달에 수백, 수천만원 이상의 비용이 들어가며, 오픈소스로도 많이 존재 하지 않고 있다.<br/>
대부분의 스트리밍 서비스들은 OVP에 비싼 이용을 지불하여 비지니스를 진행하고 있다.<br/>
이에 오픈소스로 OVP를 개발하여 기업이나 단체, 개인에 도움이 되고자 한다.

## Skill Stack
1. Encoding
    * H.264
    * HLS
2. Hosting 
    * AWS S3, CloudFront
3. Skill Stack
    * FFMPEG : hls encoding
    * Ruby on Rails : web framework
    * Redis : cache, queue
    * Sidekiq : background job
    * Postresql or Cubrid : database
    * Docker, docker-compose, k8s

## Roadmap
* encoding
    * complete list
        * preview
    * processing list
        * log show
* history
* meta
    * tree category
        * movie node
* member

## How To Run Development mode
1. Download source
    1. ```git clone https://github.com/x1wins/CW-OVP.git```
    2. ```cd ./CW-OVP```
2. Database
    1. postgresql with docker
        ```bash
            rake docker:pg:init # postgrsql config set up
            rake docker:pg:run
            rake db:migrate
        ```
    2. redis with docker
        ```bash
            docker run --rm --name my-redis-container -p 7001:6379 -d redis
        ```
3. App server
    1. webpacker install
        ```bash
            bundle exec rails webpacker:install 
        ```
    2. rails server and sidekiq
        > http://railscasts.com/episodes/281-foreman
        ```bash
            bundle exec foreman start    
        ```
3. open your web browser and connect ```http://localhost:3000```       
