class Entity
  include Virtus.model

  attribute :name,    String
  attribute :payload, Hash
  attribute :id,      String

  def self.from_kibokan(hash)
    new(
      name: hash[:_name],
      payload: hash,
      id: hash[:_id]
    )
  end

  def self.request_path(namespace, category)
    "namespaces/#{namespace}/categories/#{category}"
  end
end
