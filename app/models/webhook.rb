class Webhook < ApplicationRecord
  scope :by_date, -> { order('id DESC') }
end
