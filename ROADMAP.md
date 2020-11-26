## Roadmap
* Transcoding, Packaging
    * [x] processing percentage show
    * [x] extracting 10 thumbnail images
    * [x] transcoding, Packaging worker scale out with multiple node
    * [ ] webhook for http callback when transcoding, packaging complete
    * [ ] rest api for transcoding, packaging request with upload
    * [ ] Profile
        - Protocal
            - [x] hls
            - [ ] mpeg-dash
        - codec
            - [x] h.264
            - [ ] h.265
        - per 360p,480p,720p,1080p resolution transcoding, packaging to parallel distributed processing
* setting
    * [ ] webhook url config
    * [ ] apikey config for rest api authentication
* history with mongodb
* meta
    * [ ] category - tree structure
        * [ ] video node
* member
    * [ ] approved after join 