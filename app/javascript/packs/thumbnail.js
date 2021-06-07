function appendThumbnails(thumbnails, parentViewId) {
    thumbnails.forEach(function(asset) {
        if(asset.format == 'image'){
            var url = asset.url;
            var img = document.createElement('img');
            img.setAttribute('src', url);
            var modalContent = document.getElementById(parentViewId);
            modalContent.append(img);
        }
    });
}

export { appendThumbnails }