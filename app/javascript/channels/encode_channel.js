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
      var tr = document.querySelectorAll("[id='encode_id']");
      var count = 0;
      console.log("tr.length : " + tr.length)
      for(var i = 0; i < tr.length; i++){
        var data_encode_id = tr[i].getAttribute("data-encode-id")
        if(data_encode_id == data.encode_id){
          count ++;
        }
      }
      if(count == 0){
        encode = data.encode;
        var row = encodes_table.insertRow(1);
        row.setAttribute("id","encode_id");
        row.setAttribute("data-encode-id",encode.id);
        var id_cell = document.createElement('th');
        row.appendChild(id_cell);
        var title_cell = row.insertCell(1);
        var craeted_at_cell = row.insertCell(2);
        var runtime_cell = row.insertCell(3);
        var completed_cell = row.insertCell(4);
        completed_cell.setAttribute("id","status_"+encode.id);
        var url_cell = row.insertCell(5);
        var show_cell = row.insertCell(6);
        var del_cell = row.insertCell(7);
        id_cell.innerHTML = encode.id;
        title_cell.innerHTML = encode.title;
        craeted_at_cell.innerHTML = encode.created_at;
        runtime_cell.innerHTML = encode.runtime;
        completed_cell.innerHTML = encode.completed;
        url_cell.innerHTML = encode.url;
        show_cell.innerHTML = "";
        del_cell.innerHTML = "";
      }

      var status = document.getElementById("status_"+data.encode_id);
      if(status){
        status.innerHTML = data.percentage
        if(data.percentage == '100%'){
          var encode = data.encode;
          var tr = document.querySelectorAll("[id='encode_id']");
          var found_index = 0;
          console.log("tr.length : " + tr.length)
          for(var i = 0; i < tr.length; i++){
            var data_encode_id = tr[i].getAttribute("data-encode-id")
            if(data_encode_id == encode.id){
              found_index = i;
            }
          }
          var tds = tr[found_index].getElementsByTagName("td")
          console.log("encode "+ encode.id + " "+ encode.runtime + " "+ encode.url)
          tds[2].innerHTML = encode.runtime;
          tds[3].innerHTML = encode.completed;
          tds[4].innerHTML = encode.url;
        }
      }
      return
    }

    var logs_table = document.getElementById("logs");
    var encode_id = document.getElementById("encode_id");
    var received_encode_id = data.encode_id;
    if(logs_table && encode_id && (encode_id.value == received_encode_id)){
      encode = data.encode;
      var runtime = document.getElementById("runtime");
      runtime.innerHTML = encode.runtime;
      var progress = document.getElementById("progress");
      var progress_value = data.percentage.replace('%', '');
      progress.setAttribute("value", progress_value);
      var percentage = document.getElementById("percentage");
      percentage.innerHTML = data.percentage;
      scrollingLogContainerToBottom();

      var content = data.content;
      var row = logs_table.insertRow(logs_table.size);
      var log_cell = row.insertCell(0);
      log_cell.innerHTML = content;

      if(encode.completed == true){
        console.log("completed");
        var ended_at = document.getElementById("ended_at");
        ended_at.innerHTML = encode.ended_at;
        var url = document.getElementById("url");
        url.innerHTML = encode.url;
        var completed = document.getElementById("completed");
        completed.innerHTML = encode.completed;
      }
      return
    }
  }
});

function scrollingLogContainerToBottom(){
  var log_container = document.getElementById("log_container");
  if(log_container){
    log_container.scrollTop = log_container.scrollHeight;
  }
}

document.addEventListener("turbolinks:load", function() {
  scrollingLogContainerToBottom();
});
