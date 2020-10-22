class Encode < ApplicationRecord
  belongs_to :user
  has_one_attached :file
  has_many_attached :thumbnails
  has_many :assets
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

  def send_message message, log, percentage = "0%", thumbnail_url = nil, type = nil
    log << message.to_s+"\n"
    ActionCable.server.broadcast "encode_channel", encode_id: self.id, content: message.to_s+"\n", percentage: percentage, encode: self, filename: self.file.filename, thumbnail_url: thumbnail_url, type: type
    Rails.logger.debug "percentage: #{percentage}"
  end

  def cdn_cp_percentage total_file_count, file_number
    ((total_file_count - file_number).to_f / total_file_count.to_f * 100)
  end

  def encode_percentage now_time = nil, total_time = nil
    if now_time.nil? or total_time.nil?
      percentage = 0
    else
      percentage = (self.convert_to_second(now_time) / self.convert_to_second(total_time) * 100)
      percentage = 100 if percentage > 100
    end
    percentage
  end

  def cdn_cp_half_percentage total_file_count, file_number
    self.cdn_cp_percentage(total_file_count, file_number)/2
  end

  def encode_half_percentage now_time = nil, total_time = nil
    self.encode_percentage(now_time, total_time)/2
  end

  def percentage_to_s percentage
    self.rount_off_two_decial_place(percentage).to_s + "%"
  end

  def rount_off_two_decial_place percentage
    '%.2f' % percentage
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

  def thumbnail_filename ss, i
    "#{i}_#{ss.gsub(':', '_').gsub('.', '_')}.png"
  end

  def thumbnail_seconds runtime
    ss_lists = []
    for i in 1..Encode::THUMBNAIL_COUNT
      ss_lists << self.rand_second(runtime)
    end
    ss_lists.sort_by(&:to_s)
  end

end
