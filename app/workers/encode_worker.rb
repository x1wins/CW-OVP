class EncodeWorker
  include Sidekiq::Worker
  sidekiq_options retry: false # job will be discarded if it fails

  def perform(encode_id, base_url)
    encode = Encode.find(encode_id)
    Sidekiq.logger.debug "encode_id : #{encode_id}"
    Sidekiq.logger.debug "id : #{encode.id}"
    Sidekiq.logger.debug "title : #{encode.title}"
    Sidekiq.logger.debug "file : #{encode.file}" if encode.file.attached?
    Sidekiq.logger.debug "file.blob.key : #{encode.file.blob.key}" if encode.file.attached?
    if encode.file.attached?
      encode.file.open do |f|
        temp_file_full_path = f.path
        duration_output = `sh app/encoding/duration.sh #{temp_file_full_path}`
        file_path = encode.file_path
        file_full_path = "public/#{file_path}"
        encoding_cmd = "sh app/encoding/hls_h264.sh #{file_full_path} #{temp_file_full_path}"
        stdout, stderr, status = Open3.capture3(encoding_cmd)
        encoding_output = "#{stdout} #{stderr} #{status}"
        url = "#{base_url}/#{file_path}/1080p.m3u8"
        encode.update(log: encoding_output, ended_at: Time.now, runtime: duration_output, completed: true, url: url)
        Sidekiq.logger.debug "temp file path : #{temp_file_full_path}"
        Sidekiq.logger.debug "ffmpeg parameter : #{file_full_path} #{temp_file_full_path}"
        Sidekiq.logger.debug "output : #{duration_output}"
        Sidekiq.logger.debug "encoding_output : #{encoding_output}"
        Sidekiq.logger.debug "full url : #{url}"
      end
    end
  end
end