class Category
  include Virtus.model
  include ActiveModel::Validations

  attribute :namespace, String
  attribute :name, String
  attribute :payload, Hash

  validates :name, :namespace, presence: true

  def initialize(*params)
    super
    self.payload = get_payload
    self
  end

  def self.all(namespace)
    path = request_path(namespace)
    categories = Kibokan::RequestAgent.new(path).index

    categories.map do |c|
      Category.new(
        namespace: namespace,
        name: c[:_name]
      )
    end
  end

  def self.create(namespace, params)
    path = request_path(namespace)
    params[:namespace] = namespace
    body = Kibokan::RequestAgent.new(path).create(params)

    new(
      payload: body,
      namespace: namespace,
      name: body[:_name]
    )
  end

  def self.request_path(namespace)
    "namespaces/#{namespace}/categories"
  end

  def update(params)
    path = self.class.request_path(self.namespace)
    body = Kibokan::RequestAgent.new(path).update(params)

    self.payload = body
    self.name = body[:_name]
    self
  end

  def create_form(params)
    path = Form.request_path(self.namespace, self.name)

    form_body = Kibokan::RequestAgent.new(path).create(params)
    Form.from_kibokan(form_body)
  end

  def get_form(form_id)
    path = Form.request_path(self.namespace, self.name) + "/#{form_id}"

    form_body = Kibokan::RequestAgent.new(path).show
    Form.from_kibokan(form_body)
  end

  def get_forms(form_ids=nil)
    path = Form.request_path(self.namespace, self.name)

    form_bodies = nil
    if form_ids.nil?
      form_bodies = Kibokan::RequestAgent.new(path).index
    else
      form_bodies = Kibokan::RequestAgent.new(path).bulk({ ids: form_ids })
    end

    form_bodies.map do |form_body|
      Form.from_kibokan(form_body)
    end
  end

  private

  def get_payload
    path = self.class.request_path(self.namespace) + "/#{self.name}"
    Kibokan::RequestAgent.new(path).show
  end
end
