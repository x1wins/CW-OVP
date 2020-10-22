module Percentage
  class ToString < ApplicationService
    attr_reader :percentage

    def initialize(percentage)
      @percentage = percentage
    end

    def call
      percentage_to_s(@percentage)
    end

    private
      def percentage_to_s percentage
        rount_off_two_decial_place(percentage).to_s + "%"
      end

      def rount_off_two_decial_place percentage
        '%.2f' % percentage
      end
  end
end