class Kibokan::RequestAgent
  def initialize(path)
    @path = path
    host = Kibokan.kibokan_host
    @agent = Faraday.new(url: "http://#{host}") do |builder|
      builder.request  :json
      builder.response :logger
      builder.adapter  :net_http
    end
  end

  def show
    return sample_response if Rails.env.test?
    response = @agent.get(@path)
    check_status(response.status)
    serialize(response.body)
  end

  def index
    return sample_responses if Rails.env.test?
    response = @agent.get(@path)
    check_status(response.status)
    serialize(response.body)
  end

  def new
    return sample_response if Rails.env.test?
    response = @agent.get(@path + '/new')
    check_status(response.status)
    serialize(response.body)
  end

  def create(params)
    return sample_response if Rails.env.test?
    response = @agent.post(@path, params)
    check_status(response.status)
    serialize(response.body)
  end

  def update(params)
    return sample_response if Rails.env.test?
    response = @agent.put(@path, params)
    check_status(response.status)
    serialize(response.body)
  end

  def bulk(params)
    return sample_responses(params) if Rails.env.test?
    response = @agent.post(@path + '/bulk', params)
    check_status(response.status)
    serialize(response.body)
  end

  def where(query)
    return sample_responses if Rails.env.test?
    response = @agent.get(@path, { q: query })
    check_status(response.status)
    serialize(response.body)
  end

  private

  def serialize(body)
    JSON.parse(body, symbolize_names: true)
  end

  def sample_responses(params=nil)
    unless params
      [{
        _id: "idididiid",
        _name: "namenamename",
        payload: { data: "data" }
       }]
    else
      params[:ids].map do |id|
        {
          _id: id,
          _name: "namenamename",
          payload: { data: "data" }
        }
      end
    end
  end

  def sample_response
    {
      _id: "idididiid",
      _name: "namenamename",
      payload: { data: "data" }
    }
  end

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
