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
  after_create_commit :run_worker
  VALIDATED_FILE_EXTENSIONS = %w( .ts .mp4 .mov .avi .mkv )
  THUMBNAIL_COUNT = 10

  def run_worker
    ThumbnailWorker.perform_async(self.id)
    EncodeWorker.perform_async(self.id)
  end

  def default_values
    self.started_at ||= Time.now
    self.published ||= true
    self.completed ||= false
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
    end_second = Percentage::ConvertToSecond.call(total_time)
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
