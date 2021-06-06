document.addEventListener("turbolinks:load", function() {
    console.log("turbolinks:load modal");
    var oldPlayer = document.getElementById('my-player');
    if(oldPlayer){
        videojs(oldPlayer).dispose();
    }
    var videoCntent = document.getElementById('video-content');
    if(videoCntent){
        v = buildVideo();
        videoCntent.append(v);
        var player = videojs(v);
    }

    const questionBlock = document.querySelector('a#open-modal');
    if(questionBlock == null){
        return;
    }
    questionBlock.addEventListener('click', function(event) {
        event.preventDefault();
        console.log("document.querySelector a#open-modal")
        var modal = document.querySelector('.modal');  // assuming you have only 1
        var html = document.querySelector('html');
        modal.classList.add('is-active');
        html.classList.add('is-clipped');

        modal.querySelector('.modal-background').addEventListener('click', function(e) {
            e.preventDefault();
            modal.classList.remove('is-active');
            html.classList.remove('is-clipped');
        });
    });
});

function buildVideo(){
    var obj, source;
    obj = document.createElement('video');
    obj.setAttribute('id', 'my-player');
    obj.setAttribute('class', 'video-js');
    obj.setAttribute('width', '640');
    obj.setAttribute('data-height', '264');
    obj.setAttribute('controls', ' ');
    obj.setAttribute('poster', '//vjs.zencdn.net/v/oceans.png');
    obj.setAttribute('preload', 'auto');
    obj.setAttribute('data-setup', '{}');
    source = document.createElement('source');
    source.setAttribute('type', 'video/mp4');
    source.setAttribute('src', '//vjs.zencdn.net/v/oceans.mp4');
    obj.append(source);
    return obj;
}