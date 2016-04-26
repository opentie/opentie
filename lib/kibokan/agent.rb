class Kibokan::Agent

  def initialize(path)
    @path = path
    host = Rails.application.config.global_config.kibokan_host
    @agent = Faraday.new(url: "http://#{host}") do |builder|
      builder.request  :url_encoded
      builder.response :logger
      builder.adapter  :net_http
    end
  end

  def self.generate_request_path(namespace, category)
    "/namespaces/#{namespace}/categories/#{category}"
  end

  def get
    response = @agent.get(@path)
    check_status(response.status)
    JSON.parse(response.body)
  end

  def post(params)
    response = @agent.post(@path, params)
    check_status(response.status)
    JSON.parse(response.body)
  end

  def put(params)
    response = @agent.put(@path, params)
    check_status(response.status)
    JSON.parse(response.body)
  end

  def bulk
    response = @agent.post(@path ,params)
    check_status(response.status)
    JSON.parse(response.body)
  end

  def search(query)
    response = @agent.get(@path, { q: query })
    check_status(response.status)
    JSON.parse(response.body)
  end

  private

  def check_status(status)
    case status
    when 200..299
      true
    when 404
      raise Kibokan::NotFound
    when 400
      raise Kibokan::RecordInvalid
    else
      raise Kibokan::ServerError
    end
  end
end
