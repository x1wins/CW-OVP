module Percentage
  class Cdn < ApplicationService
    def initialize(total_file_count, file_number)
      @total_file_count = total_file_count
      @file_number = file_number
    end

    def call
      cdn_cp_half_percentage @total_file_count, @file_number
    end

    private
      def cdn_cp_half_percentage total_file_count, file_number
        cdn_cp_percentage(total_file_count, file_number)/2
      end

      def cdn_cp_percentage total_file_count, file_number
        ((total_file_count - file_number).to_f / total_file_count.to_f * 100)
      end
  end
end