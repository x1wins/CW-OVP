module Percentage
  class Encode < ApplicationService

    def initialize(now_time, total_time)
      @now_time = now_time
      @total_time = total_time
    end

    def call
      encode_half_percentage(@now_time, @total_time)
    end

    private

    def encode_half_percentage now_time = nil, total_time = nil
      encode_percentage(now_time, total_time)/2
    end

    def encode_percentage now_time = nil, total_time = nil
      if now_time.nil? or total_time.nil?
        percentage = 0
      else
        percentage = (Percentage::ConvertToSecond.call(now_time) / Percentage::ConvertToSecond.call(total_time) * 100)
        percentage = 100 if percentage > 100
      end
      percentage
    end
  end
end