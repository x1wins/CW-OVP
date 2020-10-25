module Bash
  class CopyPlaylist < ApplicationService
    def initialize(hls_local_full_path)
      @hls_local_full_path = hls_local_full_path
    end

    def call
      `cp app/encoding/playlist.m3u8 #{@hls_local_full_path}/`
    end
  end
end