module Bash
  class Mkdir < ApplicationService
    def initialize(hls_local_full_path)
      @hls_local_full_path = hls_local_full_path
    end

    def call
      `sh app/encoding/mkdir.sh #{@hls_local_full_path}`
    end
  end
end