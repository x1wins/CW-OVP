class EncodeWorker
  include Sidekiq::Worker
  sidekiq_options retry: false # job will be discarded if it fails

  def perform(encode_id, base_url)
    encode = Encode.find(encode_id)
    if encode.file.attached?
      encode.file.open do |f|
        uploaded_file_path = f.path
        save_folder_path = encode.save_folder_path_hls
        runtime = `sh app/encoding/duration.sh #{uploaded_file_path}`
        mkdir_cmd = `sh app/encoding/mkdir.sh #{save_folder_path}`
        encoding_cmd = "sh app/encoding/hls_h264.sh #{save_folder_path} #{uploaded_file_path}"
        log = ""
        encode.update(runtime: runtime)
        Open3.popen3(encoding_cmd) do |stdin, stdout, stderr, wait_thr|
          stdout.each do |line|
            Sidekiq.logger.debug "stdout: #{line}"
            matched_time = line.to_s.match(/^frame=.+time=(\d{2,}:\d{2,}:\d{2,}.\d{2,}).+speed=\w+.\w+ /)
            unless matched_time.nil?
              unless matched_time.kind_of?(Array)
                status = matched_time[0]
                now_time = matched_time[1]
                percentage = encode.percentage(now_time.to_s, runtime.to_s)
                encode.send_message status, log, percentage
                Sidekiq.logger.info status + " now_time:" + now_time
              end
            end
          end
        end
        playlist_cp_cmd = `cp app/encoding/playlist.m3u8 #{save_folder_path}/`
        playlist_m3u8_url = encode.playlist_m3u8_url base_url
        encode.update(log: log, ended_at: Time.now, completed: true, url: playlist_m3u8_url)
        encode.send_message "Transcoding Completed", log, "100%"
        Sidekiq.logger.debug "uploaded file path : #{uploaded_file_path}"
        Sidekiq.logger.debug "ffmpeg parameter : #{save_folder_path} #{uploaded_file_path}"
        Sidekiq.logger.debug "output : #{runtime}"
        Sidekiq.logger.debug "log : #{log}"
        Sidekiq.logger.debug "playlist_m3u8_url : #{playlist_m3u8_url}"
      end
    end
  end
end