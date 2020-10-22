module Storage
  module Url
    module Relative
      class Hls < ApplicationService
        attr_reader :encode

        def initialize(encode)
          @encode = encode
        end

        def call
          "#{Storage::Dir::YyyyMmDdId.call(@encode)}/#{Storage::Dir::HLS}"
        end
      end

      class Thumbnail < ApplicationService
        attr_reader :encode

        def initialize(encode)
          @encode = encode
        end

        def call
          "#{Storage::Dir::YyyyMmDdId.call(@encode)}/#{Storage::Dir::THUMBNAIL}"
        end
      end
    end

    module Full
      class Hls < ApplicationService
        attr_reader :encode, :base_url

        def initialize(encode, base_url)
          @encode = encode
          @base_url = base_url
        end

        def call
          "#{@base_url}/#{Storage::Url::Relative::Hls.call(@encode)}/playlist.m3u8"
        end
      end

      class Thumbnail < ApplicationService
        attr_reader :encode, :base_url, :filename

        def initialize(encode, base_url, filename)
          @encode = encode
          @base_url = base_url
          @filename = filename
        end

        def call
          "#{@base_url}/#{Storage::Url::Relative::Thumbnail.call(@encode)}/#{@filename}"
        end
      end
    end
  end
end