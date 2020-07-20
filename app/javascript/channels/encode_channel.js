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
    console.log("Recieving:")
    console.log("encode_id: "+data.encode_id + " content:" + data.content + " percentage:" + data.percentage)
    var encodes_table = document.getElementById("encodes");
    if(encodes_table){
      console.log("encodes_table exist")
      var status = document.getElementById("status_"+data.encode_id);
      if(status){
        status.innerHTML = data.percentage
      }
      return
    }

    var messages = document.getElementById("messages");
    var encode_id = document.getElementById("encode_id");
    if(messages && encode_id && (encode_id.value == data.encode_id)){
      var hidden_encode_id = encode_id.value;
      var received_encode_id = data.encode_id;
      console.log("hidden_encode_id == received_encode_id")
      var content = data.content;
      messages.innerHTML += (content+"<br/>");
      var scrollingElement = (document.scrollingElement || document.body);
      scrollingElement.scrollTop = scrollingElement.scrollHeight;
      return
    }
  }
});
