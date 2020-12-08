class Webhook < ApplicationRecord
  validates :url, presence: true
  validates :api_key, presence: true
  validates :method, presence: true
  scope :by_date, -> { order('id DESC') }
  enum methods: { post: "post", put: "put", get: "get"}
end
