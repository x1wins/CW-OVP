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
        log = ""
        encode.send_message duration_output_cmd, log
        encode.send_message encoding_cmd, log
        Open3.popen3(encoding_cmd) do |stdin, stdout, stderr, wait_thr|
          stdout.each do |line|
            Sidekiq.logger.debug "stdout: #{line}"
            matched_time = line.to_s.match(/^frame=.+time=(\d{2,}:\d{2,}:\d{2,}.\d{2,}).+speed=\w+.\w+ /)
            unless matched_time.nil?
              unless matched_time.kind_of?(Array)
                status = matched_time[0]
                now_time = matched_time[1]
                percentage = encode.percentage(now_time.to_s, duration_output_cmd.to_s)
                encode.send_message status, log, percentage
                Sidekiq.logger.info status + " now_time:" + now_time
              end
            end
          end
        end

        playlist_cp_cmd = `cp app/encoding/playlist.m3u8 #{file_full_path}/`
        encode.send_message playlist_cp_cmd, log, "100%"
        url = "#{base_url}/#{file_path}/playlist.m3u8"
        encode.update(log: log, ended_at: Time.now, runtime: duration_output_cmd, completed: true, url: url)
        encode.send_message "Completed", log, "100%"

        Sidekiq.logger.debug "temp file path : #{temp_file_full_path}"
        Sidekiq.logger.debug "ffmpeg parameter : #{file_full_path} #{temp_file_full_path}"
        Sidekiq.logger.debug "output : #{duration_output_cmd}"
        Sidekiq.logger.debug "log : #{log}"
        Sidekiq.logger.debug "full url : #{url}"
      end
    end
  end
end