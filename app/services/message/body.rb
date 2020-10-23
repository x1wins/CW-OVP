class Body
  attr_reader :object, :message
  def initialize(object, message)
    @object = object
    @message = message
  end
end