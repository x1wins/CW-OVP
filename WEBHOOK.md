
begin
    callback_id = 1
    url = "http://localhost:8000/webhook"
    headers = {}
    uri = URI.parse(url)
    k = Net::HTTP.new(uri.host, uri.port)
    method = "post"
    if k.respond_to?(method)
        response = k.public_send(method, uri.path, "callback_id=#{callback_id}", headers) 
    end
rescue => e
    puts e
ensure
    puts response
end

