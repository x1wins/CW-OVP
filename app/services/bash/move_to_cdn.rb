module Bash
  class MoveToCdn < ApplicationService
    def initialize(cdn_bucket, relative_path, local_full_path)
      @cdn_bucket = cdn_bucket
      @relative_path = relative_path
      @local_full_path = local_full_path
    end

    def call
      "sh app/encoding/mv.sh #{@cdn_bucket} #{@relative_path} #{@local_full_path}"
    end
  end
end