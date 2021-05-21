class Webhook < ApplicationRecord
  validates :url, presence: true, format: URI::regexp(%w[http https])
  validates :api_key, presence: true
  METHOD_OPTIONS = %w(post put get)
  validates :method, :inclusion => {:in => METHOD_OPTIONS}
  scope :by_date, -> { order('id DESC') }
  scope :active, -> { where(is_active: true) }
  enum methods: { post: "post", put: "put", get: "get"}
end
