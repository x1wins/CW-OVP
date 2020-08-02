class ThumbnailWorker
  include Sidekiq::Worker
  sidekiq_options retry: false # job will be discarded if it fails

end