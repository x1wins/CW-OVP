import consumer from "./consumer"

consumer.subscriptions.create("EncodeChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
    console.log("Connected to the room!");
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
    console.log("disconnected")
  },

  received(data) {
    // Called when there's incoming data on the websocket for this channel
    console.log("Recieving:")
    console.log(data.content)
    // document.getElementById("messages").append(data.content + "<br/>")
    var tag = "<div>" + data.content + "</div>"
    var message = document.getElementById("messages")
    if(message){
      message.innerHTML += tag
    }
  }
});
