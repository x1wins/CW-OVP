class ThumbnailWorker
  include Sidekiq::Worker
  sidekiq_options retry: false # job will be discarded if it fails

  def perform(encode_id)
    encode = Encode.find(encode_id)
    if encode.file.attached?
      encode.file.open do |f|
        uploaded_file_path = f.path
        save_folder_path = encode.save_folder_path
        duration_output_cmd = `sh app/encoding/duration.sh #{uploaded_file_path}`
        mkdir_cmd = `sh app/encoding/mkdir.sh #{save_folder_path}`
        log = ""
        encode.send_message "Extracting Thumbnail Start", log, nil
        for i in 1..Encode::THUMBNAIL_COUNT
          thumbnail_url = encode.extract_thumbnail duration_output_cmd, uploaded_file_path, save_folder_path, i
          encode.send_message "Extracted #{i}th Thumbnail", log, nil, thumbnail_url
          if i == Encode::THUMBNAIL_COUNT
            encode.send_message "Extracting Thumbnail Completed", log, nil
          end
        end
      end
    end
  end
end