document.addEventListener("turbolinks:load", function() {
    console.log("turbolinks:load modal");
    var parentViewId = 'video-content';
    var playerId = 'my-player';
    var videoUrl = "https://d2zihajmogu5jn.cloudfront.net/bipbop-advanced/bipbop_16x9_variant.m3u8";
    var videoType = "application/x-mpegURL";
    var posterUrl = "";

    const questionBlock = document.querySelector('a#open-modal');
    if(questionBlock == null){
        return;
    }
    questionBlock.addEventListener('click', function(event) {
        event.preventDefault();
        console.log("document.querySelector a#open-modal");
        appendPlayer(parentViewId, playerId, videoUrl, videoType, posterUrl);
        var modal = document.querySelector('.modal');  // assuming you have only 1
        var html = document.querySelector('html');
        modal.classList.add('is-active');
        html.classList.add('is-clipped');
        var closeCompoments = modal.querySelectorAll('.modal-background, .modal-close.is-large');
        closeCompoments.forEach(function(compoment) {
            compoment.addEventListener('click', function(e) {
                e.preventDefault();
                removePlayer(playerId);
                modal.classList.remove('is-active');
                html.classList.remove('is-clipped');
            });
        });
    });
});

function removePlayer(playerId){
    var oldPlayer = document.getElementById(playerId);
    if(oldPlayer){
        videojs(oldPlayer).dispose();
    }
}

function appendPlayer(parentViewId, playerId, videoUrl, videoType, posterUrl) {
    removePlayer(playerId);
    var videoCntent = document.getElementById(parentViewId);
    if(videoCntent){
        v = buildVideo(videoUrl, videoType, posterUrl);
        videoCntent.append(v);
        var player = videojs(v);
    }
}

function buildVideo(videoUrl, videoType, posterUrl){
    var obj, source;
    obj = document.createElement('video');
    obj.setAttribute('id', 'my-player');
    obj.setAttribute('class', 'video-js');
    obj.setAttribute('width', '640');
    obj.setAttribute('data-height', '264');
    obj.setAttribute('controls', ' ');
    obj.setAttribute('poster', posterUrl);
    obj.setAttribute('preload', 'auto');
    obj.setAttribute('data-setup', '{}');
    source = document.createElement('source');
    source.setAttribute('type', videoType);
    source.setAttribute('src', videoUrl);
    obj.append(source);
    return obj;
}