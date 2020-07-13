class Encode < ApplicationRecord
  belongs_to :user
  has_one_attached :file
  validates :file, presence: true, blob: { content_type: :video } # supported options: :image, :audio, :video, :text
  before_save :default_values
  def default_values
    self.published = true
    self.completed = false
  end
end
