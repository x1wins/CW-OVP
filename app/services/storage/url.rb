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
      class Video < ApplicationService
        attr_reader :base_url

        def initialize(base_url)
          @base_url = base_url
        end

        def call
          "#{@base_url}/#{Path.hls_relative_path}/playlist.m3u8"
        end
      end

      class Thumbnail < ApplicationService
        attr_reader :base_url, :filename

        def initialize(base_url, filename)
          @base_url = base_url
          @filename = filename
        end

        def call
          "#{@base_url}/#{Path.thumbnail_relative_path}/#{@filename}"
        end
      end
    end
  end
end