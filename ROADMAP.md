## Roadmap
* Transcoding, Packaging
    * [x] processing percentage show
    * [x] extracting 10 thumbnail images
    * [x] transcoding, Packaging worker scale out with multiple node
    * [x] webhook for http callback when packaging, thumbnail complete
    * [ ] Profile
        - Protocal
            - [x] hls
            - [ ] mpeg-dash
        - codec
            - [x] h.264
            - [ ] h.265
        - per 360p,480p,720p,1080p resolution transcoding, packaging to parallel distributed processing
* webhook
    * [x] CRUD webhook url, apikey, method, active
* meta
    * [ ] category - tree structure
        * [ ] video node
* rest api
    * [ ] /transcoding? multipart upload
    * [ ] /video?callback_id={callback_id}
    * [ ] /thumbnail?callback_id={callback_id}
    * [ ] categories
    * [ ] apikey config for rest api authentication
* member
    * [ ] admin, user role
    * [ ] user list, edit 
        * [ ] https://github.com/danweller18/devise/wiki/Allow-Users-to-View-Profile-and-List-All-Users
        * [ ] https://wajeeh-ahsan.medium.com/list-all-users-and-user-profile-with-devise-in-rails-d5e563bb1e48
    * [ ] approved after join https://github.com/heartcombo/devise/wiki/How-To:-Require-admin-to-activate-account-before-sign_in
    * [ ] reCAPTCHA https://github.com/heartcombo/devise/wiki/How-To:-Use-Recaptcha-with-Devise
* history with mongodb
* statics