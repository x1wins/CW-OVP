class Encode < ApplicationRecord
  belongs_to :user
  has_one_attached :file
  validates :title, presence: true
  validate :file_format
  scope :published, -> { where(published: true) }
  scope :by_date, -> { order('id DESC') }
  before_create :default_values
  VALIDATED_FILE_EXTENSIONS = %w( .ts .mp4 .mov .avi .mkv )

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
    "hls/#{yyyy}/#{mm}/#{dd}/#{id}"
  end
  def send_message message, log, percentage = "0%"
    log << message.to_s+"\n"
    ActionCable.server.broadcast "encode_channel", encode_id: self.id, content: message.to_s+"\n", percentage: percentage, encode: self
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
end
