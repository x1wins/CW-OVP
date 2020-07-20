import consumer from "./consumer"

consumer.subscriptions.create("EncodeChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
    console.log("Connected to Encode channel!");
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
    console.log("disconnected from Encode channel")
  },

  received(data) {
    // Called when there's incoming data on the websocket for this channel
    var encode_id = document.getElementById("encode_id");
    console.log("encode_id: " +encode_id.value)
    console.log("Recieving:")
    console.log(data.content)
    var content = data.content;
    var message = document.getElementById("messages");
    if(message){
      message.innerHTML += (content+"<br/>");
      var scrollingElement = (document.scrollingElement || document.body);
      scrollingElement.scrollTop = scrollingElement.scrollHeight;
    }
  }
});
