// direct_uploads.js

addEventListener("direct-upload:initialize", event => {
    console.log("direct-upload:initialize")
    const { target, detail } = event
    const { id, file } = detail
    target.insertAdjacentHTML("beforebegin", `<span class="direct-upload__filename">${file.name}</span>`)
})

addEventListener("direct-upload:start", event => {
    console.log("direct-upload:start")
    const { id } = event.detail
})

addEventListener("direct-upload:progress", event => {
    console.log("direct-upload:progress")
    const { id, progress } = event.detail
    changeProgress(progress)
})

addEventListener("direct-upload:error", event => {
    console.log("direct-upload:error")
    event.preventDefault()
    const { id, error } = event.detail
    const element = document.getElementById(`direct-upload-error`)
    element.classList.add("notification is-danger")
    element.innerText = error;
})

addEventListener("direct-upload:end", event => {
    console.log("direct-upload:end")
    const { id } = event.detail
})

addEventListener("turbolinks:load", function() {
    console.log('It works on each visit!');
    console.log("turbolinks:load!");
    const encodeFileElement = document.getElementById('encode_file')
    if(encodeFileElement.value){
        console.log("encodeFileElement value exist "+ encodeFileElement.value);
        changeProgress(100)
    }
});

function changeProgress(progress) {
    const percentageElement = document.getElementById(`file-upload-percentage`)
    const progressElement = document.getElementById(`file-upload-progress`)
    percentageElement.innerText = `${progress.toFixed(2)}%`
    progressElement.value = `${progress}`
}