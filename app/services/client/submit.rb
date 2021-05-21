module Client
  class Submit  < ApplicationService
    def initialize(webhook, callback_id, callback_value, callback_format)
      @webhook = webhook
      @callback_id = callback_id
      @callback_value = callback_value
      @callback_format = callback_format
    end

    def call
      begin
        url = @webhook.url
        api_key = @webhook.api_key
        callback_id = @callback_id
        callback_value = @callback_value
        callback_format = @callback_format
        headers = {}
        uri = URI.parse(url)
        http = Net::HTTP.new(uri.host, uri.port)
        response = http.post(uri.path, "callback_id=#{callback_id}&callback_value=#{callback_value}&callback_format=#{callback_format}&api_key=#{api_key}", headers)
      rescue => e
        Sidekiq.logger.info e
      ensure
        Sidekiq.logger.info response
      end
    end
  end
end