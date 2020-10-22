module Percentage
  class ConvertToSecond < ApplicationService
    def initialize(time)
      @time = time
    end

    def call
      convert_to_second(@time)
    end

    private
      def convert_to_second time
        (Time.parse(time).to_i - Date.today.to_time.to_i).to_f
      end
  end
end