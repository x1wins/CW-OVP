class EncodeWorker
  include Sidekiq::Worker
  sidekiq_options retry: 0, backtrace: true

  def perform(encode_id)
    encode = Encode.find(encode_id)
    base_url = ENV['AWS_CLOUDFRONT_DOMAIN']
    if encode.file.attached?
      encode.file.open do |f|
        uploaded_file_path = f.path
        hls_local_full_path = Storage::Path::Local::Hls.call(encode)
        runtime = Bash::Runtime.call(uploaded_file_path)
        mkdir_cmd = Bash::Mkdir.call(hls_local_full_path)
        encoding_cmd = Bash::Hls.call(hls_local_full_path, uploaded_file_path)
        log = ""
        encode.update(runtime: runtime)
        Open3.popen3(encoding_cmd) do |stdin, stdout, stderr, wait_thr|
          stdout.each do |line|
            Sidekiq.logger.debug "stdout: #{line}"
            matched_time = line.to_s.match(/^frame=.+time=(\d{2,}:\d{2,}:\d{2,}.\d{2,}).+speed=\w+.\w+ /)
            unless matched_time.nil?
              unless matched_time.kind_of?(Array)
                message = matched_time[0]
                now_time = matched_time[1]
                percentage = Percentage::Encode.call(now_time.to_s, runtime.to_s)
                Message::Send.call(Message::Event::HLS_PROCESSING, Message::Body.new(encode, Percentage::ToString.call(percentage), message, nil, nil))
                log += message
                Sidekiq.logger.info message + " now_time:" + now_time
              end
            end
          end
        end

        playlist_cp_cmd = Bash::CopyPlaylist.call(hls_local_full_path)

        cdn_bucket = ENV['CDN_BUCKET']
        hls_relative_path = Storage::Url::Relative::Hls.call(encode)
        hls_local_full_path = Storage::Path::Local::Hls.call(encode)
        move_hls_to_cdn_cmd = Bash::MoveToCdn.call(cdn_bucket, hls_relative_path, hls_local_full_path)
        Sidekiq.logger.info "move_hls_to_cdn_cmd : #{move_hls_to_cdn_cmd}"
        total_file_count = 0
        Open3.popen3(move_hls_to_cdn_cmd) do |stdin, stdout, stderr, wait_thr|
          stdout.each_with_index do |line, index|
            Sidekiq.logger.info "aws mv: #{line}"
            matched_time = line.to_s.match(/Completed \d+.\d+ \w+\/\d+.\d+ \w+ \(\d+.\d+ \w+\/s\) with (\d+) file\(s\) remaining/)
            unless matched_time.nil?
              unless matched_time.kind_of?(Array)
                message = matched_time[0]
                file_number = matched_time[1].to_i - 1
                Sidekiq.logger.info "index: #{index} total_file_count: #{total_file_count} file_number: #{file_number}"
                if total_file_count == 0 or total_file_count < file_number
                  total_file_count = file_number
                  Sidekiq.logger.info "input total_file_count: #{total_file_count} file_number: #{file_number}"
                end
                percentage = 50 + Percentage::Cdn.call(total_file_count, file_number)
                Sidekiq.logger.info "percentage: #{percentage}"
                Message::Send.call(Message::Event::HLS_PROCESSING, Message::Body.new(encode, Percentage::ToString.call(percentage), message, nil, nil))
                log += message
                Sidekiq.logger.info message
              end
            end
          end
        end

        hls_url = Storage::Url::Full::Hls.call(encode, base_url)
        ActiveRecord::Base.connection_pool.release_connection
        ActiveRecord::Base.connection_pool.with_connection do
          encode.update(ended_at: Time.now, completed: true, url: hls_url)
          encode.assets.create(format: 'video', url: hls_url)
          encode.update(log: log)
        end
        Message::Send.call(Message::Event::COMPLETED, Message::Body.new(encode, Percentage::ToString.call(100), "Completed Move Local File To AWS S3", nil, nil))
      end
    end
  end
end