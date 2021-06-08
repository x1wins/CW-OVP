import TimeAgo from 'javascript-time-ago'
import en from 'javascript-time-ago/locale/en'

TimeAgo.addDefaultLocale(en)
const timeAgo = new TimeAgo('en-US')

document.addEventListener("turbolinks:load", function() {
    console.log("turbolinks:load modal");
    var createdAts = document.querySelectorAll('td#created-at');
    if (createdAts) {
        createdAts.forEach(function (createdAt) {
            var date = new Date(createdAt.textContent);
            var timeAgoText = timeAgo.format(date);
            createdAt.innerHTML += ("<br/>" + timeAgoText);
            console.log("timeAgo : " + timeAgoText);
        });
    }
});