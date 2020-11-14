class ThumbnailWorker
  include Sidekiq::Worker
  sidekiq_options retry: false, backtrace: true

  def perform(encode_id)
    encode = Encode.find(encode_id)
    base_url = ENV['AWS_CLOUDFRONT_DOMAIN']
    if encode.file.attached?
      encode.file.open do |f|
        uploaded_file_path = f.path
        thumbnail_local_full_path = Storage::Path::Local::Thumbnail.call(encode)
        runtime = Bash::Runtime.call(uploaded_file_path)
        mkdir_cmd = Bash::Mkdir.call(thumbnail_local_full_path)
        thumbnail_seconds = encode.thumbnail_seconds runtime
        for i in 1..Encode::THUMBNAIL_COUNT
          ss = thumbnail_seconds[i-1]
          thumbnail_filename = encode.thumbnail_filename ss, i
          thumbnail_file_full_path = "#{thumbnail_local_full_path}/#{thumbnail_filename}"
          thumbnail_cmd = Bash::Thumbnail.call(uploaded_file_path, ss, thumbnail_file_full_path)
          thumbnail_url = Storage::Url::Full::Thumbnail.call(encode, base_url, thumbnail_filename)

          ActiveRecord::Base.connection_pool.release_connection
          ActiveRecord::Base.connection_pool.with_connection do
            encode.assets.create(format: 'image', url: thumbnail_url)
            encode.thumbnails.attach(io: File.open(thumbnail_file_full_path), filename: thumbnail_filename, content_type: "image/png")
          end
          message = "Extracted #{i}th Thumbnail"

          cdn_bucket = ENV['CDN_BUCKET']
          thumbnail_relative_path = Storage::Url::Relative::Thumbnail.call(encode)
          thumbnail_local_full_path = Storage::Path::Local::Thumbnail.call(encode)
          cdn_file_path = "#{thumbnail_relative_path}/#{thumbnail_filename}"
          cp_thumbnail_to_cdn_cmd = `sh app/encoding/cp.sh #{cdn_bucket} "#{cdn_file_path}" #{thumbnail_file_full_path}`
          Sidekiq.logger.info " cp_thumbnail_to_cdn_cmd #{cdn_bucket} #{cdn_file_path} #{thumbnail_file_full_path}"

          Message::Send.call(Message::Event::THUNBNAIL_PROCESSING, Message::Body.new(encode, nil, message, nil, thumbnail_url))
          if i == Encode::THUMBNAIL_COUNT
            message = "Completed Extracting Thumbnail"
            Message::Send.call(Message::Event::THUMBNAIL_RAILS_URL, Message::Body.new(encode, nil, message, nil, thumbnail_url))
          end
        end
      end

      cdn_bucket = ENV['CDN_BUCKET']
      thumbnail_relative_path = Storage::Url::Relative::Thumbnail.call(encode)
      thumbnail_local_full_path = Storage::Path::Local::Thumbnail.call(encode)
      rm_thumbnail_to_cdn_cmd = `sh app/encoding/rm.sh #{cdn_bucket} #{thumbnail_relative_path} #{thumbnail_local_full_path}`

      thumbnail_cdn_url = ""
      for asset in encode.assets
        thumbnail_cdn_url += (asset.url+"<br/>") if asset.format == 'image'
      end
      message = "Completed COPY Thumbnail To CDN"
      Message::Send.call(Message::Event::THUMBNAIL_CDN_URL, Message::Body.new(encode, nil, message, nil, thumbnail_cdn_url))
    end
  end
end