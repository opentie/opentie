module Kibokan
  class NotFound < StandardError; end
  class RecordInvalid < StandardError; end
  class ServerError < StandardError; end

  class << self
    attr_accessor :kibokan_host
  end
end
