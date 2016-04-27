class Form
  include Virtus.model

  attribute :payload, Hash

  def self.from_kibokan(hash)
    new(payload: hash)
  end

  def self.request_path(namespace, category)
    "namespaces/#{namespace}/categories/#{category}/forms"
  end
end
