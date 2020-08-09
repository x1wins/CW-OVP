class Encode < ApplicationRecord
  belongs_to :user
  has_one_attached :file
  has_many_attached :thumbnails
  validates :title, presence: true
  validate :file_format
  scope :published, -> { where(published: true) }
  scope :by_date, -> { order('id DESC') }
  before_create :default_values
  VALIDATED_FILE_EXTENSIONS = %w( .ts .mp4 .mov .avi .mkv )
  THUMBNAIL_COUNT = 10

  def default_values
    self.started_at ||= Time.now
    self.published ||= true
    self.completed ||= false
  end

  def file_path
    yyyy = self.created_at.strftime("%Y")
    mm = self.created_at.strftime("%m")
    dd = self.created_at.strftime("%d")
    id = self.id
    "#{yyyy}/#{mm}/#{dd}/#{id}/hls"
  end

  def save_folder_path
    "public/#{self.file_path}"
  end

  def playlist_m3u8_url base_url
    "#{base_url}/#{self.file_path}/playlist.m3u8"
  end

  def send_message message, log, percentage = "0%", thumbnail_url = nil
    log << message.to_s+"\n"
    ActionCable.server.broadcast "encode_channel", encode_id: self.id, content: message.to_s+"\n", percentage: percentage, encode: self, filename: self.file.filename, thumbnail_url: thumbnail_url
    Rails.logger.debug "percentage: #{percentage}"
  end

  def percentage now_time = nil, total_time = nil
    if now_time.nil? or total_time.nil?
      percentage = "0%"
    else
      percentage = (self.convert_to_second(now_time) / self.convert_to_second(total_time) * 100).truncate(2)
      percentage = 100 if percentage > 100
      percentage.to_s + "%"
    end
  end

  def convert_to_second time
    (Time.parse(time).to_i - Date.today.to_time.to_i).to_f
  end

  def file_format
    if !file.attached?
      errors[:file] << " must not blank"
    elsif !file.attached? and self.file.signed_id.nil?
      errors[:file] << " must not blank"
    elsif !valid_extension? self.file.filename.to_s
      errors[:file] << "Invalid format."
    end
  end

  def valid_extension?(filename)
    ext = File.extname(filename)
    VALIDATED_FILE_EXTENSIONS.include? ext.downcase
  end

  def rand_second total_time = nil
    if total_time.nil?
      return "00:00:00.000"
    end
    end_second = convert_to_second total_time
    prng = Random.new
    seconds = prng.rand(0...end_second.floor)
    Time.at(seconds).utc.strftime("%H:%M:%S.%L")
  end

  def extract_thumbnail runtime, uploaded_file_path, save_folder_path, i
    ss = self.rand_second(runtime)
    thumbnail_filename = "#{self.id}_#{i}_thumbnail.png"
    thumbnail_full_path = "#{save_folder_path}/#{thumbnail_filename}"
    thumbnail_cmd = `sh app/encoding/thumbnail.sh #{uploaded_file_path} #{ss} #{thumbnail_full_path}`
    Rails.logger.debug "thumbnail_cmd : #{thumbnail_cmd}"
    Rails.logger.debug "thumbnail full path : #{thumbnail_full_path}"
    self.thumbnails.attach(io: File.open(thumbnail_full_path), filename: thumbnail_filename, content_type: "image/png")
    thumbnail_url = Rails.application.routes.url_helpers.rails_blob_path(self.thumbnails.last, disposition: "attachment", only_path: true)
  end

end
