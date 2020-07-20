class Encode < ApplicationRecord
  belongs_to :user
  has_one_attached :file
  validates :title, presence: true
  validates :file, presence: true, blob: { content_type: :video } # supported options: :image, :audio, :video, :text
  scope :published, -> { where(published: true) }
  scope :by_date, -> { order('id DESC') }
  before_create :default_values
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
  def send_message message, log
    log << message.to_s+"\n"
    ActionCable.server.broadcast "encode_channel", content: message.to_s+"\n", encode_id: self.id
  end
end
