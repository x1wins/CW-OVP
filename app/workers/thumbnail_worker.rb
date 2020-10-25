class ThumbnailWorker
  include Sidekiq::Worker
  sidekiq_options retry: false # job will be discarded if it fails

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
          encode.assets.create(format: 'image', url: thumbnail_url)
          encode.thumbnails.attach(io: File.open(thumbnail_file_full_path), filename: thumbnail_filename, content_type: "image/png")
          thumbnail_rails_url = Rails.application.routes.url_helpers.rails_blob_path(encode.thumbnails.last, disposition: "attachment", only_path: true)
          message = "Extracted #{i}th Thumbnail"
          Message::Send.call(Message::Event::THUNBNAIL_PROCESSING, Message::Body.new(encode, nil, message, nil, thumbnail_rails_url))
          if i == Encode::THUMBNAIL_COUNT
            message = "Completed Extracting Thumbnail"
            Message::Send.call(Message::Event::THUMBNAIL_RAILS_URL, Message::Body.new(encode, nil, message, nil, thumbnail_rails_url))
          end
        end
      end

      cdn_bucket = ENV['CDN_BUCKET']
      thumbnail_relative_path = Storage::Url::Relative::Thumbnail.call(encode)
      thumbnail_local_full_path = Storage::Path::Local::Thumbnail.call(encode)
      move_thumbnail_to_cdn_cmd = `sh app/encoding/mv.sh #{cdn_bucket} #{thumbnail_relative_path} #{thumbnail_local_full_path}`
      Sidekiq.logger.debug "move_thumbnail_to_cdn_cmd : #{move_thumbnail_to_cdn_cmd}"
      thumbnail_cdn_url = ""
      for asset in encode.assets
        thumbnail_cdn_url += (asset.url+"<br/>") if asset.format == 'image'
      end
      message = "Completed COPY Thumbnail To CDN"
      Message::Send.call(Message::Event::THUMBNAIL_CDN_URL, Message::Body.new(encode, nil, message, nil, thumbnail_cdn_url))
    end
  end
end