import videojs from 'video.js';

function removePlayer(playerId){
    var oldPlayer = document.getElementById(playerId);
    if(oldPlayer){
        videojs(oldPlayer).dispose();
    }
}

function appendPlayer(parentViewId, playerId, videoUrl, videoType, posterUrl) {
    removePlayer(playerId);
    var modalContent = document.getElementById(parentViewId);
    if(modalContent){
        var v = buildVideoElement(videoUrl, videoType, posterUrl);
        modalContent.append(v);
        var player = videojs(v);
    }
}

function buildVideoElement(videoUrl, videoType, posterUrl){
    var obj, source;
    obj = document.createElement('video');
    obj.setAttribute('id', 'my-player');
    obj.setAttribute('class', 'video-js vjs-theme-sea');
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

export { removePlayer, appendPlayer, buildVideoElement }