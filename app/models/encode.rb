class Encode < ApplicationRecord
  belongs_to :user
  has_one_attached :file
  validates :file, presence: true, blob: { content_type: :video } # supported options: :image, :audio, :video, :text
  scope :published, -> { where(published: true) }
  scope :by_date, -> { order('id DESC') }
end
