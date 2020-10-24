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
    // console.log("data: "+JSON.stringify(data))
    var controller_name = document.getElementById("controller_name").value;
    var action_name = document.getElementById("action_name").value;
    if(controller_name == "encodes"){
      if(action_name == "index"){
        onEncodeIndex(data);
      }else if(action_name == "show"){
        onEncodeShow(data);
      }
    }
  }
});

function onEncodeIndex(data){
  var event = data.event
  var encode = data.body.encode
  var encodes_table = document.getElementById("encodes");
  if(encodes_table){
    var tr = document.querySelectorAll("[id='encode_id']");
    var count = 0;
    for(var i = 0; i < tr.length; i++){
      var data_encode_id = tr[i].getAttribute("data-encode-id")
      if(data_encode_id == encode.id){
        count ++;
      }
    }
    if(count == 0 && event == 'CREATED'){
      eventCreatedOnEncodeIndex(data, encodes_table)
    }else if(event == 'COMPLETED'){
      eventCompletedOnEncodeIndex(data)
    }else if(event == 'HLS_PROCESSING') {
      eventHlsProcessingOnEncodeIndex(data)
    }else if(event == 'THUMBNAIL_RAILS_URL'){
      eventThumbnailRailsUrlOnEncodeIndex(data)
    }
  }
}

function onEncodeShow(data){
  var event = data.event
  if(event == 'COMPLETED'){
    eventCompletedOnEncodeShow(data)
  }else if(event == 'HLS_PROCESSING') {
    eventHlsProcessingOnEncodeShow(data)
  }else if(event == 'THUNBNAIL_PROCESSING'){
    eventThunbnailProcessingOnEncodeShow(data)
  }else if(event == 'THUMBNAIL_CDN_URL'){
    eventThumbnailCdnUrlOnEncodeShow(data)
  }
  scrollingLogContainerToBottom();
}

function scrollingLogContainerToBottom(){
  var log_container = document.getElementById("log_container");
  if(log_container){
    log_container.scrollTop = log_container.scrollHeight;
  }
}

function addThumbnailInIndex(td, thumbnail_url){
  if(thumbnail_url){
    if(!td.hasChildNodes()){
      var img = document.createElement("img")
      img.src = thumbnail_url
      var figure = document.createElement("figure")
      figure.setAttribute("class","image is-32x32");
      figure.appendChild(img);
      td.appendChild(figure);
    }
  }
}

function findTdsEncode(encode){
  var tr = document.querySelectorAll("[id='encode_id']");
  var found_index = 0;
  for(var i = 0; i < tr.length; i++){
    var data_encode_id = tr[i].getAttribute("data-encode-id")
    if(data_encode_id == encode.id){
      found_index = i;
    }
  }
  var tds = tr[found_index].getElementsByTagName("td")
  return tds;
}

function eventCreatedOnEncodeIndex(data, encodes_table){
  var encode = data.body.encode
  var filename = data.body.filename
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

  var link_id = document.createElement("a")
  link_id.innerHTML = encode.id;
  link_id.className = "button is-success";
  link_id.setAttribute('href', "/encodes/"+encode.id);
  id_cell.appendChild(link_id);
  title_cell.innerHTML = encode.title;
  filename_cell.innerHTML = filename;
  runtime_cell.innerHTML = encode.runtime;
  url_cell.innerHTML = encode.url;
  craeted_at_cell.innerHTML = encode.created_at;
  completed_cell.innerHTML = encode.completed;
  del_cell.innerHTML = "";
}

function eventCompletedOnEncodeIndex(data){
  var encode = data.body.encode
  var tds = findTdsEncode(encode)
  tds[2].innerHTML = encode.runtime;
  tds[3].innerHTML = encode.url;
  tds[5].innerHTML = encode.completed;
}

function eventHlsProcessingOnEncodeIndex(data){
  var encode = data.body.encode
  var percentage = data.body.percentage
  var status = document.getElementById("status_"+encode.id);
  status.innerHTML = percentage
}

function eventThumbnailRailsUrlOnEncodeIndex(data){
  var encode = data.body.encode
  var thumbnail_url = data.body.thumbnail_url
  var tds = findTdsEncode(encode)
  addThumbnailInIndex(tds[6], thumbnail_url)
}

function eventCompletedOnEncodeShow(data){
  var encode = data.body.encode
  var ended_at = document.getElementById("ended_at");
  ended_at.innerHTML = encode.ended_at;
  var url = document.getElementById("url");
  url.innerHTML = encode.url;
  var completed = document.getElementById("completed");
  completed.innerHTML = encode.completed;
}

function eventHlsProcessingOnEncodeShow(data){
  var encode = data.body.encode
  var percentage = data.body.percentage
  var log = data.body.log
  var logs_table = document.getElementById("logs");
  var current_encode_id = document.getElementById("encode_id");
  var received_encode_id = encode.id;
  if(logs_table && current_encode_id && (current_encode_id.value == received_encode_id)) {
    var runtime = document.getElementById("runtime");
    runtime.innerHTML = encode.runtime;
    var progress = document.getElementById("progress");
    if (percentage) {
      var progress_value = percentage.replace('%', '');
      progress.setAttribute("value", progress_value);
      var percentage_element = document.getElementById("percentage");
      percentage_element.innerHTML = percentage;
    }
    var row = logs_table.insertRow(logs_table.size);
    var log_cell = row.insertCell(0);
    log_cell.innerHTML = log;
  }
}

function eventThunbnailProcessingOnEncodeShow(data){
  var thumbnail_url = data.body.thumbnail_url
  var thumbnailContainer = document.getElementById("thumbnail-container")
  var img = document.createElement("img")
  img.src = thumbnail_url
  thumbnailContainer.appendChild(img)
}

function eventThumbnailCdnUrlOnEncodeShow(data){
  var thumbnail_url = data.body.thumbnail_url
  var thumbnail = document.getElementById("thumbnail");
  thumbnail.innerHTML = thumbnail_url;
}

document.addEventListener("turbolinks:load", function() {
  scrollingLogContainerToBottom();
});
