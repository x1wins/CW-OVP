module Message
  class Body
    attr_reader :encode, :percentage, :log, :filename, :thumbnail_url
    def initialize(encode, percentage, log, filename, thumbnail_url)
      @percentage = percentage
      @log = log
      @log << "\n" if log.present?
      @filename = filename
      @thumbnail_url = thumbnail_url
      @encode = encode
    end
  end
end