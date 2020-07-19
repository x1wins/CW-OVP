class EncodeChannel < ApplicationCable::Channel
  def subscribed
    stream_from "encode_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
