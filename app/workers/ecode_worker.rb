class EcodeWorker
  include Sidekiq::Worker

  def perform(name, count)
    # do something
  end
end