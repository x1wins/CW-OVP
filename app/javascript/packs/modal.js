document.addEventListener("turbolinks:load", function() {
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
