module Message
  class Send < ApplicationService
    def initialize(event, message, object)
      @event = event
      @message = message
      @object = object
    end

    def call
      @message = @message.to_s+"\n" if @event == Message::Event::LOG
      ActionCable.server.broadcast "encode_channel", event: @event, message: @message, object: @object
      Rails.logger.info "Send @message: #{@message}"
    end
  end
end