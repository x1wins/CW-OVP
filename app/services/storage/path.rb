module Storage
  module Path
    module Local
      class Hls < ApplicationService
        def initialize(encode)
          @encode = encode
        end

        def call
          "#{Storage::Dir::ROOT}/#{@encode.id}_#{Storage::Dir::HLS}"
        end
      end

      class Thumbnail < ApplicationService
        def initialize(encode)
          @encode = encode
        end

        def call
          "#{Storage::Dir::ROOT}/#{@encode.id}_#{Storage::Dir::THUMBNAIL}"
        end
      end
    end
  end
end
