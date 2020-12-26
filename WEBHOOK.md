## Webhook
* download file-post-server-py https://gist.github.com/kylemcdonald/3bb71e4b901c54073cbc#file-post-server-py
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

* Run sample post server for webhook
    ```
    % python post-server.py 
    serving at port 8000
    ```

* Test webhook server with curl
    ```
    % curl -i -X POST http://localhost:8000/posts -d a=b
    curl: (52) Empty reply from server
    ```