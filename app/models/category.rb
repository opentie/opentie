class Category
  include Virtus.model

  attribute :namespace, String
  attribute :name, String
  attribute :payload, Hash, default: default_payload

  def default_payload
    return if self.payload

    path = Kibokan::Agent.
      generate_request_path(self.namespace, self.name)

    self.payload = Kibokan::Agent.new(path).get
  end

  def self.all(namespace)
    path = "namespaces/#{namespace}/categories"
    categories = Kibokan::Agent.new(path).get
    categories.map do |c|
      Category.new(
        namespace: namespace,
        name: c[:_name],
        payload: c
      )
    end
  end

  def self.request_path(namepsace)
    "namespaces/#{namespace}/categories"
  end
end
