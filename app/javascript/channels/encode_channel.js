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
    console.log("encode_id: "+data.encode_id + " content:" + data.content + " percentage:" + data.percentage + "thumbnail_urls:"+ data.thumbnail_urls)
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
        var encode = data.encode;
        var filename = data.filename;
        var row = encodes_table.insertRow(1);
        row.setAttribute("id","encode_id");
        row.setAttribute("data-encode-id",encode.id);
        var id_cell = document.createElement('th');
        row.appendChild(id_cell);
        var title_cell = row.insertCell(1);
        var filename_cell = row.insertCell(2);
        var runtime_cell = row.insertCell(3);
        var url_cell = row.insertCell(4);
        var craeted_at_cell = row.insertCell(5);
        var completed_cell = row.insertCell(6);
        completed_cell.setAttribute("id","status_"+encode.id);
        var del_cell = row.insertCell(7);
        id_cell.innerHTML = encode.id;
        title_cell.innerHTML = encode.title;
        filename_cell.innerHTML = filename;
        runtime_cell.innerHTML = encode.runtime;
        url_cell.innerHTML = encode.url;
        craeted_at_cell.innerHTML = encode.created_at;
        completed_cell.innerHTML = encode.completed;
        del_cell.innerHTML = "";
      }

      var status = document.getElementById("status_"+data.encode_id);
      if(status){
        status.innerHTML = data.percentage
        if(data.percentage == '100%'){
          var encode = data.encode;
          var filename = data.filename;
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
          console.log("encode "+ encode)
          tds[1].innerHTML = filename;
          tds[2].innerHTML = encode.runtime;
          tds[3].innerHTML = encode.url;
          tds[5].innerHTML = encode.completed;
        }
      }
      return
    }

    var logs_table = document.getElementById("logs");
    var encode_id = document.getElementById("encode_id");
    var received_encode_id = data.encode_id;
    if(logs_table && encode_id && (encode_id.value == received_encode_id)){
      addThumbnailInShow(data.thumbnail_urls)
      encode = data.encode;
      var runtime = document.getElementById("runtime");
      runtime.innerHTML = encode.runtime;
      var progress = document.getElementById("progress");
      var progress_value = data.percentage.replace('%', '');
      progress.setAttribute("value", progress_value);
      var percentage = document.getElementById("percentage");
      percentage.innerHTML = data.percentage;

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
      scrollingLogContainerToBottom();
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

function addThumbnailInShow(thumbnail_urls){
  if(thumbnail_urls){
    var thumbnail_urls = thumbnail_urls.toString().split(',');
    var thumbnailContainer = document.getElementById("thumbnail-container")
    for(var i = 0; i < thumbnail_urls.length; i++){
      console.log("thumbnail_urls[i]" + thumbnail_urls[i])
      var img = document. createElement("img")
      img.src = thumbnail_urls[i]
      thumbnailContainer.appendChild(img);
    }
  }
}

document.addEventListener("turbolinks:load", function() {
  scrollingLogContainerToBottom();
});
