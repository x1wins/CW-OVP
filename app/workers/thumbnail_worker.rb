class ThumbnailWorker
  include Sidekiq::Worker
  sidekiq_options retry: false # job will be discarded if it fails

  def perform(encode_id, base_url)
    encode = Encode.find(encode_id)
    if encode.file.attached?
      encode.file.open do |f|
        uploaded_file_path = f.path
        save_folder_path = encode.save_folder_path_thumbnail
        runtime = `sh app/encoding/runtime.sh #{uploaded_file_path}`
        mkdir_cmd = `sh app/encoding/mkdir.sh #{save_folder_path}`
        log = ""
        encode.send_message "Extracting Thumbnail Start", log, nil
        thumbnail_seconds = encode.thumbnail_seconds runtime
        for i in 1..Encode::THUMBNAIL_COUNT
          ss = thumbnail_seconds[i-1]
          thumbnail_filename = encode.thumbnail_filename ss, i
          thumbnail_full_path = "#{save_folder_path}/#{thumbnail_filename}"
          thumbnail_cmd = `sh app/encoding/thumbnail.sh #{uploaded_file_path} #{ss} #{thumbnail_full_path}`
          thumbnail_url = encode.thumbnail_url base_url, thumbnail_filename
          encode.assets.create(format: 'image', url: thumbnail_url)
          encode.thumbnails.attach(io: File.open(thumbnail_full_path), filename: thumbnail_filename, content_type: "image/png")
          thumbnail_rails_url = Rails.application.routes.url_helpers.rails_blob_path(encode.thumbnails.last, disposition: "attachment", only_path: true)
          encode.send_message "Extracted #{i}th Thumbnail", log, nil, thumbnail_rails_url
          if i == Encode::THUMBNAIL_COUNT
            encode.send_message "Extracting Thumbnail Completed", log, nil
          end
        end
      end
      save_folder_path_thumbnail = encode.save_folder_path_thumbnail
      file_path_thumbnail = encode.file_path_thumbnail
      cdn_bucket = ENV['CDN_BUCKET']
      cp_thumbnail_to_cdn_cmd = `sh app/encoding/cp.sh #{cdn_bucket} #{file_path_thumbnail} #{save_folder_path_thumbnail}`
      Sidekiq.logger.debug "cp_thumbnail_to_cdn_cmd : #{cp_thumbnail_to_cdn_cmd}"
    end
  end
end