def load_config(key, filepath)
  config = YAML::load(
    ERB.new(IO.read('config/global_config.yml')).result
  )[Rails.env]

  Rails.application.config.send(
    "#{key}=".to_sym,
    ActiveSupport::InheritableOptions.new(config.deep_symbolize_keys)
  )
end

load_datas = {
  global_config: 'config/global_config.yml',
}

load_datas.each do |key, path|
  load_config(key, path)
end
