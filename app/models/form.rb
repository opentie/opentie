class Form
  include Virtus.model

  attribute :payload, Hash

  def self.from_kibokan(hash)
    new(payload: hash)
  end
end
