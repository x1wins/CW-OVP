class EncodeWorker
  include Sidekiq::Worker
  sidekiq_options retry: false # job will be discarded if it fails

  def perform(encode_id, base_url)
    encode = Encode.find(encode_id)
    if encode.file.attached?
      encode.file.open do |f|
        temp_file_full_path = f.path
        file_path = encode.file_path
        file_full_path = "public/#{file_path}"

        duration_output_cmd = `sh app/encoding/duration.sh #{temp_file_full_path}`
        encoding_cmd = "sh app/encoding/hls_h264.sh #{file_full_path} #{temp_file_full_path}"
        stdout, stderr, status = Open3.capture3(encoding_cmd)
        playlist_cp_cmd = `cp app/encoding/playlist.m3u8 #{file_full_path}/`

        log = "#{stdout} #{stderr} #{status} #{playlist_cp_cmd}"
        url = "#{base_url}/#{file_path}/playlist.m3u8"
        encode.update(log: log, ended_at: Time.now, runtime: duration_output_cmd, completed: true, url: url)

        Sidekiq.logger.debug "temp file path : #{temp_file_full_path}"
        Sidekiq.logger.debug "ffmpeg parameter : #{file_full_path} #{temp_file_full_path}"
        Sidekiq.logger.debug "output : #{duration_output_cmd}"
        Sidekiq.logger.debug "log : #{log}"
        Sidekiq.logger.debug "full url : #{url}"
      end
    end
  end
end