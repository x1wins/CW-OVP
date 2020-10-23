module Message
  class Send < ApplicationService
    def initialize(event, body)
      @event = event
      @body = body
    end

    def call
      @message = @message.to_s+"\n" if @event == Message::Event::LOG
      ActionCable.server.broadcast "encode_channel", event: @event, body: @body
      Rails.logger.info "Send @message: #{@message}"
    end
  end
end