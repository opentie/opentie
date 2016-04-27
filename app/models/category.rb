class Category
  include Virtus.model

  attribute :namespace, String
  attribute :name, String
  attribute :payload, Hash, default: default_payload

  def default_payload
    path = Kibokan::Agent.
      generate_request_path(self.namespace, self.name)

    self.payload = Kibokan::Agent.new(path).get
  end

  def self.all(namespace)
    path = "namespaces/#{namespace}/categories"
    Kibokan::Agent.new(path).get
  end

  def self.request_path(namepsace)
    "namespaces/#{namespace}/categories"
  end
end
