class Encode < ApplicationRecord
  belongs_to :user
  has_one_attached :file
  validates :title, presence: true
  validates :file, presence: true, blob: { content_type: :video } # supported options: :image, :audio, :video, :text
  scope :published, -> { where(published: true) }
  scope :by_date, -> { order('id DESC') }
  before_save :default_values
  def default_values
    self.started_at ||= Time.now
    self.published ||= true
    self.completed ||= false
  end
end
