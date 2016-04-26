class Entity
  include Virtus.model

  attribute :name,    String
  attribute :payload, Hash
  attribute :id,      String

  def self.from_kibokan(hash)
    new(
      name: hash[:_name],
      payload: hash[:payload],
      id: hash[:_id]
    )
  end
end
