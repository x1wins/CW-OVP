module Storage
  module Dir
    RETURNS = [
        HLS = "hls",
        THUMBNAIL = "thumbnail",
        ROOT = "/storage"
    ]
    class YyyyMmDdId < ApplicationService
      attr_reader :encode

      def initialize(encode)
        @encode = encode
      end

      def call
        yyyy = @encode.created_at.strftime("%Y")
        mm = @encode.created_at.strftime("%m")
        dd = @encode.created_at.strftime("%d")
        id = @encode.id
        "#{yyyy}/#{mm}/#{dd}/#{id}"
      end
    end
  end
end
