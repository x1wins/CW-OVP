class EncodeWorker
  include Sidekiq::Worker
  sidekiq_options retry: false # job will be discarded if it fails

  def perform(encode_id, base_url)
    encode = Encode.find(encode_id)
    if encode.file.attached?
      encode.file.open do |f|
        uploaded_file_path = f.path
        hls_local_full_path = Storage::Path::Local::Hls.call(encode)
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
                percentage = Percentage::Encode.call(now_time.to_s, runtime.to_s)
                encode.send_message status, log, Percentage::ToString.call(percentage)
                Sidekiq.logger.info status + " now_time:" + now_time
              end
            end
          end
        end

        playlist_cp_cmd = `cp app/encoding/playlist.m3u8 #{hls_local_full_path}/`

        cdn_bucket = ENV['CDN_BUCKET']
        hls_relative_path = Storage::Url::Relative::Hls.call(encode)
        hls_local_full_path = Storage::Path::Local::Hls.call(encode)
        move_hls_to_cdn_cmd = "sh app/encoding/mv.sh #{cdn_bucket} #{hls_relative_path} #{hls_local_full_path}"
        Sidekiq.logger.info "move_hls_to_cdn_cmd : #{move_hls_to_cdn_cmd}"
        total_file_count = 0
        Open3.popen3(move_hls_to_cdn_cmd) do |stdin, stdout, stderr, wait_thr|
          stdout.each_with_index do |line, index|
            Sidekiq.logger.info "aws mv: #{line}"
            matched_time = line.to_s.match(/Completed \d+.\d+ \w+\/\d+.\d+ \w+ \(\d+.\d+ \w+\/s\) with (\d+) file\(s\) remaining/)
            unless matched_time.nil?
              unless matched_time.kind_of?(Array)
                status = matched_time[0]
                file_number = matched_time[1].to_i - 1
                if index == 0
                  total_file_count = file_number
                end
                percentage = 50 + Percentage::Cdn.call(total_file_count, file_number)
                encode.send_message status, log, Percentage::ToString.call(percentage)
              end
            end
          end
        end

        hls_url = Storage::Url::Full::Hls.call(encode, base_url)
        encode.update(log: log, ended_at: Time.now, completed: true, url: hls_url)
        encode.assets.create(format: 'video', url: hls_url)
        encode.send_message "Completed Move Local File To AWS S3", log, "100%"

        Sidekiq.logger.debug "move_hls_to_cdn_cmd : #{move_hls_to_cdn_cmd}"
        Sidekiq.logger.debug "ffmpeg parameter : #{hls_local_full_path} #{uploaded_file_path}"
        Sidekiq.logger.debug "output : #{runtime}"
        Sidekiq.logger.debug "log : #{log}"
        Sidekiq.logger.debug "video_url : #{hls_url}"
      end
    end
  end
end