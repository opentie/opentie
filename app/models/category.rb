class Category
  include Virtus.model

  attribute :namespace, String
  attribute :name, String

  def payload
    path = self.class.request_path + "#{self.name}"
    Kibokan::Agent.new(path).get
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
