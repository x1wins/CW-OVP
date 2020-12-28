## Webhook
### Example Webhook Server
* download post-server.py https://gist.github.com/kylemcdonald/3bb71e4b901c54073cbc
    ```
    import SimpleHTTPServer
    import SocketServer
    
    PORT = 8000
    
    class ServerHandler(SimpleHTTPServer.SimpleHTTPRequestHandler):
    
        def do_POST(self):
          content_len = int(self.headers.getheader('content-length', 0))
          post_body = self.rfile.read(content_len)
          print post_body
    
    Handler = ServerHandler
    
    httpd = SocketServer.TCPServer(("", PORT), Handler)
    
    print "serving at port", PORT
    httpd.serve_forever()
    ```

* Run sample post method server for webhook
    ```
    % python post-server.py 
    serving at port 8000
    ```
  
### Example Webhook Client  
* ruby client
    ```
    % irb
    require 'net/http'
    require 'uri'
    
    begin
        headers = {'Cookie' => 'mycookieinformationinhere'}
        uri = URI.parse("http://localhost:8000/webhook")
        http = Net::HTTP.new(uri.host, uri.port)
        response = http.post(uri.path, "test=test&a=ruby&b=python&apikey=samplekey", headers)
    rescue => e
        puts e
        puts "rescue"
    ensure
        puts "ensure #{response}"
    end
    ```
    ```
    # result
    % python post-server.py
    serving at port 8000
    a=ruby&b=python&apikey=samplekey
    ```

* curl
    ```
    % curl -i -X POST http://localhost:8000/webhook -d a=b
    curl: (52) Empty reply from server
    ```
    
    ```
    # result
    % python post-server.py
    serving at port 8000
    a=b
    ```