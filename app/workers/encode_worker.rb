class EncodeWorker
  include Sidekiq::Worker
  sidekiq_options retry: false # job will be discarded if it fails

  def perform(encode_id, base_url)
    encode = Encode.find(encode_id)
    if encode.file.attached?
      encode.file.open do |f|
        uploaded_file_path = f.path
        hls_local_full_path = encode.hls_local_full_path
        runtime = `sh app/encoding/runtime.sh #{uploaded_file_path}`
        mkdir_cmd = `sh app/encoding/mkdir.sh #{hls_local_full_path}`
        encoding_cmd = "sh app/encoding/hls_h264.sh #{hls_local_full_path} #{uploaded_file_path}"
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
        playlist_cp_cmd = `cp app/encoding/playlist.m3u8 #{hls_local_full_path}/`
        video_url = encode.video_url base_url
        encode.update(log: log, ended_at: Time.now, completed: true, url: video_url)
        encode.assets.create(format: 'video', url: video_url)
        encode.send_message "Transcoding Completed", log, "100%"

        cdn_bucket = ENV['CDN_BUCKET']
        hls_relative_path = encode.hls_relative_path
        hls_local_full_path = encode.hls_local_full_path
        move_hls_to_cdn_cmd = "sh app/encoding/mv.sh #{cdn_bucket} #{hls_relative_path} #{hls_local_full_path}"
        Sidekiq.logger.info "move_hls_to_cdn_cmd : #{move_hls_to_cdn_cmd}"
        Open3.popen3(move_hls_to_cdn_cmd) do |stdin, stdout, stderr, wait_thr|
          stdout.each do |line|
            Sidekiq.logger.info "aws mv: #{line}"
            matched_time = line.to_s.match(/Completed .+ with (\d+) file.+ remaining/)
            unless matched_time.nil?
              unless matched_time.kind_of?(Array)
                status = matched_time[0]
                file_number = matched_time[1]
                encode.send_message status, log, nil
                if file_number.to_i == 1
                  encode.send_message "Move file To AWS S3  Completed", log, nil
                end
              end
            end
          end
        end

        encode.send_message "Copy HLS path to AWS S3", log, "100%", nil

        Sidekiq.logger.debug "move_hls_to_cdn_cmd : #{move_hls_to_cdn_cmd}"
        Sidekiq.logger.debug "ffmpeg parameter : #{hls_local_full_path} #{uploaded_file_path}"
        Sidekiq.logger.debug "output : #{runtime}"
        Sidekiq.logger.debug "log : #{log}"
        Sidekiq.logger.debug "video_url : #{video_url}"
      end
    end
  end
end