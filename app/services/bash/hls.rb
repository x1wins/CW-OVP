module Bash
  class Hls < ApplicationService
    def initialize(hls_local_full_path, uploaded_file_path)
      @hls_local_full_path = hls_local_full_path
      @uploaded_file_path = uploaded_file_path
    end

    def call
      "sh app/encoding/hls_h264.sh #{@hls_local_full_path} #{@uploaded_file_path}"
    end
  end
end