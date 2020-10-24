module Message
  class Send < ApplicationService
    def initialize(event, body)
      @event = event
      @body = body
    end

    def call
      ActionCable.server.broadcast "encode_channel", event: @event, body: @body
    end
  end
end