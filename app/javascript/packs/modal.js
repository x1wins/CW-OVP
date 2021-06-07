import { appendThumbnails } from './thumbnail'
import { appendPlayer, removePlayer } from './video'

document.addEventListener("turbolinks:load", function() {
    console.log("turbolinks:load modal");
    var parentViewId = 'modal-content';
    var playerId = 'my-player';
    var videoUrl = "https://d2zihajmogu5jn.cloudfront.net/bipbop-advanced/bipbop_16x9_variant.m3u8";
    var videoType = "application/x-mpegURL";
    var posterUrl = "";

    var thumbnailLinkToOpenModals = document.querySelectorAll('a#open-thumbnail-modal');
    thumbnailLinkToOpenModals.forEach(function(link) {
        link.addEventListener('click', function(e) {
            e.preventDefault();
            var dataThumbnails = this.getAttribute("data-thumbnails");
            var thumbnails = JSON.parse(dataThumbnails);
            appendThumbnails(thumbnails, parentViewId);
            var modal = document.querySelector('.modal');  // assuming you have only 1
            var html = document.querySelector('html');
            modal.classList.add('is-active');
            html.classList.add('is-clipped');
            var closeCompoments = modal.querySelectorAll('.modal-background, .modal-close.is-large');
            closeCompoments.forEach(function(compoment) {
                compoment.addEventListener('click', function(e) {
                    e.preventDefault();
                    var modalContent = document.getElementById(parentViewId);
                    while (modalContent.firstChild) {
                        modalContent.removeChild(modalContent.lastChild);
                    }
                    modal.classList.remove('is-active');
                    html.classList.remove('is-clipped');
                });
            });
        });
    });

    var playLinkToOpenModals = document.querySelectorAll('a#open-play-modal');
    playLinkToOpenModals.forEach(function(link) {
        link.addEventListener('click', function(e) {
            e.preventDefault();
            console.log("data-video" + this.getAttribute("data-video"));
            console.log("data-poster" + this.getAttribute("data-poster"));
            console.log("document.querySelector a#open-modal");
            videoUrl = this.getAttribute("data-video");
            posterUrl = this.getAttribute("data-poster");
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
});
