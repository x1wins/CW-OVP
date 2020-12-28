module Client
  class Submit  < ApplicationService
    def initialize(webhook, encode)
      @webhook = webhook
      @encode = encode
    end

    def call
      begin
        url = @webhook.url
        api_key = @webhook.api_key
        encode_id = @encode.id
        callback_id = @encode.callback_id
        headers = {}
        uri = URI.parse(url)
        http = Net::HTTP.new(uri.host, uri.port)
        response = http.post(uri.path, "encode_id=#{encode_id}&callback_id=#{callback_id}&api_key=#{api_key}", headers)
      rescue => e
        logger.info e
      ensure
        logger.info response
      end
    end
  end
end