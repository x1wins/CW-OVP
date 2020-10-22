class ThumbnailWorker
  include Sidekiq::Worker
  sidekiq_options retry: false # job will be discarded if it fails

  def perform(encode_id, base_url)
    encode = Encode.find(encode_id)
    if encode.file.attached?
      encode.file.open do |f|
        uploaded_file_path = f.path
        thumbnail_local_full_path = Storage::Path::Local::Thumbnail.call(encode)
        runtime = `sh app/encoding/runtime.sh #{uploaded_file_path}`
        mkdir_cmd = `sh app/encoding/mkdir.sh #{thumbnail_local_full_path}`
        log = ""
        encode.send_message "Extracting Thumbnail Start", log, nil
        thumbnail_seconds = encode.thumbnail_seconds runtime
        for i in 1..Encode::THUMBNAIL_COUNT
          ss = thumbnail_seconds[i-1]
          thumbnail_filename = encode.thumbnail_filename ss, i
          thumbnail_file_full_path = "#{thumbnail_local_full_path}/#{thumbnail_filename}"
          thumbnail_cmd = `sh app/encoding/thumbnail.sh #{uploaded_file_path} #{ss} #{thumbnail_file_full_path}`
          thumbnail_url = Storage::Url::Full::Thumbnail.call(encode, base_url, thumbnail_filename)
          encode.assets.create(format: 'image', url: thumbnail_url)
          encode.thumbnails.attach(io: File.open(thumbnail_file_full_path), filename: thumbnail_filename, content_type: "image/png")
          thumbnail_rails_url = Rails.application.routes.url_helpers.rails_blob_path(encode.thumbnails.last, disposition: "attachment", only_path: true)
          encode.send_message "Extracted #{i}th Thumbnail", log, nil, thumbnail_rails_url
          if i == Encode::THUMBNAIL_COUNT
            encode.send_message "Extracting Thumbnail Completed", log, nil
          end
        end
      end

      cdn_bucket = ENV['CDN_BUCKET']
      thumbnail_relative_path = Storage::Url::Relative::Thumbnail.call(encode)
      thumbnail_local_full_path = Storage::Path::Local::Thumbnail.call(encode)
      move_thumbnail_to_cdn_cmd = `sh app/encoding/mv.sh #{cdn_bucket} #{thumbnail_relative_path} #{thumbnail_local_full_path}`
      Sidekiq.logger.debug "move_thumbnail_to_cdn_cmd : #{move_thumbnail_to_cdn_cmd}"
      message = ""
      for asset in encode.assets
        message += (asset.url+"<br/>") if asset.format == 'image'
      end
      encode.send_message message, "", "100%", nil, "cp_thumbnail"
    end
  end
end